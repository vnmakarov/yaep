/* FILE NAME:   objstack.c

   Copyright (C) 1997-2015 Vladimir Makarov.

   Written by Vladimir Makarov <vmakarov@gcc.gnu.org>

   This is part of package for work with stack of objects; you can
   redistribute it and/or modify it under the terms of the GNU Library
   General Public License as published by the Free Software
   Foundation; either version 2, or (at your option) any later
   version.

   This software is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with GNU CC; see the file COPYING.  If not, write to
   the Free Software Foundation, 59 Temple Place - Suite 330, Boston,
   MA 02111-1307, USA.

   TITLE:       Package for work with stacks of objects (OS)

   DESCRIPTION:
       This file implements internal functions of the package.

   SPECIAL CONSIDERATION:
       The following functions are to be used only by the package
       macros.  Remember that they are internal functions - all work
       with OS is executed through the macros.
         Defining macro `NDEBUG' (e.g. by option `-D' in C compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/

#include <string.h>
#include "allocate.h"

#include "objstack.h"

#include <assert.h>

/* The function implements macro `OS_CREATE' (creation of stack of
   object).  OS must be created before any using other macros of the
   package for work with given OS. */

void
_OS_create_function (os_t * os, size_t initial_segment_length)
{
  if (initial_segment_length == 0)
    initial_segment_length = OS_DEFAULT_SEGMENT_LENGTH;
  os->os_current_segment =
    yaep_malloc (os->os_alloc,
		 initial_segment_length + sizeof (struct _os_segment));
  os->os_current_segment->os_previous_segment = NULL;
  os->os_top_object_start
    =
    (char *) _OS_ALIGNED_ADDRESS (os->os_current_segment->os_segment_contest);
  os->os_top_object_free = os->os_top_object_start;
  os->os_boundary = os->os_top_object_start + initial_segment_length;
  os->initial_segment_length = initial_segment_length;
}

/* The function implements macro `OS_DELETE' (freeing memory allocated
   for OS).  Any work (except for creation) with given OS is not
   possible after evaluation of this macros.  The macro has not side
   effects. */

void
_OS_delete_function (os_t * os)
{
  struct _os_segment *current_segment, *previous_segment;

  assert (os->os_top_object_start != NULL);
  os->os_top_object_start = NULL;
  for (current_segment = os->os_current_segment; current_segment != NULL;
       current_segment = previous_segment)
    {
      previous_segment = current_segment->os_previous_segment;
      yaep_free (os->os_alloc, current_segment);
    }
}

/* The following function implements macro `OS_EMPTY' (freeing memory
   allocated for OS except for the first segment). */

void
_OS_empty_function (os_t * os)
{
  struct _os_segment *current_segment, *previous_segment;

  assert (os->os_top_object_start != NULL && os->os_current_segment != NULL);
  current_segment = os->os_current_segment;
  for (;;)
    {
      previous_segment = current_segment->os_previous_segment;
      if (previous_segment == NULL)
	break;
      yaep_free (os->os_alloc, current_segment);
      current_segment = previous_segment;
    }
  os->os_current_segment = current_segment;
  os->os_top_object_start
    = (char *) _OS_ALIGNED_ADDRESS (current_segment->os_segment_contest);
  os->os_top_object_free = os->os_top_object_start;
  os->os_boundary = os->os_top_object_start + os->initial_segment_length;
}

/* The function implements macro `OS_ADD_STRING' (addition of string
   STR (with end marker is '\0') to the end of OS).  Remember that the
   OS place may be changed after the call. */

void
_OS_add_string_function (os_t * os, const char *str)
{
  size_t string_length;

  assert (os->os_top_object_start != NULL);
  if (str == NULL)
    return;
  if (os->os_top_object_free != os->os_top_object_start)
    OS_TOP_SHORTEN (*os, 1);
  string_length = strlen (str) + 1;
  if (os->os_top_object_free + string_length > os->os_boundary)
    _OS_expand_memory (os, string_length);
  memcpy( os->os_top_object_free, str, string_length );
  os->os_top_object_free = os->os_top_object_free + string_length;
}

/* The function creates new segment for OS.  The segment becames
   current and its size becames equal to about one and a half of the
   top object length accounting for length of memory which will be
   added after the call (but not less than the default segment
   length).  The function deletes the segment which was current if the
   segment contained only the top object.  Remember that the top
   object place may be changed after the call. */

void
_OS_expand_memory (os_t * os, size_t additional_length)
{
  size_t os_top_object_length, segment_length;
  struct _os_segment *new_segment, *previous_segment;
  char *new_os_top_object_start;

  assert (os->os_top_object_start != NULL);
  os_top_object_length = OS_TOP_LENGTH (*os);
  segment_length = os_top_object_length + additional_length;
  segment_length += segment_length / 2 + 1;
  if (segment_length < OS_DEFAULT_SEGMENT_LENGTH)
    segment_length = OS_DEFAULT_SEGMENT_LENGTH;
  new_segment =
    yaep_malloc (os->os_alloc, segment_length + sizeof (struct _os_segment));
  new_os_top_object_start =
    (char *) _OS_ALIGNED_ADDRESS (new_segment->os_segment_contest);
  memcpy (new_os_top_object_start, os->os_top_object_start,
	      os_top_object_length);
  if (os->os_top_object_start ==
      (char *) _OS_ALIGNED_ADDRESS (os->os_current_segment->
				    os_segment_contest))
    {
      previous_segment = os->os_current_segment->os_previous_segment;
      yaep_free (os->os_alloc, os->os_current_segment);
    }
  else
    previous_segment = os->os_current_segment;
  os->os_current_segment = new_segment;
  new_segment->os_previous_segment = previous_segment;
  os->os_top_object_start = new_os_top_object_start;
  os->os_top_object_free = os->os_top_object_start + os_top_object_length;
  os->os_boundary = os->os_top_object_start + segment_length;
}
