/* FILE NAME:   ticker.cpp

   Copyright (C) 1997-2015 Vladimir Makarov.

   Written by Vladimir Makarov <vmakarov@gcc.gnu.org>

   This is part of package for work with tickers; you can redistribute
   it and/or modify it under the terms of the GNU Library General
   Public License as published by the Free Software Foundation; either
   version 2, or (at your option) any later version.

   This software is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU Library General Public
   License along with GNU CC; see the file COPYING.  If not, write to
   the Free Software Foundation, 59 Temple Place - Suite 330, Boston,
   MA 02111-1307, USA.

   TITLE:       Package for work with ticker

   DESCRIPTION: This simple package slightly makes easy evaluation and
       output of work duration of program components.

*/

#include <stdio.h>
#include "allocate.h"
#include "ticker.h"

/* We don't use times or getrusage here because they have the same
   accuracy as clock on major machines Linux, Solaris, AIX.  The
   single difference is IRIX on which getrusage is more accurate. */

/* The following macro is necessary for non standard include files of
   SUNOS 4..., linux */

#ifndef CLOCKS_PER_SECOND
#ifdef CLOCKS_PER_SEC
#define CLOCKS_PER_SECOND CLOCKS_PER_SEC
#elif __linux__
#define CLOCKS_PER_SECOND 100
#elif sun
#define CLOCKS_PER_SECOND 1000000
#elif CLK_TCK
#define CLOCKS_PER_SECOND CLK_TCK
#else
#error define macro CLOCKS_PER_SECOND
#endif
#endif /* CLOCKS_PER_SECOND */

/* The following function ticker constructor. */

ticker::ticker (void)
{
  modified_creation_time = clock ();
  incremented_off_time = 0;
}

/* The following function switches off given ticker. */

void
ticker::ticker_off (void)
{
  if (incremented_off_time == 0)
    incremented_off_time = clock () + 1;
}

/* The following function switches on given ticker. */

void
ticker::ticker_on (void)
{
  if (incremented_off_time != 0)
    {
      modified_creation_time += clock () - incremented_off_time + 1;
      incremented_off_time = 0;
    }
}

/* The following function returns current time since the moment when
   given ticker was created.  The result is measured in seconds as
   float number. */

double
ticker::active_time (void)
{
  if (incremented_off_time != 0)
    return (((double) (incremented_off_time - 1 - modified_creation_time))
            / CLOCKS_PER_SECOND);
  else
    return ((double) (clock () - modified_creation_time)) / CLOCKS_PER_SECOND;
}

/* The following function returns string representation of active time
   of given ticker.  The result is string representation of seconds with
   accuracy of 1/100 second.  Only result of the last call of the
   function exists.  Therefore the following code is not correct

      printf ("parser time: %s\ngeneration time: %s\n",
              parser_ticker.active_time_string (),
              generation_ticker.active_time_string ());

   Correct code has to be the following

      printf ("parser time: %s\n", parser_ticker.active_time_string ());
      printf ("generation time: %s\n",
              generation_ticker.active_time_string ());

*/

static char array[40];
char *ticker::last_call_active_time_string = array;

const char *
ticker::active_time_string (void)
{
  sprintf (last_call_active_time_string, "%.2f", active_time ());
  return last_call_active_time_string;
}
