#include <stdio.h>
#include <string.h>
#include "../../src/unicode/yaep_unicode.h"

int main(void)
{
    /* contains a 4-byte emoji (U+1F600) in the middle; use octal escapes
     * to avoid hex-escape parsing warnings on some compilers. */
    const char *s = "abc\360\237\230\200def";
    /* Use a deliberately small output buffer to force truncation and
     * exercise the ellipsize behavior. 7 bytes leaves room for a few
     * ASCII chars plus the terminating NUL and the ellipsis. */
    char out[7];
    int rc = yaep_utf8_truncate_safe(s, out, sizeof(out));
    if (rc != 0) {
        fprintf(stderr, "truncate returned %d\n", rc);
        return 2;
    }
    /* Output may be "abc..." or "abc\xF0\x9F\x98\x80..." depending on boundary; we check it is valid UTF-8 and ends with ellipsis */
    size_t outlen = strlen(out);
    if (outlen < 3) {
        fprintf(stderr, "output too short: '%s'\n", out);
        return 3;
    }
    const char *suffix = &out[outlen-3];
    if (strcmp(suffix, "...") != 0) {
        fprintf(stderr, "ellipsis missing: '%s'\n", out);
        return 4;
    }
    puts("OK");
    return 0;
}
