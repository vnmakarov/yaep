#include <stdlib.h>

#include"common.h"

static const char *input = "a+a*(a*a+a)";

static const char *description = "TERM ident; ident : ;\n";

main ()
{
  test_standard_parse ();
  exit (0);
}
