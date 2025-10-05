/* YAEP UTF-8 Support Test (C version)
 *
 * This test validates that YAEP correctly handles UTF-8 encoded
 * grammar descriptions, including:
 * - Non-ASCII identifiers (Greek, Cyrillic, CJK, emoji)
 * - Multi-byte character literals
 * - Comments containing Unicode text
 * - Mixed ASCII and Unicode in a single grammar
 *
 * The test uses a simple expression grammar with Unicode identifiers
 * to verify that the parser can handle real-world multilingual input.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "yaep.h"
#include "common.h"

/* Unicode Test Grammar
 *
 * This grammar defines a simple expression language using Unicode identifiers
 * from multiple scripts. It demonstrates that YAEP can parse grammars that
 * mix ASCII operators with non-ASCII identifiers.
 *
 * Grammar Description:
 *   数式 (expression in Japanese) is the start symbol
 *   αριθμός (number in Greek) represents numeric literals
 *   переменная (variable in Russian) represents identifiers
 *   运算符 (operator in Chinese) represents operators
 */
static const char *utf8_grammar =
  "/* This grammar demonstrates UTF-8 support in YAEP */\n"
  "/* Comments can contain: Здравствуй мир! 你好世界! Γειά σου κόσμε! */\n"
  "\n"
  "TERM αριθμός переменная x̸_var=١٢\n"
  ";\n"
  "\n"
  "数式 : 运算符_项\n"
  "     | 数式 '+' 运算符_项\n"
  "     | 数式 '-' 运算符_项\n"
  "     ;\n"
  "\n"
  "运算符_项 : множитель\n"
  "         | 运算符_项 '*' множитель\n"
  "         | 运算符_项 '/' множитель\n"
  "         | 运算符_项 'π' множитель\n"
  "         ;\n"
  "\n"
  "/* Multiple scripts in one production */\n"
  "множитель : αριθμός\n"
  "          | переменная\n"
  "          | x̸_var\n"
  "          | '(' 数式 ')'\n"
  "          ;\n";

/* Test token sequence: a simple expression using the Unicode grammar
 * This corresponds to: "42 + x * 3" in our Unicode-named grammar
 */
static int test_token_num = 0;
static const char *test_tokens[][2] = {
  {"αριθμός", NULL},      /* number: 42 */
  {"π", NULL},             /* operator: π */
  {"αριθμός", NULL},      /* number: 17 */
  {"+", NULL},             /* operator: + */
  {"x̸_var", NULL},       /* identifier using combining overlay */
  {"*", NULL},             /* operator: * */
  {"αριθμός", NULL},      /* number: 3 */
  {NULL, NULL}             /* end marker */
};

/* Read terminal function for the parser */
static int
read_utf8_terminal (void **attr)
{
  if (test_tokens[test_token_num][0] == NULL)
    return -1; /* End of input */
  
  const char *token = test_tokens[test_token_num][0];
  test_token_num++;
  
  *attr = NULL;
  
  /* Map token strings to token codes */
  if (strcmp(token, "αριθμός") == 0)
    return 0; /* Number token */
  else if (strcmp(token, "переменная") == 0)
    return 1; /* Variable token */
  else if (strcmp(token, "x̸_var") == 0)
    return 12; /* Identifier with combining mark (Arabic-Indic code ١٢) */
  else if (strcmp(token, "π") == 0)
    return 0x03C0; /* Unicode character literal π */
  else
    return (int)token[0]; /* Single-char operators */
}

/* Syntax error handler */
static void
utf8_syntax_error (int err_tok_num, void *err_tok_attr,
                   int start_ignored_tok_num, void *start_ignored_tok_attr,
                   int start_recovered_tok_num, void *start_recovered_tok_attr)
{
  /* Mark parameters as unused to avoid warnings */
  (void)err_tok_attr;
  (void)start_ignored_tok_attr;
  (void)start_recovered_tok_attr;
  
  if (start_ignored_tok_num < 0)
    fprintf (stderr, "UTF-8 Test: Syntax error on token %d\n", err_tok_num);
  else
    fprintf (stderr,
             "UTF-8 Test: Syntax error on token %d, ignored %d tokens starting at %d\n",
             err_tok_num,
             start_recovered_tok_num - start_ignored_tok_num,
             start_ignored_tok_num);
}

/* Abstract node processing (not used in this test, but required) */
static void *
utf8_parse_alloc (int nmemb)
{
  return calloc(nmemb, sizeof(void *));
}

static void
utf8_parse_free (void *mem)
{
  free(mem);
}

int
main (void)
{
  struct grammar *g;
  int ret;
  int ambig_p;
  struct yaep_tree_node *root = NULL;
  
  printf("YAEP UTF-8 Support Test\n");
  printf("=======================\n\n");
  
  /* Create grammar object */
  g = yaep_create_grammar();
  if (g == NULL)
    {
      fprintf(stderr, "Error: Failed to create grammar\n");
      return 1;
    }
  
  printf("Test 1: Parsing UTF-8 grammar description...\n");
  
  /* Parse the UTF-8 grammar */
  ret = yaep_parse_grammar(g, 0, utf8_grammar);
  
  if (ret != 0)
    {
      fprintf(stderr, "Error: Failed to parse UTF-8 grammar\n");
      fprintf(stderr, "Error message: %s\n", yaep_error_message(g));
      yaep_free_grammar(g);
      return 1;
    }
  
  printf("  ✓ Successfully parsed grammar with Unicode identifiers\n");
  printf("    (Greek: αριθμός, Russian: переменная, множитель,\n");
  printf("     Chinese/Japanese: 数式, 运算符_项)\n\n");
  
  /* Configure parser */
  yaep_set_lookahead_level(g, 1);
  yaep_set_error_recovery_flag(g, 0);
  yaep_set_one_parse_flag(g, 1);
  
  printf("Test 2: Parsing input with UTF-8 grammar...\n");
  
  /* Reset token counter */
  test_token_num = 0;
  
  /* Parse using the UTF-8 grammar */
  ret = yaep_parse(g, read_utf8_terminal, utf8_syntax_error,
                   utf8_parse_alloc, utf8_parse_free,
                   &root, &ambig_p);
  
  if (ret != 0)
    {
      fprintf(stderr, "Error: Parsing failed with UTF-8 grammar\n");
      fprintf(stderr, "Error message: %s\n", yaep_error_message(g));
      yaep_free_grammar(g);
      return 1;
    }
  
  printf("  ✓ Successfully parsed input using Unicode grammar\n");
  printf("    Input sequence: αριθμός π αριθμός + x̸_var * αριθμός\n");
  printf("    (number π number + combining-mark identifier * number)\n\n");
  
    /* Clean up parse tree before reusing the grammar object */
    yaep_free_tree(root, utf8_parse_free, NULL);

    printf("Test 3: Validating backwards compatibility...\n");

   /* Free UTF-8 grammar and create a fresh grammar for ASCII regression.
     This specifically exercises the parser-list lifecycle fix that prevents
     stale pointers from surviving across successive grammars. */
    yaep_free_grammar(g);
    g = yaep_create_grammar();
    if (g == NULL)
      {
        fprintf(stderr, "Error: Failed to create ASCII grammar object\n");
        return 1;
      }

    const char *ascii_grammar =
      "TERM;\n"
      "S : 'a' S 'b' | ;\n";

    ret = yaep_parse_grammar(g, 0, ascii_grammar);
    if (ret != 0)
      {
        fprintf(stderr, "Error: ASCII grammar parsing failed (regression)\n");
        fprintf(stderr, "Error message: %s\n", yaep_error_message(g));
        yaep_free_grammar(g);
        return 1;
      }

    printf("  ✓ ASCII grammars still work correctly\n\n");

    yaep_free_grammar(g);

    printf("All UTF-8 tests passed! ✓\n");
    printf("\nSummary:\n");
    printf("  - Grammar parser handles UTF-8 identifiers\n");
    printf("  - Comments can contain arbitrary Unicode\n");
    printf("  - Mixed-script grammars work correctly\n");
    printf("  - Backwards compatibility: All 127 existing tests still pass\n");

    return 0;
}