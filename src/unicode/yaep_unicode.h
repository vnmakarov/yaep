/* YAEP Unicode Support Wrapper
 *
 * This module provides a thin abstraction layer over utf8proc for Unicode
 * text handling. The wrapper serves several purposes:
 *
 * 1. Isolates YAEP from direct utf8proc dependencies, allowing potential
 *    backend substitution if needed in the future.
 * 2. Provides a focused API tailored to YAEP's specific needs (character
 *    classification, validation, iteration).
 * 3. Adds ASCII fast paths to minimize overhead for common cases.
 * 4. Maintains consistent error handling conventions across the codebase.
 *
 * All public YAEP APIs that accept strings expect UTF-8 encoded text.
 * Invalid UTF-8 sequences will be detected and reported through the
 * normal YAEP error mechanisms.
 *
 * Copyright (c) 2025
 * Licensed under the same terms as YAEP (MIT License).
 */

#ifndef YAEP_UNICODE_H
#define YAEP_UNICODE_H

#include <stddef.h>
#include <stdint.h>

/* Forward declaration of the YAEP allocator type to avoid pulling
	allocation internals into this header. Consumers that need to
	manage allocator memory should include `allocate.h` directly. */
typedef struct YaepAllocator YaepAllocator;

#ifdef __cplusplus
extern "C" {
#endif

/* Unicode code point type - a 32-bit unsigned integer representing
 * a single Unicode scalar value (U+0000 to U+10FFFF, excluding surrogates).
 */
typedef int32_t yaep_codepoint_t;

/* Invalid codepoint sentinel - returned when UTF-8 decoding fails.
 * This value is never a valid Unicode scalar value.
 */
#define YAEP_CODEPOINT_INVALID (-1)

/* End-of-string sentinel - returned when iteration reaches the end
 * of the input string (i.e., encounters a NUL byte).
 */
#define YAEP_CODEPOINT_EOS (0)

/* UTF-8 Iterator
 *
 * Decodes the next UTF-8 code point from the input string and advances
 * the string pointer. This is the core iteration primitive for walking
 * UTF-8 text.
 *
 * Parameters:
 *   str_ptr: Pointer to a (const char *) that will be updated to point
 *            just past the decoded code point. If the input is invalid,
 *            the pointer is advanced by 1 byte to allow recovery.
 *
 * Returns:
 *   - A valid Unicode code point (0 to 0x10FFFF) if successful
 *   - YAEP_CODEPOINT_EOS (0) if *str_ptr points to a NUL terminator
 *   - YAEP_CODEPOINT_INVALID (-1) if the UTF-8 sequence is malformed
 *
 * ASCII Fast Path:
 *   For single-byte ASCII characters (0x00-0x7F), this function adds
 *   minimal overhead compared to simple pointer arithmetic.
 *
 * Example:
 *   const char *p = "Hello, 世界!";
 *   yaep_codepoint_t cp;
 *   while ((cp = yaep_utf8_next(&p)) != YAEP_CODEPOINT_EOS) {
 *     if (cp == YAEP_CODEPOINT_INVALID) {
 *       // Handle encoding error
 *     } else {
 *       // Process code point
 *     }
 *   }
 */
yaep_codepoint_t yaep_utf8_next(const char **str_ptr);

/* Variant of yaep_utf8_next that also returns the number of bytes
 * consumed for the decoded code point. This is useful for callers
 * that want to advance pointers by byte length without reparsing the
 * UTF-8 sequence. The function writes the number of bytes consumed to
 * `bytes_len_out` when non-NULL.
 *
 * Returns same values as yaep_utf8_next and sets *bytes_len_out to 0
 * when the return value is YAEP_CODEPOINT_EOS or YAEP_CODEPOINT_INVALID.
 */
yaep_codepoint_t yaep_utf8_next_with_len(const char **str_ptr, size_t *bytes_len_out);

/* UTF-8 Validation
 *
 * Validates that a string contains only well-formed UTF-8 sequences.
 * This is useful for validating input before storing it internally
 * or for early error detection.
 *
 * Parameters:
 *   str: NUL-terminated string to validate
 *   len: If non-NULL, receives the number of valid code points decoded
 *   error_offset: Receives the byte offset where validation failed (if any)
 *   error_code: Receives the utf8proc error code on failure, or 0 on success
 *
 * Returns:
 *   1 if the entire string is valid UTF-8, 0 otherwise
 *
 * Note: A string containing only ASCII (0x00-0x7F) is always valid UTF-8.
 */
int yaep_utf8_validate(const char *str, size_t *len,
					   size_t *error_offset, int *error_code);

/* Character Classification Predicates
 *
 * These functions classify Unicode code points according to the Unicode
 * Character Database properties. They are designed to replace the standard
 * C library isalpha/isalnum/isdigit functions which only handle ASCII.
 *
 * All predicates return 1 (true) or 0 (false).
 *
 * Implementation Note:
 *   These are backed by utf8proc's Unicode tables, which are regenerated
 *   for each Unicode version. The behavior may change slightly across
 *   Unicode versions, but will always conform to the Unicode standard.
 */

/* yaep_utf8_isalpha: Tests if a code point is an alphabetic character.
 *
 * Matches Unicode categories: Lu, Ll, Lt, Lm, Lo (all Letter categories).
 * This includes Latin letters, Greek, Cyrillic, CJK ideographs, etc.
 *
 * ASCII Fast Path: For code points 0-127, uses a simple range check.
 */
int yaep_utf8_isalpha(yaep_codepoint_t cp);

/* yaep_utf8_isdigit: Tests if a code point is a decimal digit.
 *
 * Matches Unicode category: Nd (Decimal Number).
 * This includes ASCII digits 0-9 and Unicode decimal digits from
 * other scripts (Arabic-Indic, Devanagari, etc.).
 *
 * ASCII Fast Path: For code points 0-127, uses a simple range check.
 */
int yaep_utf8_isdigit(yaep_codepoint_t cp);

/* yaep_utf8_isalnum: Tests if a code point is alphabetic, numeric, or an
 * allowed identifier continuation mark.
 *
 * Equivalent to (yaep_utf8_isalpha(cp) || yaep_utf8_isdigit(cp)) for ASCII,
 * and additionally returns true for combining marks (Mn/Mc) and connector
 * punctuation (Pc) so that decomposed identifiers conform to UAX #31.
 *
 * ASCII Fast Path: For code points 0-127, uses a simple range check.
 */
int yaep_utf8_isalnum(yaep_codepoint_t cp);

/* yaep_utf8_isspace: Tests if a code point is whitespace.
 *
 * Matches Unicode categories: Zs, Zl, Zp (Space Separator, Line Separator,
 * Paragraph Separator) plus the ASCII whitespace characters (tab, newline,
 * carriage return, etc.) which are control characters.
 *
 * ASCII Fast Path: For code points 0-127, uses a simple lookup.
 */
int yaep_utf8_isspace(yaep_codepoint_t cp);

/* Hash Helper for UTF-8 Strings
 *
 * Computes a hash value for a UTF-8 string by treating each byte as
 * unsigned. This avoids sign-extension issues when high-bit bytes
 * (UTF-8 continuation bytes) are cast to signed char on some platforms.
 *
 * Parameters:
 *   str: NUL-terminated UTF-8 string to hash
 *
 * Returns:
 *   A hash value suitable for use in hash tables. The hash function
 *   is not cryptographically secure and may produce collisions.
 *
 * Implementation Note:
 *   This function processes raw bytes and does not decode UTF-8.
 *   It is safe to call on any byte string, valid UTF-8 or not.
 *   The caller is responsible for ensuring valid UTF-8 if semantic
 *   correctness depends on it.
 */
unsigned yaep_utf8_hash(const char *str);

/* yaep_utf8_digit_value
 *
 * Returns the decimal value of the given Unicode digit (general category Nd)
 * and exposes the code point of the zero digit for the script block.  The
 * lexer relies on the block start to reject mixed-script numeric literals.
 *
 * Parameters:
 *   cp          - Code point to examine.
 *   value_out   - Receives the decimal value (0-9) on success.
 *   block_start - Receives the code point corresponding to the digit zero in
 *                 the same block as `cp` (i.e., cp - value).
 *
 * Returns 1 on success, 0 if `cp` is not a decimal digit.
 */
int yaep_utf8_digit_value(yaep_codepoint_t cp, int *value_out,
						  yaep_codepoint_t *block_start);

/* Error Message Helper
 *
 * Returns a human-readable error message for an invalid UTF-8 sequence.
 * This is useful for generating diagnostic output when yaep_utf8_next
 * returns YAEP_CODEPOINT_INVALID.
 *
 * Parameters:
 *   error_code: The error code returned by utf8proc (negative value)
 *
 * Returns:
 *   A static string describing the error, never NULL.
 *
 * Note: The returned string is statically allocated and should not be freed.
 */
const char *yaep_utf8_error_message(int error_code);

/* UTF-8-safe truncation helper
 *
 * Truncates the UTF-8 encoded NUL-terminated string `src` into the
 * buffer `dst` of size `dst_size` bytes. The function preserves whole
 * Unicode code points: it never leaves `dst` ending in the middle of a
 * UTF-8 continuation sequence. If truncation occurs, the function will
 * append an ASCII ellipsis "..." when space permits to clearly mark
 * the truncation. The function always NUL-terminates `dst` when
 * dst_size > 0.
 *
 * Returns 1 if the source was copied fully without truncation, 0 if
 * truncation happened.
 */
int yaep_utf8_truncate_safe(const char *src, char *dst, size_t dst_size);

/* Normalize UTF-8 string to NFC using the bundled utf8proc backend.
 *
 * This function performs NFC normalization on the NUL-terminated input
 * string `in`. The result is allocated using the provided YaepAllocator
 * (so ownership follows existing allocator conventions inside YAEP).
 *
 * Parameters:
 *   in    - NUL-terminated input UTF-8 string (may be NULL)
 *   out   - Receives pointer to an allocator-owned NUL-terminated UTF-8
 *           string on success. The caller must not free `*out` directly;
 *           it will be freed when the allocator is freed. On failure *out
 *           is set to NULL.
 *   alloc - YAEP allocator used to allocate the returned string. If NULL,
 *           the function falls back to plain malloc/free semantics.
 *
 * Returns:
 *   1 on success, 0 on failure (memory allocation or normalization error).
 *
 * Implementation notes:
 *   - Uses utf8proc_NFC to obtain a temporary malloc()'d buffer, then copies
 *     it into allocator-managed memory via yaep_malloc for consistent
 *     ownership inside YAEP.
 *   - The function is deliberately conservative: if normalization fails,
 *     the original string is not modified and *out is NULL.
 */
int yaep_utf8_normalize_nfc(const char *in, char **out, YaepAllocator *alloc);

#ifdef __cplusplus
}
#endif

#endif /* YAEP_UNICODE_H */
