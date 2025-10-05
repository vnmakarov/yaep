/* Test that NFC normalization at symbol ingestion makes canonically
   equivalent strings collide into a single symbol entry. This test
   constructs two terminal declarations that are canonically equivalent
   (one in NFD, one in NFC) and verifies that the parser reports a
   repeated declaration error when normalization is active.
*/

#include <stdio.h>
#include <string.h>
#include "yaep.h"

int main(void) {
    struct grammar *g = yaep_create_grammar();
    if (!g) return 1;

    /* "Å" (U+00C5) in NFC and decomposed form 'A' + ring above (U+0041 U+030A)
       The two should normalize to the same NFC sequence. We declare both
       as terminals and then provide a single minimal rule so the grammar
       contains rules and does not have unreachable nonterminals. */
    const char *nfc = "TERM \xC3\x85\n"; /* U+00C5 */
    const char *nfd = "TERM A\xCC\x8A\n"; /* 'A' + U+030A */

    /* Build a description that declares the same terminal twice in different
       canonical forms. The format expects a sequence of terminal declarations
       followed by rules; we keep the rest minimal and let the parser flag
       repeated declarations. */
    char desc[512];
    /* Build description: two TERM declarations (canonically equivalent)
       followed by a single minimal rule so the parser will accept the
       grammar structure and then report repeated-term declaration if
       normalization collapsed the two names. */
    snprintf(desc, sizeof(desc), "%s%sS : ;\n", nfc, nfd);

    int rc = yaep_parse_grammar(g, 1, desc);
    (void) rc;
    int code = yaep_error_code(g);
    /* Expect a repeated-term declaration error after normalization */
    int ok = (code == YAEP_REPEATED_TERM_DECL);

    yaep_free_grammar(g);
    return ok ? 0 : 1;
}
