#include <stdlib.h>

#include"common.h"

static const char *input = "a+a";

static const char *description =
"\n"
"E : 'a' E\n"
"  | E '+'\n"
"  ;\n"
  ;

int
main (int argc, char **argv)
{
  test_complex_parse (input, description, 0, 0, 0, 0, argc, argv);
  exit (0);
}
