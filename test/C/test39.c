#include <stdlib.h>

#include"common.h"

static const char *input = "a+b*c+d";

static const char *description =
"\n"
"E : E '+' E   # plus (0 2)\n"
"  | E '*' E   # mult (0 2)\n"
"  | 'a'       # 0\n"
"  | 'b'       # 0\n"
"  | 'c'       # 0\n"
"  | 'd'       # 0\n"
"  | '(' E ')' # 1\n"
"  ;\n"
  ;

main (int argc, char **argv)
{
  test_complex_parse (0, 1, 0, 0, argc, argv);
  exit (0);
}
