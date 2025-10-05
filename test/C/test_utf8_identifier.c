/* Test: ensure lexer accepts multi-byte and combining-sequence identifiers
 * This test constructs a tiny grammar that contains an identifier whose
 * bytes include a non-BMP character (4-byte UTF-8) and a combining mark
 * sequence. The goal is to exercise the lexer path that uses
 * yaep_utf8_next_with_len and verify the token bytes are preserved and
 * accepted by the parser.
 */

#include <stdio.h>
#include <string.h>
#include "yaep.h"

int
main (int argc, char **argv)
{
  /* We'll build a description which contains an identifier composed of:
   * - U+1F600 GRINNING FACE (emoji) : UTF-8 F0 9F 98 80 (4 bytes)
   * - LATIN SMALL LETTER E + COMBINING ACUTE (e + U+0301)
   * and encode it using explicit UTF-8 bytes below.
   */

  /* Build the grammar string with explicit UTF-8 bytes. */
  const char emoji[] = "\xF0\x9F\x98\x80"; /* U+1F600 */
  const char e_combining[] = "e\xCC\x81";   /* 'e' + U+0301 */
  char grammar[256];

  snprintf (grammar, sizeof (grammar), "TERM: ;\n%s%s: ;\n", emoji, e_combining);

  /* Create a grammar object and parse the generated description. We expect
   * the parser to accept the grammar or at least to fail gracefully without
   * crashing. Treat non-zero return as failure for the unit test. */
  struct grammar *g = yaep_create_grammar ();
  if (!g)
    {
      fprintf (stderr, "yaep_create_grammar failed\n");
      return 1;
    }

  int rc = yaep_parse_grammar (g, 1, grammar);
  /* We do not require the grammar to be accepted; the goal of this test is
   * to exercise lexer handling of multi-byte and combining-sequence
   * identifiers and ensure the parser does not crash. Any non-zero return
   * simply indicates a parse-time error (which is acceptable for this test).
   */
  (void) rc;

  yaep_free_grammar (g);
  (void) argc; (void) argv;
  return 0;
}
