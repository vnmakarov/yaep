/* FILE NAME:   objstack.cpp

   Copyright (C) 1997-2007 Vladimir Makarov.

   Written by Vladimir Makarov <vmakarov@users.sourceforge.net>

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
       This file implements some functions of the package.

   SPECIAL CONSIDERATION:
         Defining macro `NDEBUG' (e.g. by option `-D' in C++ compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/


#ifdef HAVE_CONFIG_H
#include "cocom-config.h"
#else /* In this case we are oriented to ANSI C */
#ifndef HAVE_ASSERT_H
#define HAVE_ASSERT_H
#endif
#ifndef HAVE_MEMCPY
#define HAVE_MEMCPY
#endif
#endif /* #ifdef HAVE_CONFIG_H */

#include <string.h>

#include "allocate.h"
#include "objstack.h"

#ifdef HAVE_ASSERT_H
#include <assert.h>
#else
#ifndef assert
#define assert(code) do { if (code == 0) abort ();} while (0)
#endif
#endif

/* The following functions is for achieving more portability. */
void
_OS_memcpy (void *to, const void *from, size_t length)
{
#ifdef HAVE_MEMCPY 
  memcpy (to, from, length);
#else
  char *cto = (char *) to;
  const char *cfrom = (const char *) from;

  while (length > 0)
    {
      *cto++ = *cfrom;
      length--;
    }
#endif
}

/* The constructor of OS with given initial segment length. */

os::os (size_t initial_segment_length)
{
  if (initial_segment_length == 0)
    initial_segment_length = OS_DEFAULT_SEGMENT_LENGTH;
  os_current_segment
    = (class _os_segment *) allocate::malloc (initial_segment_length
                                              + sizeof (class _os_segment));
  os_current_segment->os_previous_segment = NULL;
  os_top_object_start
    = (char *) _OS_ALIGNED_ADDRESS (os_current_segment->os_segment_contest);
  os_top_object_free = os_top_object_start;
  os_boundary = os_top_object_start + initial_segment_length;
  initial_segment_length = initial_segment_length;
}

/* The destructor frees memory allocated for OS. */

os::~os (void)
{
  class _os_segment *current_segment, *previous_segment;

  assert (os_top_object_start != NULL);
  os_top_object_start = NULL;
  for (current_segment = os_current_segment; current_segment != NULL;
       current_segment = previous_segment)
    {
      previous_segment = current_segment->os_previous_segment;
      allocate::free (current_segment);
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
      allocate::free (current_segment);
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
  _OS_memcpy (os_top_object_free, str, string_length);
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
  new_segment
    = ((class _os_segment *)
       allocate::malloc (segment_length + sizeof (class _os_segment)));
  new_os_top_object_start
    = (char *) _OS_ALIGNED_ADDRESS (new_segment->os_segment_contest);
  _OS_memcpy (new_os_top_object_start, os_top_object_start,
              os_top_object_length);
  if (os_top_object_start
      == (char *) _OS_ALIGNED_ADDRESS (os_current_segment->os_segment_contest))
    {
      previous_segment = os_current_segment->os_previous_segment;
      allocate::free (os_current_segment);
    }
  else
    previous_segment = os_current_segment;
  os_current_segment = new_segment;
  new_segment->os_previous_segment = previous_segment;
  os_top_object_start = new_os_top_object_start;
  os_top_object_free = os_top_object_start + os_top_object_length;
  os_boundary = os_top_object_start + segment_length;
}
