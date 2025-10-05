#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "../../src/unicode/yaep_unicode.h"

int main(void)
{
    /* Example: Latin capital A with ring above - two representations:
     *   1) Precomposed: U+00C5 (Å) -> "\xC3\x85"
     *   2) Decomposed: 'A' U+0041 + U+030A combining ring -> "A\xCC\x8A"
     * After NFC both should compare equal. */
    const char *pre = "\xC3\x85"; /* U+00C5 */
    const char *decomp = "A\xCC\x8A"; /* U+0041 U+030A */

    char *n1 = NULL;
    char *n2 = NULL;
    int ok1 = yaep_utf8_normalize_nfc(pre, &n1, NULL);
    int ok2 = yaep_utf8_normalize_nfc(decomp, &n2, NULL);
    if (!ok1 || !ok2 || n1 == NULL || n2 == NULL) {
        fprintf(stderr, "normalization failed\n");
        free(n1); free(n2);
        return 2;
    }

    int cmp = strcmp(n1, n2);
    free(n1); free(n2);
    if (cmp != 0) {
        fprintf(stderr, "NFC mismatch: '%s' vs '%s'\n", pre, decomp);
        return 3;
    }

    puts("OK");
    return 0;
}
