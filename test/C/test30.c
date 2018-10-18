#include<stdio.h>
#include <stdlib.h>
#include "objstack.h"
#include "yaep.h"

/* All parse_alloc memory is contained here. */
static os_t mem_os;

static void *
test_parse_alloc (int size)
{
  void *result;

  OS_TOP_EXPAND (mem_os, size);
  result = OS_TOP_BEGIN (mem_os);
  OS_TOP_FINISH (mem_os);
  return result;
}

/* Printing syntax error. */
static void
test_syntax_error (int err_tok_num, void *err_tok_attr,
		   int start_ignored_tok_num, void *start_ignored_tok_attr,
		   int start_recovered_tok_num, void *start_recovered_tok_attr)
{
  if (start_ignored_tok_num < 0)
    fprintf (stderr, "Syntax error on token %d\n", err_tok_num);
  else
    fprintf
      (stderr,
       "Syntax error on token %d:ignore %d tokens starting with token = %d\n",
       err_tok_num, start_recovered_tok_num - start_ignored_tok_num,
       start_ignored_tok_num);
}

/* The following variable is the current number of next input
   token. */
static int ntok;

/* The following function imported by YAEP (see comments in the interface file). */
static int
test_read_token (void **attr)
{
  const char input [] ="a+a*(a*a+a)";

  ntok++;
  *attr = NULL;
  if (ntok < sizeof (input))
    return input [ntok - 1];
  else
    return -1;
}

static const char *description =
"\n"
"E : E '+' E   # plus (0 2)\n"
"  | E '*' E   # mult (0 2)\n"
"  | 'a'       # 0\n"
"  | '(' E ')' # 1\n"
"  ;\n"
  ;

main (int argc, char **argv)
{
  struct grammar *g;
  struct yaep_tree_node *root;
  int ambiguous_p;

  YaepAllocator * alloc = yaep_alloc_new( NULL, NULL, NULL, NULL );
  if ( alloc == NULL ) {
    exit( 1 );
  }
  OS_CREATE( mem_os, alloc, 0 );
  if ((g = yaep_create_grammar ()) == NULL)
    {
      fprintf (stderr, "yaep_create_grammar: No memory\n");
      OS_DELETE (mem_os);
      exit (1);
    }
  ntok = 0;
  yaep_set_one_parse_flag (g, 1);
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
      OS_DELETE (mem_os);
      exit (1);
    }
  if (yaep_parse (g, test_read_token, test_syntax_error, test_parse_alloc,
                    NULL, &root, &ambiguous_p))
    {
      fprintf (stderr, "yaep_parse: %s\n", yaep_error_message (g));
      OS_DELETE (mem_os);
      exit (1);
    }
  if (!ambiguous_p)
    {
      fprintf (stderr, "It should be ambigous grammar\n");
      OS_DELETE (mem_os);
      exit (1);
    }
  yaep_free_grammar (g);
  OS_DELETE (mem_os);
  yaep_alloc_del( alloc );
  exit (0);
}
