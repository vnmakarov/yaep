#include <stdlib.h>

#include"common.h"

static const char *input  = "spc; ";

static const char *description =
"\n"
"P  : 's' sp st sp                 # prog (2)\n"
"st : 'p' sp p_list sp ';'         # print (2)\n"
"p_list : 'c' sp p_list      # string (0 2)\n"
"       |                    # -\n"
"sp : ' '\n"
"   |\n"
  ;

int
main (int argc, char **argv)
{
  test_complex_parse (input, description, 1, 0, 0, 0, argc, argv);
  exit (0);
}
