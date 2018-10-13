#include <limits.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include "objstack.h"
#include "hashtab.h"
#include "ticker.h"

typedef const char *string_t;

static const char *typedef_flag = NULL;
static int after_struct_flag = 0;
static int level = 0;

#include "test_common.c"

#define yylex get_lex
#include "y.tab.c"
#undef yylex

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
    {
      yylval = curr->id;
      if (!after_struct_flag && find_typedef (curr->id, level))
        return TYPE_NAME;
      else
        return IDENTIFIER;
    }
  else
    return curr->code;
}


#include "ansic.c"

static void store_lexs( YaepAllocator * alloc ) {
  struct lex lex, *prev;
  int code;

  OS_CREATE( lexs, alloc, 0 );
  list = NULL;
  prev = NULL;
  while ((code = yylex ()) > 0) {
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
    else {
      prev = prev->next = OS_TOP_BEGIN (lexs);
    }
    OS_TOP_FINISH (lexs);
  }
}

main()
{
  ticker_t t;
  int code;
#ifdef linux
  char *start = sbrk (0);
#endif

  YaepAllocator * alloc = yaep_alloc_new( NULL, NULL, NULL, NULL );
  if ( alloc == NULL ) {
    exit( 1 );
  }
#if YYDEBUG
  yydebug = 1;
#endif
  store_lexs( alloc );
  initiate_typedefs( alloc );
  curr = NULL;
  t = create_ticker ();
  code = yyparse();
#ifdef linux
  printf ("parse time %.2f, memory=%.1fkB\n", active_time (t),
          ((char *) sbrk (0) - start) / 1024.);
#else
  printf ("parse time %.2f\n", active_time (t));
#endif
  yaep_alloc_del( alloc );
  exit (code);
}
