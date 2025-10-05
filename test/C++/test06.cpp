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

#include<cstdio>
#include <stdlib.h>

#include"common.h"
#include "yaep.h"

static const char *input = "a+a*(a*a+a)";

int
main (void)
{
  yaep *e;
  struct yaep_tree_node *root;
  int ambiguous_p;

  test_input = input;
  e = new yaep ();
  if (e == NULL)
    {
      fprintf (stderr, "yaep::yaep: No memory\n");
      exit (1);
    }
  if (e->parse (test_read_token, test_syntax_error, test_parse_alloc, NULL,
		&root, &ambiguous_p))
    {
      fprintf (stderr, "yaep parse: %s\n", e->error_message ());
      exit (1);
    }
  delete e;
  exit (0);
}
