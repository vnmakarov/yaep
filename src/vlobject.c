/* FILE NAME:   vlobject.c

   Copyright (C) 1997-2015 Vladimir Makarov.

   Written by Vladimir Makarov <vmakarov@gcc.gnu.org>

   This is part of package for work with variable length objects; you
   can redistribute it and/or modify it under the terms of the GNU
   Library General Public License as published by the Free Software
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

/* The function implements macro `VLO_TAILOR'.  Length of memory
   allocated for VLO becames equal to VLO length (but memory for zero
   length object will contain one byte).  Remember that the VLO place
   may be changed after the call. */

void
_VLO_tailor_function (vlo_t * vlo)
{
  size_t vlo_length;
  char *new_vlo_start;

  assert (vlo->vlo_start != NULL);
  vlo_length = VLO_LENGTH (*vlo);
  if (vlo_length == 0)
    vlo_length = 1;
  new_vlo_start = yaep_realloc (vlo->vlo_alloc, vlo->vlo_start, vlo_length);
  if (new_vlo_start != vlo->vlo_start)
    {
      vlo->vlo_free += new_vlo_start - vlo->vlo_start;
      vlo->vlo_start = new_vlo_start;
    }
  vlo->vlo_boundary = vlo->vlo_start + vlo_length;
}

/* The following function implements macro `VLO_ADD_STRING' (addition
   of string STR (with end marker is '\0') to the end of VLO).
   Remember that the VLO place may be changed after the call. */

void
_VLO_add_string_function (vlo_t * vlo, const char *str)
{
  size_t length;

  assert (vlo->vlo_start != NULL);
  if (str == NULL)
    return;
  if (vlo->vlo_free != vlo->vlo_start)
    VLO_SHORTEN (*vlo, 1);
  length = strlen (str) + 1;
  if (vlo->vlo_free + length > vlo->vlo_boundary)
    _VLO_expand_memory (vlo, length);
  memcpy( vlo->vlo_free, str, length );
  vlo->vlo_free = vlo->vlo_free + length;
}

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
  vlo_length = VLO_LENGTH (*vlo) + additional_length;
  vlo_length += vlo_length / 2 + 1;
  new_vlo_start = yaep_realloc (vlo->vlo_alloc, vlo->vlo_start, vlo_length);
  if (new_vlo_start != vlo->vlo_start)
    {
      vlo->vlo_free += new_vlo_start - vlo->vlo_start;
      vlo->vlo_start = new_vlo_start;
    }
  vlo->vlo_boundary = vlo->vlo_start + vlo_length;
}
