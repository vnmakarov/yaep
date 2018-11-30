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

#include <stdlib.h>

#include"common.h"

static const char *input = "a+((a*a)+a)";

static const char *description =
"\n"
"E : V '+' V                 # add  1 (0 2)\n"
"  | V '*' V                 # mult 1 (0 2)\n"
"  | V '+' '(' V '*' V ')'   # madd 1 (0 3 5)\n"
"  | '(' V '*' V ')' '+' V   # madd 1 (6 1 3)\n"
"  ;\n"
"V : 'a'                     # 0\n"
"  | '(' E ')'               # 1\n"
"  ;\n"
  ;

int main (int argc, char **argv)
{
  test_complex_parse (1, 1, 1, 0, argc, argv);
  exit (0);
}
