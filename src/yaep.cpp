/*
   YAEP (Yet Another Earley Parser)

   Copyright (c) 1997-2018  Vladimir Makarov <vmakarov@gcc.gnu.org>

   Permission is hereby granted, free of charge, to any person obtaining a
   copy of this software and associated documentation files (the
   "Software"), to deal in the Software without restriction, including
   without limitation the rights to use, copy, modify, merge, publish,
   distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to
   the following conditions:

   The above copyright notice and this permission notice shall be included
   in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

#define VLO_CREATE( v, allocator, len ) ( v ) = new vlo( allocator, len )
#define VLO_DELETE(vlo) delete vlo
#define VLO_LENGTH(vlo) (vlo)->length ()
#define VLO_BEGIN(vlo) (vlo)->begin ()
#define VLO_BOUND(vlo) (vlo)->bound ()
#define VLO_ADD_MEMORY(vlo, addr, size) (vlo)->add_memory (addr, size)
#define VLO_EXPAND(vlo, size) (vlo)->expand (size)
#define VLO_SHORTEN(vlo, size) (vlo)->shorten (size)
#define VLO_NULLIFY(vlo) (vlo)->nullify ()

#define OS_CREATE( o, allocator, len ) ( o ) = new os( allocator, len )
#define OS_EMPTY(os) (os)->empty ()
#define OS_DELETE(os) delete os
#define OS_TOP_BEGIN(os) (os)->top_begin ()
#define OS_TOP_LENGTH(os) (os)->top_length ()
#define OS_TOP_ADD_MEMORY(os, addr, size) (os)->top_add_memory (addr, size)
#define OS_TOP_ADD_STRING(os, str) (os)->top_add_string (str)
#define OS_TOP_ADD_BYTE(os, b) (os)->top_add_byte (b)
#define OS_TOP_FINISH(os) (os)->top_finish ()
#define OS_TOP_EXPAND(os, size) (os)->top_expand (size)
#define OS_TOP_SHORTEN(os, size) (os)->top_shorten (size)
#define OS_TOP_NULLIFY(os) (os)->top_nullify ()

#define create_hash_table( allocator, size, hash, eq ) new hash_table( allocator, size, hash, eq )
#define empty_hash_table(tab) (tab)->empty ()
#define delete_hash_table(tab) delete tab
#define find_hash_table_entry(tab, el, res_p) (tab)->find_entry(el, res_p)

#include "yaep.c"

yaep::yaep (void)
{
  this->grammar = yaep_create_grammar ();
}

yaep::~yaep (void)
{
  yaep_free_grammar (this->grammar);
}

int
yaep::error_code (void)
{
  return yaep_error_code (this->grammar);
}

const char *
yaep::error_message (void)
{
  return yaep_error_message (this->grammar);
}

int
yaep::read_grammar (int strict_p,
		    const char *(*read_terminal) (int *code),
		    const char *(*read_rule) (const char ***rhs,
					      const char **abs_node,
					      int *anode_cost, int **transl))
{
  return yaep_read_grammar (this->grammar, strict_p,
			    read_terminal, read_rule);
}

int
yaep::parse_grammar (int strict_p, const char *description)
{
  return yaep_parse_grammar (this->grammar, strict_p, description);
}

int
yaep::set_lookahead_level (int level)
{
  return yaep_set_lookahead_level (this->grammar, level);
}

int
yaep::set_debug_level (int level)
{
  return yaep_set_debug_level (this->grammar, level);
}

int
yaep::set_one_parse_flag (int flag)
{
  return yaep_set_one_parse_flag (this->grammar, flag);
}

int
yaep::set_cost_flag (int flag)
{
  return yaep_set_cost_flag (this->grammar, flag);
}

int
yaep::set_error_recovery_flag (int flag)
{
  return yaep_set_error_recovery_flag (this->grammar, flag);
}

int
yaep::set_recovery_match (int n_toks)
{
  return yaep_set_recovery_match (this->grammar, n_toks);
}

int
yaep::parse (int (*read_token) (void **attr),
	     void (*syntax_error) (int err_tok_num,
				   void *err_tok_attr,
				   int start_ignored_tok_num,
				   void *start_ignored_tok_attr,
				   int start_recovered_tok_num,
				   void *start_recovered_tok_attr),
	     void *(*parse_alloc) (int nmemb),
	     void (*parse_free) (void *mem),
	     struct yaep_tree_node **root, int *ambiguous_p)
{
  return yaep_parse (this->grammar, read_token, syntax_error,
		     parse_alloc, parse_free, root, ambiguous_p);
}

void
yaep::free_tree (struct yaep_tree_node *root, void (*parse_free) (void *),
		 void (*termcb) (struct yaep_term * term))
{
  yaep_free_tree (root, parse_free, termcb);
}


#ifdef YAEP_TEST

/* The following two functions calls earley parser with two different
   ways of forming grammars. */
static void
use_functions (int argc, char **argv)
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  YaepAllocator *alloc = yaep_alloc_new (NULL, NULL, NULL, NULL);
  if (alloc == NULL)
    {
      exit (1);
    }
  nterm = nrule = 0;
  OS_CREATE (mem_os, alloc, 0);
  fprintf (stderr, "Use functions\n");
  e = new yaep ();
  if (e == NULL)
    {
      fprintf (stderr, "yaep::yaep: No memory\n");
      OS_DELETE (mem_os);
      exit (1);
    }
  e->set_one_parse_flag (FALSE);
  if (argc > 1)
    e->set_lookahead_level (atoi (argv[1]));
  if (argc > 2)
    e->set_debug_level (atoi (argv[2]));
  else
    e->set_debug_level (3);
  if (argc > 3)
    e->set_error_recovery_flag (atoi (argv[3]));
  if (argc > 4)
    e->set_one_parse_flag (atoi (argv[4]));
  if (e->read_grammar (TRUE, read_terminal, read_rule) != 0)
    {
      fprintf (stderr, "%s\n", e->error_message ());
      OS_DELETE (mem_os);
      exit (1);
    }
  ntok = 0;
  if (e->parse (test_read_token, test_syntax_error, test_parse_alloc, NULL,
		&root, &ambiguous_p))
    fprintf (stderr, "yaep parse: %s\n", e->error_message ());
  delete e;
  OS_DELETE (mem_os);
  yaep_alloc_del (alloc);
}

static void
use_description (int argc, char **argv)
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  YaepAllocator *alloc = yaep_alloc_new (NULL, NULL, NULL, NULL);
  if (alloc == NULL)
    {
      exit (1);
    }
  fprintf (stderr, "Use description\n");
  OS_CREATE (mem_os, alloc, 0);
  e = new yaep ();
  if (e == NULL)
    {
      fprintf (stderr, "yaep::yaep: No memory\n");
      OS_DELETE (mem_os);
      exit (1);
    }
  e->set_one_parse_flag (FALSE);
  if (argc > 1)
    e->set_lookahead_level (atoi (argv[1]));
  if (argc > 2)
    e->set_debug_level (atoi (argv[2]));
  else
    e->set_debug_level (3);
  if (argc > 3)
    e->set_error_recovery_flag (atoi (argv[3]));
  if (argc > 4)
    e->set_one_parse_flag (atoi (argv[4]));
  if (e->parse_grammar (TRUE, description) != 0)
    {
      fprintf (stderr, "%s\n", e->error_message ());
      OS_DELETE (mem_os);
      exit (1);
    }
  if (e->parse (test_read_token, test_syntax_error, test_parse_alloc, NULL,
		&root, &ambiguous_p))
    fprintf (stderr, "yaep::parse: %s\n", e->error_message ());
  delete e;
  OS_DELETE (mem_os);
  yaep_alloc_del (alloc);
}

int
main (int argc, char **argv)
{
  /* Don't expect the same statistics output because the order of
     situations in sets may be different in different calls because of
     memory allocations/freeing (we use situation address to order
     situations in sets) . */
  if (argc <= 1)
    use_description (argc, argv);
  else if (atoi (argv[1]))
    use_description (argc - 1, argv + 1);
  else
    use_functions (argc - 1, argv + 1);
  exit (0);
}

#endif /* #ifdef YAEP_TEST */
