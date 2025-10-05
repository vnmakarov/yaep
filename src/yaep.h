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

/* This is interface file of general (working on any CFG) syntax
   parser with minimal error recovery and syntax directed translation.
   The algorithm is originated from Earley's algorithm.  The algorithm
   is sufficiently fast to be used in serious language processors. */

#ifndef __YAEP__
#define __YAEP__

#include <limits.h>

/* Encoding expectations
   ---------------------
   YAEP expects UTF-8 encoded input for public string APIs such as grammar
   descriptions, symbol names and abstract node labels. The project contains
   helpers and a small wrapper around utf8proc in `src/unicode/yaep_unicode.*`
   that can be used to validate, classify, truncate and normalize UTF-8
   strings. If invalid UTF-8 is encountered in a call that requires valid
   UTF-8, YAEP uses the error code `YAEP_INVALID_UTF8` (see below).
*/

/* The following is a forward declaration of grammar formed by function
   yaep_read_grammar. */
struct grammar;

/* (internal) per-parse context is private to src/yaep.c and not exposed
   in the public header. */

/* The following value is reserved to be designation of empty node for
   translation.  It should be positive number which is not intersected
   with symbol numbers. */
#define YAEP_NIL_TRANSLATION_NUMBER       INT_MAX

/* The following values are YAEP error codes. */

#define YAEP_NO_MEMORY                     1
#define YAEP_UNDEFINED_OR_BAD_GRAMMAR      2
#define YAEP_DESCRIPTION_SYNTAX_ERROR_CODE 3
#define YAEP_FIXED_NAME_USAGE              4
#define YAEP_REPEATED_TERM_DECL            5
#define YAEP_NEGATIVE_TERM_CODE            6
#define YAEP_REPEATED_TERM_CODE            7
#define YAEP_NO_RULES                      8
#define YAEP_TERM_IN_RULE_LHS              9
#define YAEP_INCORRECT_TRANSLATION         10
#define YAEP_NEGATIVE_COST                 11
#define YAEP_INCORRECT_SYMBOL_NUMBER       12
#define YAEP_REPEATED_SYMBOL_NUMBER        13
#define YAEP_UNACCESSIBLE_NONTERM          14
#define YAEP_NONTERM_DERIVATION            15
#define YAEP_LOOP_NONTERM                  16
#define YAEP_INVALID_TOKEN_CODE            17
#define YAEP_INVALID_UTF8                  18

/* The following describes the type of parse tree node. */
enum yaep_tree_node_type
{
  YAEP_NIL,
  YAEP_ERROR,
  YAEP_TERM,
  YAEP_ANODE,
  YAEP_ALT,
  _yaep_VISITED = 0x80, /* _yaep_VISITED is not part of the interface and for internal use only */
  _yaep_MAX = 0xFF, /* _yaep_MAX is not part of the interface and is just here to ensure a logical OR of _yaep_VISITED with the other enum values does not produce an out-of-range enum */
};

/* The following node exists in one example. See comment to read_rule. */
struct yaep_nil
{
  /* Whether this node has been used in the parse tree. */
  int used;
};

/* The following node exists in one example.  It is used as
   translation of pseudo terminal `error'. */
struct yaep_error
{
  /* Whether this node has been used in the parse tree. */
  int used;
};

/* The following structure describes terminal node. */
struct yaep_term
{
  /* The terminal code. */
  int code;
  /* The terminal attributes. */
  void *attr;
};

/* The following structure describes abstract node. */
struct yaep_anode
{
  /* The abstract node name. */
  const char *name;
  /* The following value is cost of the node plus costs of all
     children if the cost flag is set up.  Otherwise, the value is cost
     of the abstract node itself. */
  int cost;
  /* References for nodes for which the abstract node refers.  The end
     marker of the array is value NULL. */
  struct yaep_tree_node **children;
};

/* The following structure is not part of the interface and for internal use only */
struct _yaep_anode_name {
  /* Allocated abstract node name. */
  char * name;
};

/* The following structure describes alternatives in the parse tree.
   Which are presents only for ambiguous grammar. */
struct yaep_alt
{
  /* The node (all node types but alternative) for this
     alternative. */
  struct yaep_tree_node *node;
  /* The next alternative. */
  struct yaep_tree_node *next;
};

/* The following structure describes generalized node of the parse
   tree. */
struct yaep_tree_node
{
  /* The type of node. */
  enum yaep_tree_node_type type;
  /* The node itself. */
  union
  {
    struct yaep_nil nil;
    struct yaep_error error;
    struct yaep_term term;
    struct yaep_anode anode;
    struct _yaep_anode_name _anode_name; /* Internal use only */
    struct yaep_alt alt;
  } val;
};

#ifndef __cplusplus

/* The following function creates undefined grammar.  The function
   returns NULL if there is no memory.  This function should be called
   the first. */
extern struct grammar *yaep_create_grammar (void);

/* The function returns the last occurred error code for given
   grammar. */
extern int yaep_error_code (struct grammar *g);

/* The function returns message are always contains error message
   corresponding to the last occurred error code. */
extern const char *yaep_error_message (struct grammar *g);

/* The following function reads terminals/rules into grammar G and
   checks it depending on STRICT_P.  It returns zero if it is all ok.
   Otherwise, the function returns error code occurred (its code will
   be in yaep_error_code and message in yaep_error_message).

   READ_TERMINAL is function for reading terminals.  This function is
   called before function read_rule.  The function should return the
   name and the code of the next terminal.  If all terminals have been
   read the function returns NULL.  The return code should be
   nonnegative.

   READ_RULE is function called to read the next rule.  This function
   is called after function read_terminal.  The function should return
   the name of LHS rule and array of names of symbols in RHS of the
   rule (the array end marker should be NULL).  If all rules have been
   read the function returns NULL.  All symbol with name which was not
   provided the previous function are considered to be nonterminal.
   The function also returns translation given by abstract node name
   and its fields which will be translation of symbols (with indexes
   given in array *TRANSL) in the RHS of the rule.  All indexes in
   TRANSL should be different (so the translation of a symbol can not
   be represented twice).  The end marker of the array should be a
   negative value.  There is a reserved value of the translation
   symbol number denoting empty node.  It is value defined by macro
   YAEP_NIL_TRANSLATION_NUMBER.  If *TRANSL is NULL or contains only
   the end marker, translations of the rule will be nil node.  If
   ABS_NODE is NULL, abstract node is not created.  In this case
   *TRANSL should be NULL or contain at most one element which means
   that the translation of the rule will be nil node or the
   translation of the symbol in RHS given by the single array element.
   The cost of the abstract node if given is passed through
   ANODE_COST. */
extern int
yaep_read_grammar (struct grammar *g, int strict_p,
		   const char *(*read_terminal) (int *code),
		   const char *(*read_rule) (const char ***rhs,
					     const char **abs_node,
                                             int *anode_cost,
					     int **transl));

/* The following function is analogous to the previous one but it
   parses grammar description. */
extern int
yaep_parse_grammar (struct grammar *g, int strict_p,
		    const char *description);

/* The following functions set up different parameters which affect
   parser work.  The functions return the previous parameter value.

   o lookahead_level means usage of static (if 1) or dynamic (2)
     lookahead to decrease size of sets.  Static lookaheads gives the
     best results with the point of space and speed, dynamic ones does
     slightly worse, and no usage of lookaheads does the worst.  The
     default value is 1.

   o debug_level says what debugging information to output (it works
     only if we compiled without defined macro NO_YAEP_DEBUG_PRINT).
     The default value is 0.

   o one_parse_flag means building only one parse tree.  For
     unambiguous grammar the flag does not affect the result.  The
     default value is 1.

   o cost_flag means usage costs to build tree (trees if
     one_parse_flag is not set up) with minimal cost.  For unambiguous
     grammar the flag does not affect the result.  The default value
     is 0.

   o error_recovery_flag means making error recovery if syntax error
     occurred.  Otherwise, syntax error results in finishing parsing
     (although syntax_error is called once).  The default value is 1.

   o recovery_match means how much subsequent tokens should be
     successfully shifted to finish error recovery.  The default value
     is 3. */
extern int yaep_set_lookahead_level (struct grammar *grammar, int level);
extern int yaep_set_debug_level (struct grammar *grammar, int level);
extern int yaep_set_one_parse_flag (struct grammar *grammar, int flag);
extern int yaep_set_cost_flag (struct grammar *grammar, int flag);
extern int yaep_set_error_recovery_flag (struct grammar *grammar, int flag);
extern int yaep_set_recovery_match (struct grammar *grammar, int n_toks);

/* The following function parses input according read grammar.  The
   function returns the error code (which will be also in
   yaep_error_code).  If the code is zero, the function will also
   The *root will be NULL only if syntax error was occurred and error
   recovery was switched off).  The function sets up *AMBIGOUS_P if we
   found that the grammar is ambiguous (it works even we asked only one
   parse tree without alternatives).

   The function READ_TOKEN provides input tokens.  It returns code the
   next input token and its attribute.  If the function returns
   negative value we've read all tokens.

   Function SYNTAX_ERROR prints error message about syntax error
   which occurred on token with number ERR_TOK_NUM and attribute
   ERR_TOK_ATTR.  The following four parameters describes made error
   recovery which ignored tokens starting with token given by 3rd and
   4th parameters.  The first token which was not ignored is described
   by the last parameters.  If the number of ignored tokens is zero,
   the all parameters describes the same token.  If the error recovery
   is not made (see comments for function
   `yaep_set_error_recovery_flag'), the third and fifth parameters
   will be negative and forth and sixth parameters will be NULL.


   Function PARSE_ALLOC is used by YAEP to allocate memory
   for parse tree representation.  After calling yaep_fin we free
   all memory allocated by yaep parser.  At this point it is
   convenient to free all memory but parse tree.  Therefore we require
   the following function. If PARSE_ALLOC is a null pointer, then
   PARSE_FREE must also be a null pointer. In this case, YAEP will
   handle the memory management. Otherwise, the caller will be responsible to
   allocate and free memory for parse tree representation.  But the
   caller should not free the memory until yaep_fin is called.  The
   function may be called even during reading the grammar not only
   during the parsing.  Function PARSE_FREE is used by the parser to
   free memory allocated by PARSE_ALLOC. If PARSE_ALLOC is not NULL
   but PARSE_FREE is, the memory is not freed. In this case, the
   returned parse tree should also not be freed with yaep_free_tree(). */
extern int yaep_parse (struct grammar *grammar,
		       int (*read_token) (void **attr),
		       void (*syntax_error) (int err_tok_num,
					     void *err_tok_attr,
					     int start_ignored_tok_num,
					     void *start_ignored_tok_attr,
					     int start_recovered_tok_num,
					     void *start_recovered_tok_attr),
		       void *(*parse_alloc) (int nmemb),
		       void (*parse_free) (void *mem),
		       struct yaep_tree_node **root,
		       int *ambiguous_p);

/* The following function frees memory allocated for the grammar. */
extern void yaep_free_grammar (struct grammar *grammar);

/* The following function frees memory allocated for the parse tree.
   It must not be called until after yaep_free_grammar() has been called.
   ROOT must be the root of the parse tree as returned by yaep_parse().
   If ROOT is a null pointer, no operation is performed.
   Otherwise, the argument passed for PARSE_FREE must be the same as passed for
   the parameter of the same name in yaep_parse() (but do not call this
   function with PARSE_FREE a null pointer if you called yaep_parse()
   with PARSE_ALLOC not a null pointer).
   Otherwise, if TERMCB is not a null pointer, it will be called
   exactly once for each term node in the parse tree.
   The TERMCB callback can be used by the caller
   to free the term attributes. The term node itself must not be freed. */
extern void yaep_free_tree( struct yaep_tree_node * root, void ( *parse_free )( void * ), void ( *termcb )( struct yaep_term * term ) );

#else /* #ifndef __cplusplus */

class yaep
{
  struct grammar *grammar;

public:

  /* The following constructor and destructor allocate and free memory
     for the grammar. */
  yaep (void);
  ~yaep (void);

  /* This function is used for freeing memory allocated for OS except
     for the first segment. */

  /* See comments for function yaep_error_code. */
  int error_code (void);

  /* See comments for function yaep_error_message. */
  const char *error_message (void);

  /* See comments for function yaep_read_grammar. */
  int read_grammar (int strict_p,
			   const char *(*read_terminal) (int *code),
			   const char *(*read_rule) (const char ***rhs,
						     const char **abs_node,
						     int *anode_cost,
						     int **transl));

  /* See comments for function yaep_parse_grammar. */
  int parse_grammar (int strict_p, const char *description);

  /* See comments for corresponding C functions. */
  int set_lookahead_level (int level);
  int set_debug_level (int level);
  int set_one_parse_flag (int flag);
  int set_cost_flag (int flag);
  int set_error_recovery_flag (int flag);
  int set_recovery_match (int n_toks);

  /* See comments for function yaep_parse. */
  int parse (int (*read_token) (void **attr),
	     void (*syntax_error) (int err_tok_num,
				   void *err_tok_attr,
				   int start_ignored_tok_num,
				   void *start_ignored_tok_attr,
				   int start_recovered_tok_num,
				   void *start_recovered_tok_attr),
	     void *(*parse_alloc) (int nmemb),
	     void (*parse_free) (void *mem),
	     struct yaep_tree_node **root,
	     int *ambiguous_p);

  /* See comments for function yaep_free_tree().
     This is a static member function because the lifetime of the
     parse tree exceeds the lifetime of the yaep instance it
     came from. */
  static void free_tree( struct yaep_tree_node * root, void ( *parse_free )( void * ), void ( *termcb )( struct yaep_term * term ) );
};

#endif /* #ifndef __cplusplus */

#endif /* #ifndef __YAEP__ */
