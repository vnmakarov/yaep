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

/* FILE NAME:   vlobject.cpp

   TITLE:       Package for work with variable length objects (VLO)

   DESCRIPTION:
       This file implements some functions of the package.

   SPECIAL CONSIDERATION:
         Defining macro `NDEBUG' (e.g. by option `-D' in C++ compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/

#include <string.h>

#include "allocate.h"
#include "vlobject.h"

#include <assert.h>

/* Length of memory allocated for VLO becames equal to VLO length (but
   memory for zero length object will contain one byte).  Remember
   that the VLO place may be changed after the call. */

void
vlo::tailor (void)
{
  size_t vlo_length;
  char *new_vlo_start;

  assert (vlo_start != NULL);
  vlo_length = length ();
  if (vlo_length == 0)
    vlo_length = 1;
  new_vlo_start = (char *) yaep_realloc (vlo_alloc, vlo_start, vlo_length);
  if (new_vlo_start != vlo_start)
    {
      vlo_free += new_vlo_start - vlo_start;
      vlo_start = new_vlo_start;
    }
  vlo_boundary = vlo_start + vlo_length;
}

/* The following function implements addition of string STR (with end
   marker is '\0') to the end of VLO.  Remember that the VLO place may
   be changed after the call. */

void
vlo::add_string (const char *str)
{
  size_t length;

  assert (vlo_start != NULL);
  if (str == NULL)
    return;
  if (vlo_free != vlo_start)
    shorten (1);
  length = strlen (str) + 1;
  if (vlo_free + length > vlo_boundary)
    _VLO_expand_memory (length);
  memcpy( vlo_free, str, length );
  vlo_free = vlo_free + length;
}

/* The following function changes size of memory allocated for VLO.
   The size becames equal to about one and a half of VLO length
   accounting for length of memory which will be added after the call.
   Remember that the VLO place may be changed after the call. */

void
vlo::_VLO_expand_memory (size_t additional_length)
{
  size_t vlo_length;
  char *new_vlo_start;

  assert (vlo_start);
  vlo_length = length () + additional_length;
  vlo_length += vlo_length / 2 + 1;
  new_vlo_start = (char *) yaep_realloc (vlo_alloc, vlo_start, vlo_length);
  if (new_vlo_start != vlo_start)
    {
      vlo_free += new_vlo_start - vlo_start;
      vlo_start = new_vlo_start;
    }
  vlo_boundary = vlo_start + vlo_length;
}
