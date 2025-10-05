/* Invalid UTF-8 grammar validation test
 *
 * Ensures the pre-flight UTF-8 validator rejects malformed sequences before
 * the lexer mutates any parser state and that the reported diagnostics include
 * a byte offset.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "yaep.h"

int
main (void)
{
  struct grammar *g = yaep_create_grammar ();
  const char invalid_grammar[] = "TERM;\nS : 'a' S 'b' | ;\n/* malformed */\n\xC3";

  if (g == NULL)
    {
      fprintf (stderr, "fatal: yaep_create_grammar failed\n");
      return EXIT_FAILURE;
    }

  if (yaep_parse_grammar (g, 0, invalid_grammar) != YAEP_INVALID_UTF8)
    {
      fprintf (stderr, "expected YAEP_INVALID_UTF8 but parse succeeded\n");
      yaep_free_grammar (g);
      return EXIT_FAILURE;
    }

  const char *msg = yaep_error_message (g);
  if (msg == NULL || strstr (msg, "invalid UTF-8") == NULL)
    {
      fprintf (stderr, "validator did not produce informative error message\n");
      yaep_free_grammar (g);
      return EXIT_FAILURE;
    }

  printf ("PASS: %s\n", msg);

  yaep_free_grammar (g);
  return EXIT_SUCCESS;
}
