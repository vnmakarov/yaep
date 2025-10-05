/* Test normalization persistence and no-allocator behavior.
 *
 * This test covers two related cases:
 * 1) Normalization with a grammar (which provides an allocator): ensure
 *    that NFC-normalization causes canonical-equivalent terminals to
 *    collide during grammar parsing (repeated-term detection).
 * 2) Normalization when no allocator is provided: verify that
 *    `yaep_utf8_normalize_nfc` returns a malloc()-ed buffer and that
 *    the caller can copy/free it safely (simulating the utf8proc no-
 *    allocator code path used by some insertion logic).
 */

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "yaep.h"
#include "unicode/yaep_unicode.h"

int main(void)
{
    /* Case 1: grammar-backed normalization */
    struct grammar *g = yaep_create_grammar();
    if (!g) return 1;

    /* Two canonically equivalent terminals (Å in NFC and A + ring) and a
       minimal rule so parsing gets to duplicate detection. */
    const char *nfc = "TERM \xC3\x85\n"; /* U+00C5 */
    const char *nfd = "TERM A\xCC\x8A\n"; /* 'A' + U+030A */
    char desc[256];
    snprintf(desc, sizeof(desc), "%s%sS : ;\n", nfc, nfd);

    int rc = yaep_parse_grammar(g, 1, desc);
    (void) rc;
    int code = yaep_error_code(g);
    if (code != YAEP_REPEATED_TERM_DECL) {
        yaep_free_grammar(g);
        return 1;
    }
    yaep_free_grammar(g);

    /* Case 2: no-allocator normalization path (utf8proc malloc buffer).
       Ensure we get a malloc()-ed buffer that is NFC and can be freed by
       the caller after copying into a persistent area. */
    char *tmp = NULL;
    const char *input = "A\xCC\x8A"; /* decomposed A + ring */
    if (yaep_utf8_normalize_nfc(input, &tmp, NULL) != 1) {
        /* normalization failed */
        return 1;
    }
    /* `tmp' is expected to be malloc()-ed; verify it looks like NFC U+00C5 */
    if (strcmp(tmp, "\xC3\x85") != 0 && strcmp(tmp, "Å") != 0) {
        free(tmp);
        return 1;
    }
    /* simulate copying into persistent storage */
    char persistent[8];
    strncpy(persistent, tmp, sizeof(persistent));
    persistent[sizeof(persistent)-1] = '\0';

    free(tmp);

    if (strcmp(persistent, "\xC3\x85") != 0 && strcmp(persistent, "Å") != 0) {
        return 1;
    }

    return 0;
}
