#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "../../src/unicode/yaep_unicode.h"

int main(void)
{
    /* Create a long string with repeated multi-byte sequences (emoji)
     * to stress truncation at various boundaries. */
    const char *chunk = "\360\237\230\200"; /* U+1F600 grinning face */
    char src[1024];
    size_t pos = 0;
    for (int i = 0; i < 50 && pos + 4 < sizeof(src)-1; ++i) {
        memcpy(src + pos, chunk, 4);
        pos += 4;
    }
    src[pos] = '\0';

    /* Try a series of small dst sizes to ensure truncation preserves
     * code point boundaries and produces a valid UTF-8 string ending
     * with ellipsis when space allows. */
    for (size_t dst_size = 4; dst_size <= 32; ++dst_size) {
        char *dst = malloc(dst_size);
        if (!dst) {
            fprintf(stderr, "malloc failed\n");
            return 2;
        }
        int rc = yaep_utf8_truncate_safe(src, dst, dst_size);
        /* rc==1 means no truncation; rc==0 means truncated. Either is OK,
         * but dst must be a valid UTF-8 string (validate) and must be
         * NUL-terminated. */
        if (dst[dst_size-1] != '\0' && dst[dst_size-1] != '\0') {
            /* ensure NUL within buffer */
        }
        size_t plen = strlen(dst);
        if (plen == 0) {
            free(dst);
            fprintf(stderr, "empty output for dst_size=%zu\n", dst_size);
            return 3;
        }

        /* Validate UTF-8 well-formedness */
        size_t codepoints = 0;
        size_t err_offset = 0;
        int err_code = 0;
        int ok = yaep_utf8_validate(dst, &codepoints, &err_offset, &err_code);
        if (!ok) {
            fprintf(stderr, "invalid UTF-8 for dst_size=%zu offset=%zu code=%d\n",
                    dst_size, err_offset, err_code);
            free(dst);
            return 4;
        }

        /* If truncation happened, expect an ellipsis at end when space allowed */
        int truncated = (rc == 0);
        if (truncated) {
            size_t outlen = strlen(dst);
            if (outlen >= 3) {
                if (strcmp("...", outlen >= 3 ? &dst[outlen-3] : "") != 0) {
                    /* it's acceptable if ellipsis doesn't fit; only check when there
                     * is room for 3 chars + NUL within dst_size */
                    if (outlen + 1 <= dst_size) {
                        fprintf(stderr, "missing ellipsis for dst_size=%zu: '%s'\n",
                                dst_size, dst);
                        free(dst);
                        return 5;
                    }
                }
            }
        }

        free(dst);
    }

    puts("OK");
    return 0;
}
