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

/* FILE NAME:   vlobject.c

   TITLE:       Package for work with variable length objects (VLO)

   DESCRIPTION:
       This file implements internal functions of the package.

   SPECIAL CONSIDERATION:
       The following functions are to be used only by the package
       macros.  Remember that they are internal functions - all work
       with VLO is executed through the macros.
         Defining macro `NDEBUG' (e.g. by option `-D' in C compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/

#include <string.h>

#include "allocate.h"
#include "vlobject.h"

#include <assert.h>

/* The following function changes size of memory allocated for VLO.
   The size becames equal to about one and a half of VLO length
   accounting for length of memory which will be added after the call.
   Remember that the VLO place may be changed after the call. */

void
_VLO_expand_memory (vlo_t * vlo, size_t additional_length)
{
  size_t vlo_length;
  char *new_vlo_start;

  assert (vlo->vlo_start != NULL);
  vlo_length = VLO_LENGTH (vlo) + additional_length;
  vlo_length += vlo_length / 2 + 1;
  new_vlo_start = yaep_realloc (vlo->vlo_alloc, vlo->vlo_start, vlo_length);
  if (new_vlo_start != vlo->vlo_start)
    {
      vlo->vlo_free += new_vlo_start - vlo->vlo_start;
      vlo->vlo_start = new_vlo_start;
    }
  vlo->vlo_boundary = vlo->vlo_start + vlo_length;
}
