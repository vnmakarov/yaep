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

#include <limits.h>
#include <stdio.h>
#include <stddef.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include "objstack.h"
#include "hashtab.h"
#include "ticker.h"
#include "ansi_grammar_data.h"

#include "yaep.h"

#define IDENTIFIER 1000
#define SIGNED     2000
#define CONST      3000
#define INLINE     4000
#define AUTO       5000
#define BREAK      6000
#define CASE       7000
#define CHAR       8000
#define CONTINUE   9000
#define DEFAULT    1001
#define DO         2001
#define DOUBLE     3001
#define ELSE       4001
#define ENUM       5001
#define EXTERN     6001
#define FLOAT      7001
#define FOR        8001
#define GOTO       9001
#define IF         1002
#define INT        2002
#define LONG       3002
#define REGISTER   4002
#define RETURN     5002
#define SHORT      6002
#define SIZEOF     7002
#define STATIC     8002
#define STRUCT     9002
#define SWITCH     1003
#define TYPEDEF    2003
#define UNION      3003
#define UNSIGNED   4003
#define VOID       5003
#define VOLATILE   6003
#define WHILE      7003
#define CONSTANT   8003
#define STRING_LITERAL 9003
#define RIGHT_ASSIGN  1004
#define LEFT_ASSIGN   2004
#define ADD_ASSIGN    3004
#define SUB_ASSIGN    4004
#define MUL_ASSIGN    5004
#define DIV_ASSIGN    6004
#define MOD_ASSIGN    7004
#define AND_ASSIGN    8004
#define XOR_ASSIGN    9004
#define OR_ASSIGN     1005
#define RIGHT_OP      2007
#define LEFT_OP       3005
#define INC_OP        4005
#define DEC_OP        5005
#define PTR_OP        6005
#define AND_OP        7005
#define OR_OP         8005
#define LE_OP         9005
#define GE_OP         1006
#define EQ_OP         2006
#define NE_OP         3006
#define ELIPSIS       4006
#define RESTRICT      5006
#define _BOOL         6006
#define _COMPLEX      7006
#define _IMAGINARY    8006

#include "test_common.c"

int
get_lex (void)
{
  if (curr == NULL)
    curr = list;
  else
    curr = curr->next;
  if (curr == NULL)
    return 0;
  line = curr->line;
  column = curr->column;
  if (curr->code == IDENTIFIER)
    return IDENTIFIER;
  else
    return curr->code;
}

#define yylex yylex1

#include "ansic.c"

static void
store_lexs (YaepAllocator *alloc)
{
  struct lex lex, *prev;
  int code;
#ifdef DEBUG
  int nt = 0;
#endif

  OS_CREATE (lexs, alloc, 0);
  list = NULL;
  prev = NULL;
  while ((code = yylex ()) > 0)
    {
#ifdef DEBUG
      nt++;
#endif
      if (code == IDENTIFIER)
        {
          OS_TOP_ADD_MEMORY (lexs, yytext, strlen (yytext) + 1);
          lex.id = OS_TOP_BEGIN (lexs);
          OS_TOP_FINISH (lexs);
        }
      else
        lex.id = NULL;
      lex.code = code;
      lex.line = line;
      lex.column = column;
      lex.next = NULL;
      OS_TOP_ADD_MEMORY (lexs, &lex, sizeof (lex));
      if (prev == NULL)
        prev = list = OS_TOP_BEGIN (lexs);
      else
        {
          prev = prev->next = OS_TOP_BEGIN (lexs);
        }
      OS_TOP_FINISH (lexs);
    }
#ifdef DEBUG
  fprintf (stderr, "%d tokens\n", nt);
#endif
}

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
  /* Unused parameters - required by callback signature */
  (void)start_ignored_tok_attr;
  (void)start_recovered_tok_attr;
  
  if (start_ignored_tok_num < 0)
    fprintf (stderr, "Syntax error on token %d\n", err_tok_num);
  else
    fprintf
      (stderr,
       "Syntax error on token %d(ln %d):ignore %d tokens starting with token = %d\n",
       err_tok_num, (int) (ptrdiff_t) err_tok_attr,
       start_recovered_tok_num - start_ignored_tok_num, start_ignored_tok_num);
}

/* The following function imported by Earley's algorithm (see comments
   in the interface file). */
static int
test_read_token (void **attr)
{
  int code;

  *attr = (void *) (ptrdiff_t) line;
  code = get_lex ();
  if (code <= 0)
    return -1;
  return code;
}

#ifdef linux
#include <unistd.h>
#endif

int
main (int argc, char **argv)
{
  ticker_t t;
  int ambiguous_p;
  struct yaep_tree_node *root;
  struct grammar *g;
#ifdef linux
  char *start = sbrk (0);
#endif

  YaepAllocator *alloc = yaep_alloc_new (NULL, NULL, NULL, NULL);
  if (alloc == NULL)
    {
      exit (1);
    }
  OS_CREATE (mem_os, alloc, 0);
  t = create_ticker ();
  store_lexs (alloc);
#ifdef linux
  printf ("scanner time %.2f, memory=%.1fkB\n", active_time (t),
          ((char *) sbrk (0) - start) / 1024.);
#else
  printf ("scanner time %.2f\n", active_time (t));
#endif
  initiate_typedefs (alloc);
  curr = NULL;
  if ((g = yaep_create_grammar ()) == NULL)
    {
      fprintf (stderr, "yaep_create_grammar: No memory\n");
      OS_DELETE (mem_os);
      exit (1);
    }
  if (argc > 1)
    yaep_set_lookahead_level (g, atoi (argv[1]));
  if (argc > 2)
    yaep_set_debug_level (g, atoi (argv[2]));
  else
    yaep_set_debug_level (g, 3);
  if (argc > 3)
    yaep_set_error_recovery_flag (g, atoi (argv[3]));
  if (argc > 4)
    yaep_set_one_parse_flag (g, atoi (argv[4]));

  if (yaep_parse_grammar (g, 1, yaep_ansi_grammar_description ()) != 0)
    {
      fprintf (stderr, "%s\n", yaep_error_message (g));
      OS_DELETE (mem_os);
      exit (1);
    }
  t = create_ticker ();
  if (yaep_parse (g, test_read_token, test_syntax_error, test_parse_alloc,
                  NULL, &root, &ambiguous_p))
    {
      fprintf (stderr, "yaep_parse: %s\n", yaep_error_message (g));
      OS_DELETE (mem_os);
      exit (1);
    }
  yaep_free_grammar (g);
#ifdef linux
  printf ("parse time %.2f, memory=%.1fkB\n", active_time (t),
          ((char *) sbrk (0) - start) / 1024.);
#else
  printf ("parse time %.2f\n", active_time (t));
#endif
  OS_DELETE (mem_os);
  yaep_alloc_del (alloc);
  return 0;
}
