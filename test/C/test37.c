#include <stdlib.h>

#include"common.h"

static const char *input = "a+a*(a*)+(*a)";

static const char *description =
"\n"
"E : T         # 0\n"
"  | E '+' T   # plus (0 2)\n"
"  ;\n"
"T : F         # 0\n"
"  | T '*' F   # mult (0 2)\n"
"  ;\n"
"F : 'a'       # 0\n"
"  | '(' E ')' # 1\n"
"  | '(' error ')' # 1\n"
"  ;\n"
  ;

main (int argc, char **argv)
{
  test_complex_parse (0, 0, 0, 4, argc, argv);
  exit (0);
}
