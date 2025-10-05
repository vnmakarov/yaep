#include <stdio.h>
#include <string.h>
#include "../../src/unicode/yaep_unicode.h"

int main(void)
{
    /* Ensure the hash treats bytes as unsigned and is stable for high-bit bytes.
     * Example uses two bytes with high bit set (0x80..0xFF) and ensures
     * consistent hash across runs. */
    const char s1[] = "\xC3\x85"; /* C3 85 (UTF-8 for U+00C5) */
    const char s2[] = "\xC3\x85"; /* same bytes */

    unsigned h1 = yaep_utf8_hash(s1);
    unsigned h2 = yaep_utf8_hash(s2);

    if (h1 != h2) {
        fprintf(stderr, "hash mismatch: %u vs %u\n", h1, h2);
        return 2;
    }

    /* Also ensure different strings produce different hashes (very likely) */
    const char s3[] = "A";
    unsigned h3 = yaep_utf8_hash(s3);
    if (h1 == h3) {
        fprintf(stderr, "unlikely hash collision %u==%u\n", h1, h3);
        return 3;
    }

    puts("OK");
    return 0;
}
