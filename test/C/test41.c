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

#define input input_unused
#include "common.h"
#undef input

#include "objstack.h"
#include "hashtab.h"
#include "ticker.h"

#include "ansi_grammar_data.h"
#include "ansic.h"
#include "yaep.h"

static os_t lexs;
static struct lex *list;
static struct lex *curr = NULL;

int column = 0;
int line = 1;

static hash_table_t table;

static unsigned
hash (hash_table_entry_t el)
{
  const char *id = (char *) el;
  unsigned result, i;

  for (result = i = 0; *id++ != '\0'; i++)
    result += ((unsigned char) *id << (i % CHAR_BIT));
  return result;
}

static int
eq (hash_table_entry_t el1, hash_table_entry_t el2)
{
  return strcmp ((char *) el1, (char *) el2) == 0;
}

static inline void
initiate_typedefs (YaepAllocator *alloc)
{
  table = create_hash_table (alloc, 50000, hash, eq);
}

/* Now we ignore level */
static inline void
add_typedef (const char *id, int level)
{
  hash_table_entry_t *entry_ptr;

  assert (level == 0);
  (void) level;
  entry_ptr = find_hash_table_entry (table, id, 1);
  if (*entry_ptr == NULL)
    *entry_ptr = (hash_table_entry_t) id;
  else
    assert (strcmp (id, *entry_ptr) == 0);
#ifdef DEBUG
  fprintf (stderr, "add typedef %s\n", id);
#endif
}

static inline int
find_typedef (const char *id, int level)
{
  hash_table_entry_t *entry_ptr;

  (void) level;
  entry_ptr = find_hash_table_entry (table, id, 0);
#ifdef DEBUG
  if (*entry_ptr != NULL)
    fprintf (stderr, "found typedef %s\n", id);
#endif
  return *entry_ptr != NULL;
}

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

/* The following function imported by YAEP (see comments in the interface file). */
static int
test_read_token_from_lex (void **attr)
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
  store_lexs (alloc);
  initiate_typedefs (alloc);
  curr = NULL;
  t = create_ticker ();
  if ((g = yaep_create_grammar ()) == NULL)
    {
      fprintf (stderr, "yaep_create_grammar: No memory\n");
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
      exit (1);
    }
  if (yaep_parse
      (g, test_read_token_from_lex, test_syntax_error, test_parse_alloc,
       test_parse_free, &root, &ambiguous_p))
    {
      fprintf (stderr, "yaep parse: %s\n", yaep_error_message (g));
      exit (1);
    }
  yaep_free_grammar (g);
#ifdef linux
  printf ("all time %.2f, memory=%.1fkB\n", active_time (t),
          ((char *) sbrk (0) - start) / 1024.);
#else
  printf ("all time %.2f\n", active_time (t));
#endif
  yaep_alloc_del (alloc);
  return 0;
}
