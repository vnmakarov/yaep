#include <stdlib.h>

#include"common.h"

static const char *input = "a+a*(*a+a)";

static const char *description =
"\n"
"E : E '+' E   # plus (0 2)\n"
"  | E '*' E   # mult (0 2)\n"
"  | 'a'       # 0\n"
"  | '(' E ')' # 1\n"
"  | '(' error ')' # 1\n"
"  ;\n"
  ;

int
main (int argc, char **argv)
{
  test_complex_parse (input, description, 1, 1, 0, 0, argc, argv);
  exit (0);
}
