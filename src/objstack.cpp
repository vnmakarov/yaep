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

/* FILE NAME:   objstack.cpp

   TITLE:       Package for work with stacks of objects (OS)

   DESCRIPTION:
       This file implements some functions of the package.

   SPECIAL CONSIDERATION:
         Defining macro `NDEBUG' (e.g. by option `-D' in C++ compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/

#include <string.h>

#include "allocate.h"
#include "objstack.h"

#include <assert.h>

/* The constructor of OS with given initial segment length. */

os::os (YaepAllocator * allocator, size_t initial_segment_length):os_alloc (allocator)
{
  if (initial_segment_length == 0)
    initial_segment_length = OS_DEFAULT_SEGMENT_LENGTH;
  os_current_segment =
    (_os_segment *) yaep_malloc (os_alloc,
				 initial_segment_length + sizeof (_os_segment));
  os_current_segment->os_previous_segment = NULL;
  os_top_object_start
    = (char *) _OS_ALIGNED_ADDRESS (os_current_segment->os_segment_contest);
  os_top_object_free = os_top_object_start;
  os_boundary = os_top_object_start + initial_segment_length;
  this->initial_segment_length = initial_segment_length;
}

/* The destructor frees memory allocated for OS. */

os::~os (void)
{
  class _os_segment *current_segment, *previous_segment;

  assert (os_top_object_start != NULL);
  os_top_object_start = NULL;
  for (current_segment = os_current_segment;
       current_segment != NULL;
       current_segment = previous_segment)
    {
      previous_segment = current_segment->os_previous_segment;
      yaep_free (os_alloc, current_segment);
    }
}

/* The following function frees memory allocated for OS except for the
   first segment. */

void
os::empty (void)
{
  class _os_segment *current_segment, *previous_segment;

  assert (os_top_object_start != NULL && os_current_segment != NULL);
  current_segment = os_current_segment;
  for (;;)
    {
      previous_segment = current_segment->os_previous_segment;
      if (previous_segment == NULL)
	break;
      yaep_free (os_alloc, current_segment);
      current_segment = previous_segment;
    }
  os_current_segment = current_segment;
  os_top_object_start
    = (char *) _OS_ALIGNED_ADDRESS (current_segment->os_segment_contest);
  os_top_object_free = os_top_object_start;
  os_boundary = os_top_object_start + initial_segment_length;
}

/* The function implements addition of string STR (with end marker is
   '\0') to the end of OS).  Remember that the OS place may be changed
   after the call. */

void
os::top_add_string (const char *str)
{
  size_t string_length;

  assert (os_top_object_start != NULL);
  if (str == NULL)
    return;
  if (os_top_object_free != os_top_object_start)
    top_shorten (1);
  string_length = strlen (str) + 1;
  if (os_top_object_free + string_length > os_boundary)
    _OS_expand_memory (string_length);
  memcpy( os_top_object_free, str, string_length );
  os_top_object_free = os_top_object_free + string_length;
}

/* The function creates new segment for OS.  The segment becames
   current and its size becames equal to about one and a half of the
   top object length accounting for length of memory which will be
   added after the call (but not less than the default segment
   length).  The function deletes the segment which was current if the
   segment contained only the top object.  Remember that the top
   object place may be changed after the call. */

void
os::_OS_expand_memory (size_t additional_length)
{
  size_t os_top_object_length, segment_length;
  class _os_segment *new_segment, *previous_segment;
  char *new_os_top_object_start;

  assert (os_top_object_start);
  os_top_object_length = top_length ();
  segment_length = os_top_object_length + additional_length;
  segment_length += segment_length / 2 + 1;
  if (segment_length < OS_DEFAULT_SEGMENT_LENGTH)
    segment_length = OS_DEFAULT_SEGMENT_LENGTH;
  new_segment =
    (_os_segment *) yaep_malloc (os_alloc, segment_length + sizeof (_os_segment));
  new_os_top_object_start =
    (char *) _OS_ALIGNED_ADDRESS (new_segment->os_segment_contest);
  memcpy (new_os_top_object_start, os_top_object_start, os_top_object_length);
  if (os_top_object_start ==
      (char *) _OS_ALIGNED_ADDRESS (os_current_segment->os_segment_contest))
    {
      previous_segment = os_current_segment->os_previous_segment;
      yaep_free (os_alloc, os_current_segment);
    }
  else
    previous_segment = os_current_segment;
  os_current_segment = new_segment;
  new_segment->os_previous_segment = previous_segment;
  os_top_object_start = new_os_top_object_start;
  os_top_object_free = os_top_object_start + os_top_object_length;
  os_boundary = os_top_object_start + segment_length;
}
