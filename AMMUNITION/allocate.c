/* FILE NAME:   allocate.c

   Copyright (C) 1997-2007 Vladimir Makarov.

   Written by Vladimir Makarov <vmakarov@users.sourceforge.net>

   This is part of package allocate; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public License
   as published by the Free Software Foundation; either version 2, or
   (at your option) any later version.

   This software is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with GNU CC; see the file COPYING.  If not, write to
   the Free Software Foundation, 59 Temple Place - Suite 330, Boston,
   MA 02111-1307, USA.

   TITLE:       Allocation package (allocation with fixing error)

   DESCRIPTION:
       This file implements the allocation package functions.

*/


#ifdef HAVE_CONFIG_H
#include "cocom-config.h"
#else /* In this case we are oriented to ANSI C */
#endif /* #ifdef HAVE_CONFIG_H */

#include <stdio.h>
#include <stdlib.h>
#include "allocate.h"


/* This function is default action of the package on the situation `no
   memory'.  This action consists of output message `*** no memory
   ***' to standard error stream and calling function `exit' with code
   equals to 1.  This function should be not called directly. */

void
default_allocation_error_function (void)
{
  fputs ("*** no memory ***\n", stderr);
  exit (1);
}

/* Additional memory is reserved for subsequent processing no memory
   error by user-defined function. */

static char *additional_memory = NULL;

/* The following variable value is action on situation `no memory'. */

static void (*current_allocation_error_function) (void)
            = default_allocation_error_function;

/* This function is used for changing up action on the situation `no
   memory'.  the function returns pointer to former function which was
   action on the situation `no_memory'. */

void
(*change_allocation_error_function (void (*error_function) (void))) (void)
{
  void (*result) (void);

  if (additional_memory == NULL)
    additional_memory = malloc (10000);
  result = current_allocation_error_function;
  current_allocation_error_function = error_function;
  return result;
}

/* The following function is used only by package macros.  This is
   internal function of the package. */

void
_allocation_error_function (void)
{
  if (additional_memory != NULL)
    {
      free (additional_memory);
      additional_memory = NULL;
    }
  (*current_allocation_error_function) (); 
}
