#include<stdio.h>
#include <stdlib.h>

#include"common.h"
#include "yaep.h"

static const char *input = "a+b*c+a";

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
  struct grammar *g;
  struct yaep_tree_node *root;
  int ambiguous_p;

  if ((g = yaep_create_grammar ()) == NULL)
    {
      fprintf (stderr, "yaep_create_grammar: No memory\n");
      exit (1);
    }
  yaep_set_one_parse_flag (g, 0);
  if (argc > 1)
    yaep_set_lookahead_level (g, atoi (argv [1]));
  if (argc > 2)
    yaep_set_debug_level (g, atoi (argv [2]));
  else
    yaep_set_debug_level (g, 3);
  if (argc > 3)
    yaep_set_error_recovery_flag (g, atoi (argv [3]));
  if (argc > 4)
    yaep_set_one_parse_flag (g, atoi (argv [4]));
  if (yaep_parse_grammar (g, 1, description) != 0)
    {
      fprintf (stderr, "%s\n", yaep_error_message (g));
      exit (1);
    }
  if ( yaep_parse( g, test_read_token, test_syntax_error, test_parse_alloc, test_parse_free, &root, &ambiguous_p ) ) {
      fprintf (stderr, "yaep parse: %s\n", yaep_error_message (g));
      exit (1);
    }
  if (!ambiguous_p)
    {
      fprintf (stderr, "It should be ambigous grammar\n");
      exit (1);
    }
  yaep_free_grammar (g);
  exit (0);
}
