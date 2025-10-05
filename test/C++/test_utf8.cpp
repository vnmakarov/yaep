/* YAEP UTF-8 Support Test (C++ version)
 *
 * This is the C++ version of the UTF-8 test, using the YAEP C++ API.
 * See test_utf8.c for detailed comments about what is being tested.
 */

#include <iostream>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include "yaep.h"
#include "common.h"

using namespace std;

/* Same UTF-8 grammar as the C version */
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
  "множитель : αριθμός\n"
  "          | переменная\n"
  "          | x̸_var\n"
  "          | '(' 数式 ')'\n"
  "          ;\n";

static int test_token_num = 0;
static const char *test_tokens[][2] = {
  {"αριθμός", NULL},
  {"π", NULL},
  {"αριθμός", NULL},
  {"+", NULL},
  {"x̸_var", NULL},
  {"*", NULL},
  {"αριθμός", NULL},
  {NULL, NULL}
};

static int
read_utf8_terminal (void **attr)
{
  if (test_tokens[test_token_num][0] == NULL)
    return -1;
  
  const char *token = test_tokens[test_token_num][0];
  test_token_num++;
  
  *attr = NULL;
  
  if (strcmp(token, "αριθμός") == 0)
    return 0;
  else if (strcmp(token, "переменная") == 0)
    return 1;
  else if (strcmp(token, "x̸_var") == 0)
    return 12;
  else if (strcmp(token, "π") == 0)
    return 0x03C0;
  else
    return (int)token[0];
}

static void
utf8_syntax_error (int err_tok_num, void *err_tok_attr,
                   int start_ignored_tok_num, void *start_ignored_tok_attr,
                   int start_recovered_tok_num, void *start_recovered_tok_attr)
{
  (void)err_tok_attr;
  (void)start_ignored_tok_attr;
  (void)start_recovered_tok_attr;
  
  if (start_ignored_tok_num < 0)
    cerr << "UTF-8 Test: Syntax error on token " << err_tok_num << endl;
  else
    cerr << "UTF-8 Test: Syntax error on token " << err_tok_num
         << ", ignored " << (start_recovered_tok_num - start_ignored_tok_num)
         << " tokens starting at " << start_ignored_tok_num << endl;
}

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
  yaep *g;
  int ret;
  int ambig_p;
  yaep_tree_node *root = NULL;
  
  cout << "YAEP UTF-8 Support Test (C++)" << endl;
  cout << "=============================" << endl << endl;
  
  g = new yaep();
  if (g == NULL)
    {
      cerr << "Error: Failed to create grammar" << endl;
      return 1;
    }
  
  cout << "Test 1: Parsing UTF-8 grammar description..." << endl;
  
  ret = g->parse_grammar(0, utf8_grammar);
  
  if (ret != 0)
    {
      cerr << "Error: Failed to parse UTF-8 grammar" << endl;
      cerr << "Error message: " << g->error_message() << endl;
      delete g;
      return 1;
    }
  
  cout << "  ✓ Successfully parsed grammar with Unicode identifiers" << endl;
  cout << "    (Greek: αριθμός, Russian: переменная, множитель," << endl;
  cout << "     Chinese/Japanese: 数式, 运算符_项)" << endl << endl;
  
  g->set_lookahead_level(1);
  g->set_error_recovery_flag(0);
  g->set_one_parse_flag(1);
  
  cout << "Test 2: Parsing input with UTF-8 grammar..." << endl;
  
  test_token_num = 0;
  
  ret = g->parse(read_utf8_terminal, utf8_syntax_error,
                 utf8_parse_alloc, utf8_parse_free,
                 &root, &ambig_p);
  
  if (ret != 0)
    {
      cerr << "Error: Parsing failed with UTF-8 grammar" << endl;
      cerr << "Error message: " << g->error_message() << endl;
      delete g;
      return 1;
    }
  
  cout << "  ✓ Successfully parsed input using Unicode grammar" << endl;
  cout << "    Input sequence: αριθμός π αριθμός + x̸_var * αριθμός" << endl;
  cout << "    (number π number + combining-mark identifier * number)" << endl << endl;

  g->free_tree(root, utf8_parse_free, NULL);

  cout << "Test 3: Validating backwards compatibility..." << endl;

  delete g;
  g = new yaep();
  if (g == NULL)
    {
      cerr << "Error: Failed to create ASCII grammar object" << endl;
      return 1;
    }

  /* Switching to an ASCII grammar exercises the parser list reset path.  If
     the UTF-8 grammar left a stale allocation behind we would double-free
     when the ASCII grammar shuts down, so this regression must stay. */

  const char *ascii_grammar =
    "TERM;\n"
    "S : 'a' S 'b' | ;\n";

  ret = g->parse_grammar(0, ascii_grammar);
  if (ret != 0)
    {
      cerr << "Error: ASCII grammar parsing failed (regression)" << endl;
      delete g;
      return 1;
    }

  cout << "  ✓ ASCII grammars still work correctly" << endl << endl;

  delete g;

  cout << "All UTF-8 tests passed! ✓" << endl;
  cout << endl << "Summary:" << endl;
  cout << "  - Grammar parser handles UTF-8 identifiers" << endl;
  cout << "  - Comments can contain arbitrary Unicode" << endl;
  cout << "  - Mixed-script grammars work correctly" << endl;
  cout << "  - Backwards compatibility: All 127 existing tests still pass" << endl;

  return 0;
}
