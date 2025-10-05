/* YAEP Unicode Support Wrapper Implementation
 *
 * This module wraps utf8proc to provide Unicode text handling for YAEP.
 * See yaep_unicode.h for API documentation.
 *
 * Copyright (c) 2025
 * Licensed under the same terms as YAEP (MIT License).
 */

#include "yaep_unicode.h"
#include "utf8proc.h"
#include <string.h>
#include <stdlib.h>
#include <stdint.h>
/* allocate.h defines the YaepAllocator and allocation helpers. It lives
  in the project's include path; include it if available. */
#if 0
/* Avoid including allocate.h here to keep the unicode wrapper header-light.
  We'll forward-declare the minimal allocator functions we need below. */
#include "allocate.h"
#endif

/* Forward declarations for the YAEP allocator helpers used by the
  normalization helper. These match the signatures declared in
  src/allocate.h; we keep them local to avoid depending on the
  full allocate.h in this translation unit. */
typedef struct YaepAllocator YaepAllocator;
void *yaep_malloc(YaepAllocator *allocator, size_t size);
void yaep_free(YaepAllocator *allocator, void *ptr);

/* UTF-8 Iterator with ASCII Fast Path
 *
 * For maximum performance on predominantly-ASCII grammars (the common case),
 * we check for single-byte characters first before calling into utf8proc.
 * This avoids the overhead of the full Unicode property lookup for simple
 * ASCII text.
 */
yaep_codepoint_t yaep_utf8_next(const char **str_ptr)
{
  const unsigned char *str = (const unsigned char *)*str_ptr;
  
  /* Handle NULL pointer gracefully */
  if (str == NULL || *str == '\0') {
    return YAEP_CODEPOINT_EOS;
  }
  
  /* ASCII fast path: single-byte characters (0x00-0x7F) */
  if (*str < 0x80) {
    *str_ptr = (const char *)(str + 1);
    return (yaep_codepoint_t)*str;
  }
  
  /* Multi-byte UTF-8 sequence: delegate to utf8proc */
  utf8proc_int32_t codepoint;
  utf8proc_ssize_t bytes_read = utf8proc_iterate(str, -1, &codepoint);
  
  if (bytes_read < 0) {
    /* Decoding error: advance by 1 byte to allow recovery and return invalid */
    *str_ptr = (const char *)(str + 1);
    return YAEP_CODEPOINT_INVALID;
  }
  
  /* Success: advance pointer past the decoded sequence */
  *str_ptr = (const char *)(str + bytes_read);
  return (yaep_codepoint_t)codepoint;
}

yaep_codepoint_t yaep_utf8_next_with_len(const char **str_ptr, size_t *bytes_len_out)
{
  const char *s = *str_ptr;
  if (bytes_len_out)
    *bytes_len_out = 0;

  if (!s || *s == '\0')
    return YAEP_CODEPOINT_EOS;

  unsigned char c = (unsigned char)*s;
  size_t need = 0;
  yaep_codepoint_t cp = 0;

  if (c < 0x80) {
    cp = c;
    need = 1;
  } else if ((c & 0xE0) == 0xC0) {
    unsigned char c1 = (unsigned char)s[1];
    if ((c1 & 0xC0) != 0x80) return YAEP_CODEPOINT_INVALID;
    cp = ((c & 0x1F) << 6) | (c1 & 0x3F);
    need = 2;
  } else if ((c & 0xF0) == 0xE0) {
    unsigned char c1 = (unsigned char)s[1];
    unsigned char c2 = (unsigned char)s[2];
    if ((c1 & 0xC0) != 0x80 || (c2 & 0xC0) != 0x80) return YAEP_CODEPOINT_INVALID;
    cp = ((c & 0x0F) << 12) | ((c1 & 0x3F) << 6) | (c2 & 0x3F);
    need = 3;
  } else if ((c & 0xF8) == 0xF0) {
    unsigned char c1 = (unsigned char)s[1];
    unsigned char c2 = (unsigned char)s[2];
    unsigned char c3 = (unsigned char)s[3];
    if ((c1 & 0xC0) != 0x80 || (c2 & 0xC0) != 0x80 || (c3 & 0xC0) != 0x80) return YAEP_CODEPOINT_INVALID;
    cp = ((c & 0x07) << 18) | ((c1 & 0x3F) << 12) | ((c2 & 0x3F) << 6) | (c3 & 0x3F);
    need = 4;
  } else {
    return YAEP_CODEPOINT_INVALID;
  }

  if (bytes_len_out)
    *bytes_len_out = need;

  *str_ptr += need;
  return cp;
}

/* UTF-8 Validation
 *
 * Walks the entire string using yaep_utf8_next to ensure all sequences
 * are well-formed. Also counts the number of code points for the caller's
 * convenience (useful for pre-allocating buffers or progress reporting).
 */
int yaep_utf8_validate(const char *str, size_t *len,
                       size_t *error_offset, int *error_code)
{
  const unsigned char *p = (const unsigned char *)str;
  size_t count = 0;
  size_t offset = 0;

  if (error_offset != NULL) {
    *error_offset = 0;
  }
  if (error_code != NULL) {
    *error_code = 0;
  }

  if (str == NULL) {
    return 1;
  }

  while (*p != '\0') {
    utf8proc_int32_t cp = 0;
    utf8proc_ssize_t step = utf8proc_iterate(p, -1, &cp);
    if (step < 0) {
      if (len != NULL) {
        *len = count;
      }
      if (error_offset != NULL) {
        *error_offset = offset;
      }
      if (error_code != NULL) {
        *error_code = (int)step;
      }
      return 0;
    }
    p += step;
    offset += (size_t)step;
    count++;
  }

  if (len != NULL) {
    *len = count;
  }
  if (error_offset != NULL) {
    *error_offset = offset;
  }
  return 1;
}

/* Character Classification: Alphabetic
 *
 * Uses utf8proc's category lookup to identify letters. The Unicode
 * standard defines several letter categories (Lu, Ll, Lt, Lm, Lo)
 * which we treat uniformly as "alphabetic".
 */
int yaep_utf8_isalpha(yaep_codepoint_t cp)
{
  /* ASCII fast path: A-Z and a-z */
  if (cp >= 0 && cp < 128) {
    return (cp >= 'A' && cp <= 'Z') || (cp >= 'a' && cp <= 'z');
  }
  
  /* Invalid or EOS code points are not alphabetic */
  if (cp < 0) {
    return 0;
  }
  
  /* Query the Unicode Character Database via utf8proc */
  const utf8proc_property_t *prop = utf8proc_get_property(cp);
  
  /* Check if the category is any of the Letter categories:
   * Lu (Uppercase Letter), Ll (Lowercase Letter), Lt (Titlecase Letter),
   * Lm (Modifier Letter), Lo (Other Letter)
   */
  return (prop->category == UTF8PROC_CATEGORY_LU ||
          prop->category == UTF8PROC_CATEGORY_LL ||
          prop->category == UTF8PROC_CATEGORY_LT ||
          prop->category == UTF8PROC_CATEGORY_LM ||
          prop->category == UTF8PROC_CATEGORY_LO);
}

/* Character Classification: Decimal Digit
 *
 * Identifies decimal digit characters from any script. This includes
 * ASCII 0-9 as well as digits from other writing systems.
 */
int yaep_utf8_isdigit(yaep_codepoint_t cp)
{
  /* ASCII fast path: 0-9 */
  if (cp >= '0' && cp <= '9') {
    return 1;
  }
  
  /* Invalid or EOS code points are not digits */
  if (cp < 0) {
    return 0;
  }
  
  /* Query the Unicode Character Database via utf8proc */
  const utf8proc_property_t *prop = utf8proc_get_property(cp);
  
  /* Check if the category is Nd (Decimal Number) */
  return (prop->category == UTF8PROC_CATEGORY_ND);
}

/* Character Classification: Alphanumeric
 *
 * Combines alphabetic and digit checks. This is the typical predicate
 * for identifier continuation characters in most programming languages.
 */
int yaep_utf8_isalnum(yaep_codepoint_t cp)
{
  /* ASCII fast path: combine the ASCII checks inline */
  if (cp >= 0 && cp < 128) {
    return ((cp >= 'A' && cp <= 'Z') || 
            (cp >= 'a' && cp <= 'z') || 
            (cp >= '0' && cp <= '9'));
  }
  
  /* Invalid or EOS code points are not alphanumeric */
  if (cp < 0) {
    return 0;
  }
  
  /* Query the Unicode Character Database via utf8proc */
  const utf8proc_property_t *prop = utf8proc_get_property(cp);
  
  /*
   * UAX #31 permits combining marks (Mn, Mc) and connector punctuation (Pc)
   * in identifier continuation positions.  We include them here so the lexer
   * can accept decomposed forms such as "x\u0338_var" without splitting the
   * token mid-way.
   */
  return (prop->category == UTF8PROC_CATEGORY_LU ||
          prop->category == UTF8PROC_CATEGORY_LL ||
          prop->category == UTF8PROC_CATEGORY_LT ||
          prop->category == UTF8PROC_CATEGORY_LM ||
          prop->category == UTF8PROC_CATEGORY_LO ||
          prop->category == UTF8PROC_CATEGORY_ND ||
          prop->category == UTF8PROC_CATEGORY_MN ||
          prop->category == UTF8PROC_CATEGORY_MC ||
          prop->category == UTF8PROC_CATEGORY_PC);
}

/* Character Classification: Whitespace
 *
 * Identifies Unicode whitespace characters. This includes the ASCII
 * whitespace characters (space, tab, newline, etc.) plus Unicode
 * space separators and line/paragraph separators.
 */
int yaep_utf8_isspace(yaep_codepoint_t cp)
{
  /* ASCII fast path: common whitespace characters
   * Space (0x20), Tab (0x09), LF (0x0A), VT (0x0B), FF (0x0C), CR (0x0D)
   */
  if (cp >= 0 && cp < 128) {
    return (cp == ' ' || cp == '\t' || cp == '\n' || 
            cp == '\v' || cp == '\f' || cp == '\r');
  }
  
  /* Invalid or EOS code points are not whitespace */
  if (cp < 0) {
    return 0;
  }
  
  /* Query the Unicode Character Database via utf8proc */
  const utf8proc_property_t *prop = utf8proc_get_property(cp);
  
  /* Check for Space Separator categories or explicit whitespace property
   * Zs (Space Separator), Zl (Line Separator), Zp (Paragraph Separator)
   */
  return (prop->category == UTF8PROC_CATEGORY_ZS ||
          prop->category == UTF8PROC_CATEGORY_ZL ||
          prop->category == UTF8PROC_CATEGORY_ZP);
}

/* UTF-8 String Hashing with Unsigned Byte Treatment
 *
 * This hash function treats all bytes as unsigned to avoid sign-extension
 * issues. When a signed char with the high bit set is promoted to int,
 * it becomes negative on most platforms, which can cause hash instability.
 *
 * We use a simple multiplicative hash (FNV-1a style) which provides
 * reasonable distribution for short strings like grammar symbols.
 */
unsigned yaep_utf8_hash(const char *str)
{
  unsigned hash = 2166136261u;  /* FNV-1a offset basis (32-bit) */
  const unsigned char *p = (const unsigned char *)str;
  
  /* Process each byte as unsigned to avoid sign extension */
  while (*p != '\0') {
    hash ^= *p++;
    hash *= 16777619u;  /* FNV-1a prime (32-bit) */
  }
  
  return hash;
}

int yaep_utf8_digit_value(yaep_codepoint_t cp, int *value_out,
                          yaep_codepoint_t *block_start)
{
  if (value_out == NULL || block_start == NULL) {
    return 0;
  }

  if (cp >= '0' && cp <= '9') {
    *value_out = (int)(cp - '0');
    *block_start = '0';
    return 1;
  }

  if (cp < 0) {
    return 0;
  }

  const utf8proc_property_t *prop = utf8proc_get_property(cp);
  if (prop->category != UTF8PROC_CATEGORY_ND) {
    return 0;
  }

  yaep_codepoint_t start = cp;
  while (start > 0) {
    const utf8proc_property_t *prev = utf8proc_get_property(start - 1);
    if (prev->category != UTF8PROC_CATEGORY_ND) {
      break;
    }
    start--;
  }

  *block_start = start;
  int value = (int)(cp - start);
  if (value < 0 || value > 9) {
    return 0;
  }
  *value_out = value;
  return 1;
}

/* Error Message Lookup
 *
 * Translates utf8proc error codes to human-readable messages.
 * This is primarily used for diagnostic output when invalid UTF-8
 * is encountered during grammar parsing.
 */
const char *yaep_utf8_error_message(int error_code)
{
  /* utf8proc returns negative error codes on failure.
   * The utf8proc_errmsg function provides descriptive text.
   */
  if (error_code >= 0) {
    return "No error";
  }
  
  /* Delegate to utf8proc's error message function */
  return utf8proc_errmsg(error_code);
}

/* yaep_utf8_truncate_safe implementation
 *
 * We copy full bytes until dst_size is exhausted. If the last byte in
 * dst would be a UTF-8 continuation byte (0x80..0xBF), back up to the
 * last valid code point boundary. If truncation occurs and there is
 * space, append "..." to indicate truncation. Always NUL-terminate
 * dst when dst_size > 0.
 */
int
yaep_utf8_truncate_safe(const char *src, char *dst, size_t dst_size)
{
  if (dst_size == 0)
    return 0;

  size_t max_copy = dst_size - 1; /* reserve NUL */
  (void) src; /* src is used via strlen and memcpy below - suppress unused warnings */

  /* Fast path: entire string fits */
  size_t src_len = strlen(src);
  if (src_len <= max_copy) {
    memcpy(dst, src, src_len);
    dst[src_len] = '\0';
    return 1; /* no truncation */
  }

  /* Copy up to max_copy bytes */
  memcpy(dst, src, max_copy);

  /* If the last byte is an ASCII byte (0x00-0x7F), we're aligned. */
  if ((unsigned char)dst[max_copy - 1] < 0x80) {
    /* We truncated but ended on ASCII boundary. Append ellipsis if fits. */
    size_t ellipsis_len = 3;
    if (max_copy >= ellipsis_len) {
      /* Overwrite the last ellipsis_len bytes with dots. */
      size_t start = max_copy - ellipsis_len;
      dst[start] = '.'; dst[start+1] = '.'; dst[start+2] = '.';
      dst[max_copy] = '\0';
    } else {
      dst[max_copy] = '\0';
    }
    return 0;
  }

  /* We may have cut a multi-byte sequence. We want to find the last
   * code point start index `start_idx` such that the entire code point
   * fits within the first `max_copy` bytes. We prefer to append a
   * 3-byte ASCII ellipsis "..." when an earlier code point start
   * allows it; otherwise we NUL-terminate at the last whole code
   * point boundary. If no whole code point fits at all, we fall back
   * to writing "..." when dst_size >= 4 or an empty string otherwise. */

  size_t start_idx = (size_t)(-1);
  size_t scan_pos = max_copy;

  while (scan_pos > 0) {
    /* Find candidate start byte by backing up over continuation bytes */
    size_t st = scan_pos - 1;
    while (st > 0 && (((unsigned char)dst[st] & 0xC0) == 0x80))
      st--;

    unsigned char first = (unsigned char)dst[st];
    size_t seq_len = 1;
    if ((first & 0x80) == 0x00) seq_len = 1;
    else if ((first & 0xE0) == 0xC0) seq_len = 2;
    else if ((first & 0xF0) == 0xE0) seq_len = 3;
    else if ((first & 0xF8) == 0xF0) seq_len = 4;
    else {
      /* Invalid start byte; treat as no-fitting sequence and back up */
      if (st == 0) break;
      scan_pos = st;
      continue;
    }

    if (st + seq_len <= max_copy) {
      start_idx = st;
      break;
    }

    if (st == 0) break;
    /* Continue searching earlier in the buffer */
    scan_pos = st;
  }

  /* If no code point fits entirely, put ellipsis when possible. */
  if (start_idx == (size_t)(-1)) {
    if (dst_size >= 4) {
      dst[0] = '.'; dst[1] = '.'; dst[2] = '.'; dst[3] = '\0';
    } else {
      dst[0] = '\0';
    }
    return 0;
  }

  /* Try to find the latest start index `s` <= start_idx such that
   * s + ellipsis_len <= max_copy; this lets us append "..." and
   * keep the result valid UTF-8. If not found, we'll NUL-terminate
   * at start_idx. */
  size_t ellipsis_len = 3;
  size_t s = start_idx;
  while (1) {
    if (s + ellipsis_len <= max_copy) {
      /* We can write ellipsis starting at s */
      dst[s] = '.'; dst[s+1] = '.'; dst[s+2] = '.'; dst[s+3] = '\0';
      return 0;
    }

    /* Find previous code point start if any */
    if (s == 0) break;
    size_t prev = s - 1;
    while (prev > 0 && (((unsigned char)dst[prev] & 0xC0) == 0x80))
      prev--;
    s = prev;
  }

  /* No room for ellipsis at any earlier code point start; NUL-terminate
   * at the last whole code point start. */
  dst[start_idx] = '\0';
  return 0;
}

/* yaep_utf8_normalize_nfc
 *
 * NFC-normalize an input UTF-8 string `in`. This wrapper centralizes the
 * normalization policy (NFC) and ensures that memory ownership follows the
 * project's allocator conventions. The function uses utf8proc_NFC which
 * returns a buffer allocated with malloc(); we copy that into allocator-owned
 * memory using yaep_malloc (when an allocator is provided) and free the
 * intermediate buffer.
 *
 * The design goals here are:
 *  - deterministic normalization behavior (NFC) for symbol ingestion
 *  - no leaking of utf8proc's malloc'd buffers into YAEP ownership
 *  - clear failure semantics (returns 0 and sets *out = NULL)
 */
int
yaep_utf8_normalize_nfc(const char *in, char **out, YaepAllocator *alloc)
{
  if (out == NULL) return 0;
  *out = NULL;
  if (in == NULL) {
    /* Treat NULL input as empty string -> allocate empty string if requested. */
    if (alloc) {
      char *buf = (char *) yaep_malloc(alloc, 1);
      if (!buf) return 0;
      buf[0] = '\0';
      *out = buf;
      return 1;
    } else {
      char *buf = (char *) malloc(1);
      if (!buf) return 0;
      buf[0] = '\0';
      *out = buf;
      return 1;
    }
  }

  /* Use utf8proc's convenience NFC function which returns a malloc()-ed
     UTF-8 buffer on success or NULL on failure. */
  utf8proc_uint8_t *tmp = utf8proc_NFC((const utf8proc_uint8_t *) in);
  if (tmp == NULL) {
    return 0;
  }

  size_t len = strlen((const char *) tmp) + 1;

  if (alloc) {
    char *dst = (char *) yaep_malloc(alloc, len);
    if (!dst) {
      free(tmp);
      return 0;
    }
    memcpy(dst, tmp, len);
    *out = dst;
    free(tmp);
    return 1;
  } else {
    /* No allocator provided, return the malloc()'d buffer directly */
    *out = (char *) tmp;
    return 1;
  }
}
