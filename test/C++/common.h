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

#ifndef YAEP_TEST_CXX_COMMON_H_
#define YAEP_TEST_CXX_COMMON_H_

#include<cassert>
#include<cstdio>
#include<cstdlib>

#include"yaep.h"

static inline void *
test_parse_alloc (int size)
{
  void * result;

  assert ((size > 0) && ((unsigned int) size == (size_t) size));
  result = malloc (size);
  assert (result != NULL);

  return result;
}

static inline void
test_parse_free (void * mem)
{
  free( mem );
}

/* Printing syntax error. */
static inline void
test_syntax_error (int err_tok_num, void *err_tok_attr,
		   int start_ignored_tok_num, void *start_ignored_tok_attr,
		   int start_recovered_tok_num, void *start_recovered_tok_attr)
{
  (void)err_tok_attr;
  (void)start_ignored_tok_attr;
  (void)start_recovered_tok_attr;
  if (start_ignored_tok_num < 0)
    fprintf (stderr, "Syntax error on token %d\n", err_tok_num);
  else
    fprintf
      (stderr,
       "Syntax error on token %d:ignore %d tokens starting with token = %d\n",
       err_tok_num, start_recovered_tok_num - start_ignored_tok_num,
       start_ignored_tok_num);
}

static const char *test_input;

/* The following function imported by YAEP (see comments in the interface file). */
static inline int
test_read_token (void **attr)
{
  static int ntok = 0;

  *attr = NULL;
  if (test_input [ntok])
    {
      return test_input [ntok++];
    }
  else
    {
      return -1;
    }
}

static inline void
test_standard_parse (const char *input, const char *description)
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  test_input = input;
  e = new yaep ();
  if (e->parse_grammar (1, description) != 0)
    {
      fprintf (stderr, "%s\n", e->error_message ());
      exit (1);
    }
  if (e->parse
      (test_read_token, test_syntax_error, test_parse_alloc,
       test_parse_free, &root, &ambiguous_p))
    {
      fprintf (stderr, "yaep parse: %s\n", e->error_message ());
      exit (1);
    }
  delete e;
}

static inline void
test_standard_read
  (const char *input, const char *(*read_terminal) (int *),
   const char *(*read_rule) (const char ***, const char **, int *, int **))
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  test_input = input;
  e = new yaep ();
  if (e->read_grammar (1, read_terminal, read_rule) != 0)
    {
      fprintf (stderr, "%s\n", e->error_message ());
      exit (1);
    }
  if (e->parse
      (test_read_token, test_syntax_error, test_parse_alloc,
       test_parse_free, &root, &ambiguous_p))
    {
      fprintf (stderr, "yaep parse: %s\n", e->error_message ());
      exit (1);
    }
  delete e;
}

static inline void
test_complex_parse
  (const char *input, const char *description,
   int one_parse, int ambiguous, int print_cost, int recovery_match,
   int argc, char **argv)
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  test_input = input;
  e = new yaep ();
  e->set_one_parse_flag (one_parse);
  if (print_cost)
    {
      e->set_cost_flag (1);
    }
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
  if (recovery_match)
    {
      e->set_recovery_match (recovery_match);
    }
  if (e->parse_grammar (1, description) != 0)
    {
      fprintf (stderr, "%s\n", e->error_message ());
      exit (1);
    }
  if (e->parse (test_read_token, test_syntax_error, test_parse_alloc,
                  test_parse_free, &root, &ambiguous_p))
    {
      fprintf (stderr, "yaep parse: %s\n", e->error_message ());
      exit (1);
    }
  if (ambiguous != ambiguous_p)
    {
      fprintf (stderr, "Grammar should be %sambiguous\n", ambiguous ? "" : "un");
      exit (1);
    }
  if (print_cost)
    {
      fprintf (stderr, "cost = %d\n", root->val.anode.cost);
    }
  delete e;
}

#endif
