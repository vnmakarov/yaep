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

#include<stdio.h>
#include <stdlib.h>

#include"common.h"
#include "yaep.h"

static const char *input = "a+a*(a*a+a)";

static const char *description =
"\n"
"TERM;\n"
"E : T         # 0\n"
"  | E '+' T   # plus (0 2)\n"
"  ;\n"
"T : F         # 0\n"
"  | T '*' F   # mult (0 2)\n"
"  ;\n"
"F : 'a'       # 0\n"
"  | '(' E ')' # 1\n"
"  ;\n"
  ;

main ()
{
  struct grammar *g;
  struct yaep_tree_node *root;
  int ambiguous_p;

  if ((g = yaep_create_grammar ()) == NULL)
    {
      fprintf (stderr, "yaep_create_grammar: No memory\n");
      exit (1);
    }
  if ( yaep_parse( g, test_read_token, test_syntax_error, test_parse_alloc, test_parse_free, &root, &ambiguous_p ) ) {
      fprintf (stderr, "yaep parse: %s\n", yaep_error_message (g));
      exit (1);
    }
  yaep_free_grammar (g);
  exit (0);
}
