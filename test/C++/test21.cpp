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

/* The following variable is the current number of next input grammar
   terminal. */
static int nterm;

/* The following function imported by YAEP (see comments in the interface file). */
const char *
read_terminal (int *code)
{
  nterm++;
  switch (nterm)
    {
    case 1: *code = 'a'; return "a";
    case 2: *code = '+'; return "+";
    case 3: *code = '*'; return "*";
    case 4: *code = '('; return "(";
    case 5: *code = ')'; return ")";
    case 6: *code = 'e'; return "error";
    default: return NULL;
    }
}

/* The following variable is the current number of next rule grammar
   terminal. */
static int nrule;

/* The following function imported by YAEP (see comments in the interface file). */
const char *
read_rule (const char ***rhs, const char **anode, int *anode_cost, int **transl)
{
  static const char *rhs_1 [] = {"T", NULL};
  static int tr_1 [] = {0, -1};
  static const char *rhs_2 [] = {"E", "+", "T", NULL};
  static int tr_2 [] = {0, 2, -1};
  static const char *rhs_3 [] = {"F", NULL};
  static int tr_3 [] = {0, -1};
  static const char *rhs_4 [] = {"T", "*", "F", NULL};
  static int tr_4 [] = {0, 2, -1};
  static const char *rhs_5 [] = {"a", NULL};
  static int tr_5 [] = {0, -1};
  static const char *rhs_6 [] = {"(", "E", ")", NULL};
  static int tr_6 [] = {1, -1};

  nrule++;
  switch (nrule)
    {
    case 1: *rhs = rhs_1; *anode = NULL; *anode_cost = 0; *transl = tr_1;
      return "E";
    case 2: *rhs = rhs_2; *anode = "plus"; *anode_cost = 0; *transl = tr_2;
      return "E";
    case 3: *rhs = rhs_3; *anode = NULL; *anode_cost = 0; *transl = tr_3;
      return "T";
    case 4: *rhs = rhs_4; *anode = "mult"; *anode_cost = 0; *transl = tr_4;
      return "T";
    case 5: *rhs = rhs_5; *anode = NULL; *anode_cost = 0; *transl = tr_5;
      return "F";
    case 6: *rhs = rhs_6; *anode = NULL; *anode_cost = 0; *transl = tr_6;
      return "F";
    default: return NULL;
    }
}

static const char *input = "a+a*(a*a+a)";

int
main (void)
{
  test_standard_read (input, read_terminal, read_rule);
  exit (0);
}
