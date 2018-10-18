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

/* The following variable is the current number of next input grammar
   terminal. */
static int nterm;

/* The following function imported by YAEP (see comments in the interface file). */
const char *
read_terminal (int *code)
{
  nterm++;
  switch (nterm)
    {
    case 1: *code = -2; return "a";
    case 2: *code = '+'; return "+";
    case 3: *code = '*'; return "*";
    case 4: *code = '('; return "(";
    case 5: *code = ')'; return ")";
    default: return NULL;
    }
}

/* The following variable is the current number of next rule grammar
   terminal. */
static int nrule;

/* The following function imported by YAEP (see comments in the interface file). */
const char *
read_rule (const char ***rhs, const char **anode, int *anode_cost, int **transl)
{
  static const char *rhs_1 [] = {"T", NULL};
  static int tr_1 [] = {0, -1};
  static const char *rhs_2 [] = {"E", "+", "T", NULL};
  static int tr_2 [] = {0, 2, -1};
  static const char *rhs_3 [] = {"F", NULL};
  static int tr_3 [] = {0, -1};
  static const char *rhs_4 [] = {"T", "*", "F", NULL};
  static int tr_4 [] = {0, 2, -1};
  static const char *rhs_5 [] = {"a", NULL};
  static int tr_5 [] = {0, -1};
  static const char *rhs_6 [] = {"(", "E", ")", NULL};
  static int tr_6 [] = {1, -1};

  nrule++;
  switch (nrule)
    {
    case 1: *rhs = rhs_1; *anode = NULL; *anode_cost = 0; *transl = tr_1;
      return "E";
    case 2: *rhs = rhs_2; *anode = "plus"; *anode_cost = 0; *transl = tr_2;
      return "E";
    case 3: *rhs = rhs_3; *anode = NULL; *anode_cost = 0; *transl = tr_3;
      return "T";
    case 4: *rhs = rhs_4; *anode = "mult"; *anode_cost = 0; *transl = tr_4;
      return "T";
    case 5: *rhs = rhs_5; *anode = NULL; *anode_cost = 0; *transl = tr_5;
      return "F";
    case 6: *rhs = rhs_6; *anode = NULL; *anode_cost = 0; *transl = tr_6;
      return "F";
    default: return NULL;
    }
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

main ()
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
  if (yaep_read_grammar (g, 1, read_terminal, read_rule) != 0)
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
  yaep_free_grammar (g);
  OS_DELETE (mem_os);
  yaep_alloc_del( alloc );
  exit (0);
}
