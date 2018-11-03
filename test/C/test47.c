#include <stdlib.h>

#include"common.h"

static const char *input = "a+((a*a)+a)";

static const char *description =
"\n"
"E : V '+' V                 # add  1 (0 2)\n"
"  | V '*' V                 # mult 1 (0 2)\n"
"  | V '+' '(' V '*' V ')'   # madd 1 (0 3 5)\n"
"  | '(' V '*' V ')' '+' V   # madd 1 (6 1 3)\n"
"  ;\n"
"V : 'a'                     # 0\n"
"  | '(' E ')'               # 1\n"
"  ;\n"
  ;

main (int argc, char **argv)
{
  test_complex_parse (1, 1, 1, 0, argc, argv);
  exit (0);
}
