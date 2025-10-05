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
#include <string.h>

#include <assert.h>

#include "yaep_unicode.h"

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

/* The following vlos contain all syntax terminal and syntax rule
   structures. */
#ifndef __cplusplus
static vlo_t sterms, srules;
#else
static vlo_t *sterms, *srules;
#endif

/* The following contain all right hand sides and translations arrays.
   See members rhs, trans in structure `rule'. */
#ifndef __cplusplus
static os_t srhs, strans; 
#else
static os_t *srhs, *strans; 
#endif

/* The following is cost of the last translation which contains an
   abstract node. */
static int anode_cost;

/* This variable is used in yacc action to process alternatives. */
static char *slhs;

/* Forward declarations. */
extern int yyerror (const char *str);
extern int yylex (void);
extern int yyparse (void);

%}

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
          term.num = VLO_LENGTH (sterms) / sizeof (term);
	  VLO_ADD_MEMORY (sterms, &term, sizeof (term));
	}
      | TERM
      ;

number :            {$$ = -1;}
       | '=' NUMBER {$$ = $2;}
       ;

rule : SEM_IDENT {slhs = (char *) $1;} rhs opt_sem
     ;

rhs : rhs '|' alt
    | alt
    ;

alt : seq trans
      {
	struct srule rule;
	int end_marker = -1;

	OS_TOP_ADD_MEMORY (strans, &end_marker, sizeof (int));
	rule.lhs = slhs;
	rule.anode = (char *) $2;
	rule.anode_cost = (rule.anode == NULL ? 0 : anode_cost);
	rule.rhs_len = OS_TOP_LENGTH (srhs) / sizeof (char *);
	OS_TOP_EXPAND (srhs, sizeof (char *));
	rule.rhs = (char **) OS_TOP_BEGIN (srhs);
	rule.rhs [rule.rhs_len] = NULL;
	OS_TOP_FINISH (srhs);
	rule.trans = (int *) OS_TOP_BEGIN (strans);
	OS_TOP_FINISH (strans);
        VLO_ADD_MEMORY (srules, &rule, sizeof (rule));
      }
    ;

seq : seq IDENT
       {
	 char *repr = (char *) $2;

	 OS_TOP_ADD_MEMORY (srhs, &repr, sizeof (repr));
       }
    | seq CHAR
       {
	  struct sterm term;
	  
	  term.repr = (char *) $2;
	  {
	    size_t repr_len = strlen (term.repr);
	    yaep_codepoint_t literal_cp;
	    /* yylex appends the decoded code point directly after the NUL
	       terminator so we can recover it without maintaining a side table. */
	    memcpy (&literal_cp,
		    term.repr + repr_len + 1,
		    sizeof (literal_cp));
	    term.code = (int) literal_cp;
	  }
          term.num = VLO_LENGTH (sterms) / sizeof (term);
	  VLO_ADD_MEMORY (sterms, &term, sizeof (term));
	  OS_TOP_ADD_MEMORY (srhs, &term.repr, sizeof (term.repr));
       }
    |
    ;

trans :     {$$ = NULL;}
      | '#' {$$ = NULL;}
      | '#' NUMBER
        {
	  int symb_num = $2;

  	  $$ = NULL;
	  OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
        }
      | '#' '-'
        {
	  int symb_num = YAEP_NIL_TRANSLATION_NUMBER;

  	  $$ = NULL;
	  OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
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
	    
	    OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
          }
        | numbers '-'
          {
	    int symb_num = YAEP_NIL_TRANSLATION_NUMBER;
	    
	    OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
          }
        ;

cost :         { anode_cost = 1;}
     | NUMBER  { anode_cost = $1; }
     ;
%%
/* The following is current input character of the grammar
   description. */
static const char *curr_ch;

/* The following is current line number of the grammar description. */
static int ln;

/* The following contains all representation of the syntax tokens. */
#ifndef __cplusplus
static os_t stoks;
#else
static os_t *stoks;
#endif

/* The following is number of syntax terminal and syntax rules being
   read. */
static int nsterm, nsrule;

/* The following implements lexical analyzer for yacc code.
 * 
 * This lexer has been updated to support UTF-8 encoded grammar descriptions.
 * It uses yaep_utf8_next() to iterate through code points rather than bytes,
 * and yaep_utf8_isalpha/isalnum/isdigit for character classification.
 *
 * ASCII Fast Path: The UTF-8 functions are optimized for ASCII, so there
 * is minimal overhead for typical (ASCII-only) grammars.
 *
 * Error Handling: Invalid UTF-8 sequences are detected and reported as
 * lexical errors with appropriate diagnostic messages.
 */
int
yylex (void)
{
  yaep_codepoint_t cp;
  const char *tok_start;
  int n_errs = 0;

  for (;;)
    {
      /* Save the position before reading the next code point,
       * in case we need to report errors at this location. */
      tok_start = curr_ch;
      cp = yaep_utf8_next(&curr_ch);
      
      /* Check for UTF-8 decoding errors */
      if (cp == YAEP_CODEPOINT_INVALID)
	{
	  if (n_errs == 0)
	    {
	      yyerror ("invalid UTF-8 sequence in grammar");
	      n_errs++;
	    }
	  continue;
	}
      
      /* End of string */
      if (cp == YAEP_CODEPOINT_EOS)
	return 0;
      
      /* Handle ASCII characters that map directly to single-byte checks.
       * For these, the code point value equals the byte value. */
      if (cp < 128)
	{
	  switch (cp)
	    {
	    case '\n':
	      ln++;
	    case '\t':
	    case ' ':
	      break;
	    case '/':
	      /* Comment handling */
	      cp = yaep_utf8_next(&curr_ch);
	      if (cp != '*' && n_errs == 0)
		{
		  n_errs++;
		  curr_ch = tok_start + 1; /* Back up to after the '/' */
		  yyerror ("invalid input character /");
		}
	      for (;;)
		{
		  cp = yaep_utf8_next(&curr_ch);
		  if (cp == YAEP_CODEPOINT_EOS)
		    yyerror ("unfinished comment");
		  if (cp == YAEP_CODEPOINT_INVALID)
		    {
		      if (n_errs == 0)
			{
			  yyerror ("invalid UTF-8 in comment");
			  n_errs++;
			}
		      continue;
		    }
		  if (cp == '\n')
		    ln++;
		  if (cp == '*')
		    {
		      const char *star_pos = curr_ch;
		      cp = yaep_utf8_next(&curr_ch);
		      if (cp == '/')
			break;
		      curr_ch = star_pos; /* Back up if not end of comment */
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
	      return (int)cp;
			case '\'':
				{
					/* Character literal: 'x' where x can be any single Unicode scalar.
						 We preserve the exact UTF-8 bytes so downstream consumers see the
						 literal exactly as authored, and we append the decoded code point
						 after the NUL terminator for later retrieval. */
					const char *repr_start = tok_start;
					yaep_codepoint_t literal_cp;
					yaep_codepoint_t closing_cp;

					literal_cp = yaep_utf8_next (&curr_ch);
					if (literal_cp == YAEP_CODEPOINT_EOS || literal_cp == YAEP_CODEPOINT_INVALID)
						{
							yyerror ("invalid character literal");
							break;
						}

					closing_cp = yaep_utf8_next (&curr_ch);
					if (closing_cp != '\'')
						{
							yyerror ("unterminated character literal");
							break;
						}

					{
						size_t repr_len = curr_ch - repr_start;
						yaep_codepoint_t stored_cp = literal_cp;

						OS_TOP_ADD_MEMORY (stoks, repr_start, repr_len);
						OS_TOP_ADD_BYTE (stoks, '\0');
						OS_TOP_ADD_MEMORY (stoks, &stored_cp, sizeof (stored_cp));
						yylval.ref = OS_TOP_BEGIN (stoks);
						OS_TOP_FINISH (stoks);
					}

					return CHAR;
				}
	    default:
	      /* Check if this is the start of an identifier (ASCII fast path) */
	      if ((cp >= 'A' && cp <= 'Z') || (cp >= 'a' && cp <= 'z') || cp == '_')
		goto identifier;
		/* Check if this is the start of a number (ASCII fast path) */
		if (cp >= '0' && cp <= '9')
		goto number;
	      /* Otherwise, this is an error */
	      goto error;
	    }
	}
      else
	{
	  /* Non-ASCII code point: classify using Unicode predicates. */
	  if (yaep_utf8_isdigit (cp))
	    goto number;
	  if (yaep_utf8_isalpha (cp))
	    goto identifier;
	  /* Otherwise, it's an invalid token */
	  goto error;
	}
      continue;

    identifier:
      /* Identifier: starts with letter or underscore, continues with
       * alphanumeric or underscore. Now supports full Unicode identifiers. */
      {
	const char *id_start = tok_start;
	int id_byte_len;

	/*
	 * Iterate with `yaep_utf8_next_with_len` which returns the decoded
	 * code point and the number of bytes consumed.  This lets the lexer
	 * advance and remember byte boundaries without reparsing from the
	 * token start.  The previous implementation re-parsed from
	 * `id_start` to back up when a non-identifier character was found;
	 * that was correct but redundant and costlier.  Using the _with_len
	 * helper makes the code simpler and more efficient while preserving
	 * exact byte-level semantics.
	 */
	{
	  const char *p = curr_ch;
	  const char *last_good = id_start; /* last pointer just after a valid cp */
	  size_t bytes_len = 0;
	  yaep_codepoint_t test_cp;

	  /* The first code point was already validated as a start character; mark it */
	  last_good = curr_ch;

	  while ((test_cp = yaep_utf8_next_with_len(&p, &bytes_len)) != YAEP_CODEPOINT_EOS &&
	         test_cp != YAEP_CODEPOINT_INVALID)
	    {
	      if (!yaep_utf8_isalnum(test_cp) && test_cp != '_')
	        break;
	      /* Advance last_good to the byte position after this code point */
	      last_good = p;
	    }

		/* Set curr_ch to the last byte position that is still part of the identifier */
		curr_ch = last_good;
		}

		/* Now compute byte length for copying */
	id_byte_len = curr_ch - id_start;
	for (int i = 0; i < id_byte_len; i++)
	  /* Ensure bytes are treated as unsigned when stored: avoid
	     platform-dependent sign-extension later during hashing or
	     byte-wise operations. Store each source byte as an
	     unsigned char value. */
	  OS_TOP_ADD_BYTE (stoks, (unsigned char) id_start[i]);
	OS_TOP_ADD_BYTE (stoks, '\0');
	yylval.ref = OS_TOP_BEGIN (stoks);
	
	/* Check for keyword "TERM" */
	if (strcmp ((char *) yylval.ref, "TERM") == 0)
	  {
	    OS_TOP_NULLIFY (stoks);
	    return TERM;
	  }
	OS_TOP_FINISH (stoks);
	
	/* Skip whitespace and check for ':' to distinguish identifiers.
	 * We need to look ahead past whitespace to see if there's a ':' character.
	 * If not, we need to back up curr_ch to before the first non-whitespace char.
	 */
	const char *before_nonws = curr_ch; /* Position before any whitespace */
	while ((cp = yaep_utf8_next(&curr_ch)) != YAEP_CODEPOINT_EOS)
	  {
	    if (cp == YAEP_CODEPOINT_INVALID)
	      {
		if (n_errs == 0)
		  {
		    yyerror ("invalid UTF-8 after identifier");
		    n_errs++;
		  }
		continue;
	      }
	    if (cp == '\n')
	      {
		ln++;
		before_nonws = curr_ch;
	      }
	    else if (yaep_utf8_isspace(cp))
	      {
		before_nonws = curr_ch;
	      }
	    else
	      {
		/* Found non-whitespace character. If it's not ':', back up. */
		if (cp != ':')
		  curr_ch = before_nonws;
		break;
	      }
	  }
	
	return (cp == ':' ? SEM_IDENT : IDENT);
      }

			number:
				{
					/* Number: sequence of Unicode decimal digits (Nd).  We track the
						 originating block so that scripts cannot be mixed within a single
						 literal, mirroring guidance from UAX #31. */
					int digit_value;
					yaep_codepoint_t digit_block;
					const char *digit_boundary;

				if (!yaep_utf8_digit_value (cp, &digit_value, &digit_block))
					{
						if (n_errs == 0)
							{
								yyerror ("invalid digit in number literal");
								n_errs++;
							}
						return NUMBER;
					}

				yylval.num = digit_value;

				for (;;)
					{
						digit_boundary = curr_ch;
						yaep_codepoint_t next_cp = yaep_utf8_next (&curr_ch);

						if (next_cp == YAEP_CODEPOINT_EOS)
							break;

						if (next_cp == YAEP_CODEPOINT_INVALID)
							{
								if (n_errs == 0)
									{
										yyerror ("invalid UTF-8 in number literal");
										n_errs++;
									}
								break;
							}

						int next_digit;
						yaep_codepoint_t next_block;
						if (!yaep_utf8_digit_value (next_cp, &next_digit, &next_block))
							{
								curr_ch = digit_boundary;
								break;
							}

						if (next_block != digit_block)
							{
								if (n_errs == 0)
									{
										yyerror ("mixed-digit Unicode number literal");
										n_errs++;
									}
								curr_ch = digit_boundary;
								break;
							}

						yylval.num = yylval.num * 10 + next_digit;
					}

				return NUMBER;
			}

    error:
      /* Invalid character encountered */
      n_errs++;
			if (n_errs == 1)
		{
			char str[YAEP_MAX_ERROR_MESSAGE_LENGTH / 2];
			int written = 0;

			if (cp < 128 && isprint((int)cp))
				written = snprintf (str, sizeof (str), "invalid input character '%c'", (char)cp);
			else if (cp >= 0)
				written = snprintf (str, sizeof (str), "invalid input character U+%04X", cp);
			else
				written = snprintf (str, sizeof (str), "invalid UTF-8 sequence");

			/* Ensure NUL termination and pass to yyerror */
			if (written < 0)
				str[0] = '\0';
			else
				str[sizeof (str) - 1] = '\0';
			yyerror (str);
		}
    }
}


/* The following implements syntactic error diagnostic function yacc
   code. */
int
yyerror (const char *str)
{
  (void) str;
  yaep_error (YAEP_DESCRIPTION_SYNTAX_ERROR_CODE,
	      "description syntax error on ln %d", ln);
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

static void free_sgrammar (void);

/* The following is major function which parses the description and
   transforms it into IR. */
static int
set_sgrammar (struct grammar *g, const char *grammar)
{
  int i, j, num;
  struct sterm *term, *prev, *arr;
  int code = 256;

  ln = 1;
  if ((code = setjmp (error_longjump_buff)) != 0)
    {
      free_sgrammar ();
      return code;
    }
  OS_CREATE (stoks, g->alloc, 0);
  VLO_CREATE (sterms, g->alloc, 0);
  VLO_CREATE (srules, g->alloc, 0);
  OS_CREATE (srhs, g->alloc, 0);
  OS_CREATE (strans, g->alloc, 0);
  curr_ch = grammar;
  yyparse ();
  /* sort array of syntax terminals by names. */
  num = VLO_LENGTH (sterms) / sizeof (struct sterm);
  arr = (struct sterm *) VLO_BEGIN (sterms);
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
  VLO_SHORTEN (sterms, (num - j) * sizeof (struct sterm));
  num = j;
  /* sort array of syntax terminals by order number. */
  qsort (arr, num, sizeof (struct sterm), sterm_num_cmp);
  /* Assign codes. */
  for (i = 0; i < num; i++)
    {
      term = (struct sterm *) VLO_BEGIN (sterms) + i;
      if (term->code < 0)
	term->code = code++;
    }
  nsterm = nsrule = 0;
  return 0;
}

/* The following frees IR. */
static void
free_sgrammar (void)
{
  OS_DELETE (strans);
  OS_DELETE (srhs);
  VLO_DELETE (srules);
  VLO_DELETE (sterms);
  OS_DELETE (stoks);
}

/* The following two functions implements functions used by YAEP. */
static const char *
sread_terminal (int *code)
{
  struct sterm *term;
  const char *name;

  term = &((struct sterm *) VLO_BEGIN (sterms))[nsterm];
  if ((char *) term >= (char *) VLO_BOUND (sterms))
    return NULL;
  *code = term->code;
  name = term->repr;
  nsterm++;
  return name;
}

static const char *
sread_rule (const char ***rhs, const char **abs_node, int *anode_cost,
	    int **transl)
{
  struct srule *rule;
  const char *lhs;

  rule = &((struct srule *) VLO_BEGIN (srules))[nsrule];
  if ((char *) rule >= (char *) VLO_BOUND (srules))
    return NULL;
  lhs = rule->lhs;
  *rhs = (const char **) rule->rhs;
  *abs_node = rule->anode;
  *anode_cost = rule->anode_cost;
  *transl = rule->trans;
  nsrule++;
  return lhs;
}

/* The following function parses grammar desrciption. */
int
yaep_parse_grammar (struct grammar *g, int strict_p, const char *description)
{
	int code;
	size_t error_offset = 0;
	int validation_error = 0;

	assert (g != NULL);
	grammar = g;
	if (!yaep_utf8_validate (description, NULL,
													 &error_offset, &validation_error))
		{
			const char *msg = yaep_utf8_error_message (validation_error);

			g->error_code = YAEP_INVALID_UTF8;
			snprintf (g->error_message, sizeof (g->error_message),
								"invalid UTF-8 in grammar description at byte %zu: %s",
								error_offset, msg);
			return YAEP_INVALID_UTF8;
		}
  if ((code = set_sgrammar (g, description)) != 0)
    return code;
  code = yaep_read_grammar (g, strict_p, sread_terminal, sread_rule);
  free_sgrammar ();
  return code;
}
