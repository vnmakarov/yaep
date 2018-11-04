#include<cstdio>
#include <stdlib.h>

#include"common.h"
#include "yaep.h"

static const char *input = "a+a*(a*a+a)";

static const char *description =
"\n"
"TERM;\n"
"E : T         # 0\n"
"  | E '+' T   # plus (0 2)\n"
"  ;\n"
"T : F         # 0\n"
"  | T '*' F   # mult (0 2)\n"
"  ;\n"
"F : 'a'       # 0\n"
"  | '(' E ')' # 1\n"
"  ;\n"
  ;

int
main ()
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  test_input = input;
  e = new yaep ();
  if (e == NULL)
    {
      fprintf (stderr, "yaep::yaep: No memory\n");
      exit (1);
    }
  if (e->parse (test_read_token, test_syntax_error, test_parse_alloc, NULL,
		&root, &ambiguous_p))
    {
      fprintf (stderr, "yaep parse: %s\n", e->error_message ());
      exit (1);
    }
  delete e;
  exit (0);
}
