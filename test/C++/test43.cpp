#include<cstdio>
#include <stdlib.h>
#include "objstack.h"
#include "yaep.h"

/* All parse_alloc memory is contained here. */
static os_t *mem_os;

static void *
test_parse_alloc (int size)
{
  void *result;

  mem_os->top_expand (size);
  result = mem_os->top_begin ();
  mem_os->top_finish ();
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
  const char input [] ="a+b*c+d";

  ntok++;
  *attr = NULL;
  if (ntok < sizeof (input))
    return input [ntok - 1];
  else
    return -1;
}

static const char *description =
"\n"
"E : E '+' E   # plus (- 2)\n"
"  | E '*' E   # mult (0 -)\n"
"  | E '*' E   # mult (0 2)\n"
"  | 'a'       # 0\n"
"  | 'b'       # 0\n"
"  | 'c'       # 0\n"
"  | 'd'       # 0\n"
"  | '(' E ')' # 1\n"
"  ;\n"
  ;

int
main (int argc, char **argv)
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  YaepAllocator * alloc = yaep_alloc_new( NULL, NULL, NULL, NULL );
  if ( alloc == NULL ) {
    exit( 1 );
  }
  mem_os = new os( alloc, 0 );
  e = new yaep ();
  if (e == NULL)
    {
      fprintf (stderr, "yaep::yaep: No memory\n");
      delete mem_os;
      exit (1);
    }
  ntok = 0;
  e->set_one_parse_flag (0);
  if (argc > 1)
    e->set_lookahead_level (atoi (argv [1]));
  if (argc > 2)
    e->set_debug_level (atoi (argv [2]));
  else
    e->set_debug_level (3);
  if (argc > 3)
    e->set_error_recovery_flag (atoi (argv [3]));
  if (argc > 4)
    e->set_one_parse_flag (atoi (argv [4]));
  if (e->parse_grammar (1, description) != 0)
    {
      fprintf (stderr, "%s\n", e->error_message ());
      delete mem_os;
      exit (1);
    }
  if (e->parse (test_read_token, test_syntax_error, test_parse_alloc, NULL,
		&root, &ambiguous_p))
    {
      fprintf (stderr, "yaep::parse: %s\n", e->error_message ());
      delete mem_os;
      exit (1);
    }
  if (!ambiguous_p)
    {
      fprintf (stderr, "It should be ambigous grammar\n");
      delete mem_os;
      exit (1);
    }
  delete e;
  delete mem_os;
  yaep_alloc_del( alloc );
  exit (0);
}
