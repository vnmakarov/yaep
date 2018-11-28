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

/* This is interface file of the code which transforms grammar
   description given by string into representation which can be used
   by YAEP.  So the code implements functions read_terminal
   and read_rule imported by YAEP.  */

%{

#include <ctype.h>

#include <assert.h>

/* The following is necessary if we use YAEP with byacc/bison/msta
   parser. */

#define yylval yaep_yylval
#define yylex yaep_yylex
#define yyerror yaep_yyerror
#define yyparse yaep_yyparse
#define yychar yaep_yychar
#define yynerrs yaep_yynerrs
#define yydebug yaep_yydebug
#define yyerrflag yaep_yyerrflag
#define yyssp yaep_yyssp
#define yyval yaep_yyval
#define yyvsp yaep_yyvsp
#define yylhs yaep_yylhs
#define yylen yaep_yylen
#define yydefred yaep_yydefred
#define yydgoto yaep_yydgoto
#define yysindex yaep_yysindex
#define yyrindex yaep_yyrindex
#define yygindex yaep_yygindex
#define yytable yaep_yytable
#define yycheck yaep_yycheck
#define yyss yaep_yyss
#define yyvs yaep_yyvs

/* The following structure describes syntax grammar terminal. */
struct sterm
{
  char *repr; /* terminal representation. */
  int code;   /* terminal code. */
  int num;    /* order number. */
};

/* The following structure describes syntax grammar rule. */
struct srule
{
  /* The following members are left hand side nonterminal
     representation and abstract node name (if any) for the rule. */
  char *lhs, *anode;
  /* The following is the cost of given anode if it is defined.
     Otherwise, the value is zero. */
  int anode_cost;
  /* The following is length of right hand side of the rule. */
  int rhs_len;
  /* Terminal/nonterminal representations in RHS of the rule.  The
     array end marker is NULL. */
  char **rhs;
  /* The translations numbers. */
  int *trans;
};

/* The following structure contains the parser data. */
struct parser_data
{
  /* The following vlos contain all syntax terminal and syntax rule
     structures. */
#ifndef __cplusplus
  vlo_t sterms, srules;
#else
  vlo_t *sterms, *srules;
#endif
  /* The following contain all right hand sides and translations arrays.
     See members rhs, trans in structure `rule'. */
#ifndef __cplusplus
  os_t srhs, strans;
#else
  os_t *srhs, *strans;
#endif
  /* The following is cost of the last translation which contains an
     abstract node. */
  int anode_cost;
  /* This variable is used in yacc action to process alternatives. */
  char *slhs;
  /* The following is current input character of the grammar
     description. */
  const char *curr_ch;
  /* The following is current line number of the grammar description. */
  int ln;
  /* The following contains all representation of the syntax tokens. */
#ifndef __cplusplus
  os_t stoks;
#else
  os_t *stoks;
#endif
  /* The following is number of syntax terminal and syntax rules being
     read. */
  int nsterm, nsrule;
};

/* Forward declarations. */
extern int yyerror (struct parser_data *data, const char *str);
union YYSTYPE;
extern int yylex (union YYSTYPE *lvalp, struct parser_data *data);
extern int yyparse (struct parser_data *data);

%}

%pure-parser
%lex-param {struct parser_data *data}
%parse-param {struct parser_data *data}

%union
  {
    void *ref;
    int num;
  }

%token <ref> IDENT SEM_IDENT CHAR
%token <num> NUMBER
%token TERM

%type <ref> trans
%type <num> number

%%

file : file terms opt_sem
     | file rule
     | terms opt_sem
     | rule
     ;

opt_sem :
        | ';'
        ;

terms : terms IDENT number
        {
	  struct sterm term;
	  
	  term.repr = (char *) $2;
	  term.code = $3;
          term.num = VLO_LENGTH (data->sterms) / sizeof (term);
	  VLO_ADD_MEMORY (data->sterms, &term, sizeof (term));
	}
      | TERM
      ;

number :            {$$ = -1;}
       | '=' NUMBER {$$ = $2;}
       ;

rule : SEM_IDENT {data->slhs = (char *) $1;} rhs opt_sem
     ;

rhs : rhs '|' alt
    | alt
    ;

alt : seq trans
      {
	struct srule rule;
	int end_marker = -1;

	OS_TOP_ADD_MEMORY (data->strans, &end_marker, sizeof (int));
	rule.lhs = data->slhs;
	rule.anode = (char *) $2;
	rule.anode_cost = (rule.anode == NULL ? 0 : data->anode_cost);
	rule.rhs_len = OS_TOP_LENGTH (data->srhs) / sizeof (char *);
	OS_TOP_EXPAND (data->srhs, sizeof (char *));
	rule.rhs = (char **) OS_TOP_BEGIN (data->srhs);
	rule.rhs [rule.rhs_len] = NULL;
	OS_TOP_FINISH (data->srhs);
	rule.trans = (int *) OS_TOP_BEGIN (data->strans);
	OS_TOP_FINISH (data->strans);
        VLO_ADD_MEMORY (data->srules, &rule, sizeof (rule));
      }
    ;

seq : seq IDENT
       {
	 char *repr = (char *) $2;

	 OS_TOP_ADD_MEMORY (data->srhs, &repr, sizeof (repr));
       }
    | seq CHAR
       {
	  struct sterm term;
	  
	  term.repr = (char *) $2;
	  term.code = term.repr [1];
          term.num = VLO_LENGTH (data->sterms) / sizeof (term);
	  VLO_ADD_MEMORY (data->sterms, &term, sizeof (term));
	  OS_TOP_ADD_MEMORY (data->srhs, &term.repr, sizeof (term.repr));
       }
    |
    ;

trans :     {$$ = NULL;}
      | '#' {$$ = NULL;}
      | '#' NUMBER
        {
	  int symb_num = $2;

  	  $$ = NULL;
	  OS_TOP_ADD_MEMORY (data->strans, &symb_num, sizeof (int));
        }
      | '#' '-'
        {
	  int symb_num = YAEP_NIL_TRANSLATION_NUMBER;

  	  $$ = NULL;
	  OS_TOP_ADD_MEMORY (data->strans, &symb_num, sizeof (int));
        }
      | '#' IDENT cost '(' numbers ')'
        {
	  $$ = $2;
	}
      | '#' IDENT cost
        {
	  $$ = $2;
	}
      ;

numbers :
        | numbers NUMBER
          {
	    int symb_num = $2;
	    
	    OS_TOP_ADD_MEMORY (data->strans, &symb_num, sizeof (int));
          }
        | numbers '-'
          {
	    int symb_num = YAEP_NIL_TRANSLATION_NUMBER;
	    
	    OS_TOP_ADD_MEMORY (data->strans, &symb_num, sizeof (int));
          }
        ;

cost :         { data->anode_cost = 1;}
     | NUMBER  { data->anode_cost = $1; }
     ;
%%

/* The following implements lexical analyzer for yacc code. */
int
yylex (YYSTYPE *lvalp, struct parser_data *data)
{
  int c;
  int n_errs = 0;

  for (;;)
    {
      c = *data->curr_ch++;
      switch (c)
	{
	case '\0':
	  return 0;
	case '\n':
	  data->ln++;
	case '\t':
	case ' ':
	  break;
	case '/':
	  c = *data->curr_ch++;
	  if (c != '*' && n_errs == 0)
	    {
	      n_errs++;
	      data->curr_ch--;
	      yyerror (data, "invalid input character /");
	    }
	  for (;;)
	    {
	      c = *data->curr_ch++;
	      if (c == '\0')
		yyerror (data, "unfinished comment");
	      if (c == '\n')
		data->ln++;
	      if (c == '*')
		{
		  c = *data->curr_ch++;
		  if (c == '/')
		    break;
		  data->curr_ch--;
		}
	    }
	  break;
	case '=':
	case '#':
	case '|':
	case ';':
	case '-':
	case '(':
	case ')':
	  return c;
	case '\'':
	  OS_TOP_ADD_BYTE (data->stoks, '\'');
	  lvalp->num = *data->curr_ch++;
	  OS_TOP_ADD_BYTE (data->stoks, lvalp->num);
	  if (*data->curr_ch++ != '\'')
	    yyerror (data, "invalid character");
	  OS_TOP_ADD_BYTE (data->stoks, '\'');
	  OS_TOP_ADD_BYTE (data->stoks, '\0');
	  lvalp->ref = OS_TOP_BEGIN (data->stoks);
	  OS_TOP_FINISH (data->stoks);
	  return CHAR;
	default:
	  if (isalpha (c) || c == '_')
	    {
	      OS_TOP_ADD_BYTE (data->stoks, c);
	      while ((c = *data->curr_ch++) != '\0' && (isalnum (c)
                                                        || c == '_'))
		OS_TOP_ADD_BYTE (data->stoks, c);
	      data->curr_ch--;
	      OS_TOP_ADD_BYTE (data->stoks, '\0');
	      lvalp->ref = OS_TOP_BEGIN (data->stoks);
	      if (strcmp ((char *) lvalp->ref, "TERM") == 0)
		{
		  OS_TOP_NULLIFY (data->stoks);
		  return TERM;
		}
	      OS_TOP_FINISH (data->stoks);
	      while ((c = *data->curr_ch++) != '\0')
		if (c == '\n')
		  data->ln++;
		else if (c != '\t' && c != ' ')
		  break;
	      if (c != ':')
		data->curr_ch--;
	      return (c == ':' ? SEM_IDENT : IDENT);
	    }
	  else if (isdigit (c))
	    {
	      lvalp->num = c - '0';
	      while ((c = *data->curr_ch++) != '\0' && isdigit (c))
		lvalp->num = lvalp->num * 10 + (c - '0');
	      data->curr_ch--;
	      return NUMBER;
	    }
	  else
	    {
	      n_errs++;
	      if (n_errs == 1)
		{
		  char str[100];

		  if (isprint (c))
		    {
		      sprintf (str, "invalid input character '%c'", c);
		      yyerror (data, str);
		    }
		  else
		    yyerror (data, "invalid input character");
		}
	    }
	}
    }
}


/* The following implements syntactic error diagnostic function yacc
   code. */
int
yyerror (struct parser_data *data, const char *str)
{
  yaep_error (YAEP_DESCRIPTION_SYNTAX_ERROR_CODE,
	      "description syntax error on ln %d", data->ln);
  return 0;
}

/* The following function is used to sort array of syntax terminals by
   names. */
static int
sterm_name_cmp (const void *t1, const void *t2)
{
  return strcmp (((struct sterm *) t1)->repr, ((struct sterm *) t2)->repr);
}

/* The following function is used to sort array of syntax terminals by
   order number. */
static int
sterm_num_cmp (const void *t1, const void *t2)
{
  return ((struct sterm *) t1)->num - ((struct sterm *) t2)->num;
}

static void free_sgrammar (struct parser_data *data);

/* The following is major function which parses the description and
   transforms it into IR. */
static int
set_sgrammar (struct grammar *g, const char *grammar, struct parser_data *data)
{
  int i, j, num;
  struct sterm *term, *prev, *arr;
  int code = 256;

  data->ln = 1;
  if ((code = setjmp (g->error_longjump_buff)) != 0)
    {
      free_sgrammar (data);
      return code;
    }
  OS_CREATE (data->stoks, g->alloc, 0);
  VLO_CREATE (data->sterms, g->alloc, 0);
  VLO_CREATE (data->srules, g->alloc, 0);
  OS_CREATE (data->srhs, g->alloc, 0);
  OS_CREATE (data->strans, g->alloc, 0);
  data->curr_ch = grammar;
  yyparse (data);
  /* sort array of syntax terminals by names. */
  num = VLO_LENGTH (data->sterms) / sizeof (struct sterm);
  arr = (struct sterm *) VLO_BEGIN (data->sterms);
  qsort (arr, num, sizeof (struct sterm), sterm_name_cmp);
  /* Check different codes for the same syntax terminal and remove
     duplicates. */
  for (i = j = 0, prev = NULL; i < num; i++)
    {
      term = arr + i;
      if (prev == NULL || strcmp (prev->repr, term->repr) != 0)
	{
	  prev = term;
	  arr[j++] = *term;
	}
      else if (term->code != -1 && prev->code != -1
	       && prev->code != term->code)
	{
	  char str[YAEP_MAX_ERROR_MESSAGE_LENGTH / 2];

	  strncpy (str, prev->repr, sizeof (str));
	  str[sizeof (str) - 1] = '\0';
	  yaep_error (YAEP_REPEATED_TERM_CODE,
		      "term %s described repeatedly with different code",
		      str);
	}
      else if (prev->code != -1)
	prev->code = term->code;
    }
  VLO_SHORTEN (data->sterms, (num - j) * sizeof (struct sterm));
  num = j;
  /* sort array of syntax terminals by order number. */
  qsort (arr, num, sizeof (struct sterm), sterm_num_cmp);
  /* Assign codes. */
  for (i = 0; i < num; i++)
    {
      term = (struct sterm *) VLO_BEGIN (data->sterms) + i;
      if (term->code < 0)
	term->code = code++;
    }
  data->nsterm = data->nsrule = 0;
  return 0;
}

/* The following frees IR. */
static void
free_sgrammar (struct parser_data *data)
{
  OS_DELETE (data->strans);
  OS_DELETE (data->srhs);
  VLO_DELETE (data->srules);
  VLO_DELETE (data->sterms);
  OS_DELETE (data->stoks);
}

/* The following two functions implements functions used by YAEP. */
static const char *
sread_terminal (int *code)
{
  struct sterm *term;
  const char *name;
  struct parser_data *data;

  data = (struct parser_data *)
    yaep_grammar_getuserptr (yaep_reentrant_hack_grammar (code));
  term = &((struct sterm *) VLO_BEGIN (data->sterms))[data->nsterm];
  if ((char *) term >= (char *) VLO_BOUND (data->sterms))
    return NULL;
  *code = term->code;
  name = term->repr;
  data->nsterm++;
  return name;
}

static const char *
sread_rule (const char ***rhs, const char **abs_node, int *anode_cost,
	    int **transl)
{
  struct srule *rule;
  const char *lhs;
  struct parser_data *data;

  data = (struct parser_data *)
    yaep_grammar_getuserptr (yaep_reentrant_hack_grammar (anode_cost));
  rule = &((struct srule *) VLO_BEGIN (data->srules))[data->nsrule];
  if ((char *) rule >= (char *) VLO_BOUND (data->srules))
    return NULL;
  lhs = rule->lhs;
  *rhs = (const char **) rule->rhs;
  *abs_node = rule->anode;
  *anode_cost = rule->anode_cost;
  *transl = rule->trans;
  data->nsrule++;
  return lhs;
}

/* The following function parses grammar desrciption. */
#ifdef __cplusplus
static
#endif
  int
yaep_parse_grammar (struct grammar *g, int strict_p, const char *description)
{
  int code;
  struct parser_data data;
  void *oldptr;

  assert (g != NULL);
  if ((code = set_sgrammar (g, description, &data)) != 0)
    return code;
  oldptr = yaep_grammar_getuserptr (g);
  yaep_grammar_setuserptr (g, &data);
  code = yaep_read_grammar (g, strict_p, sread_terminal, sread_rule);
  yaep_grammar_setuserptr (g, oldptr);
  free_sgrammar (&data);
  return code;
}
