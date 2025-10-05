/* Invalid UTF-8 grammar validation test (C++ API)
 *
 * Confirms that malformed UTF-8 is rejected before lexing and that the
 * diagnostic text is propagated through the C++ wrapper.
 */

#include <cstdlib>
#include <cstring>
#include <iostream>

#include "yaep.h"

int
main ()
{
  yaep *g = new yaep ();
  const char invalid_grammar[] = "TERM;\nS : 'a' S 'b' | ;\n/* malformed */\n\xC3";

  if (g == NULL)
    {
      std::cerr << "fatal: failed to allocate grammar" << std::endl;
      return EXIT_FAILURE;
    }

  if (g->parse_grammar (0, invalid_grammar) != YAEP_INVALID_UTF8)
    {
      std::cerr << "expected YAEP_INVALID_UTF8 but parse succeeded" << std::endl;
      delete g;
      return EXIT_FAILURE;
    }

  const char *msg = g->error_message ();
  if (msg == NULL || std::strstr (msg, "invalid UTF-8") == NULL)
    {
      std::cerr << "validator did not produce informative error message" << std::endl;
      delete g;
      return EXIT_FAILURE;
    }

  std::cout << "PASS: " << msg << std::endl;

  delete g;
  return EXIT_SUCCESS;
}
