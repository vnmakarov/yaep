/*
   FILE NAME:   ticker.cpp

   TITLE:       Package for work with ticker

   DESCRIPTION: This simple package slightly makes easy evaluation and
       output of work duration of program components.

*/

#ifdef HAVE_CONFIG_H
#include "cocom-config.h"
#else /* In this case we are oriented to ANSI C */
#endif /* #ifdef HAVE_CONFIG_H */

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

/* The following two functions allocate memory for ticker. */

void *ticker::operator new (size_t size)
{
  return allocate::malloc (size);
}

void *ticker::operator new[] (size_t size)
{
  return allocate::malloc (size);
}

/* The following two functions free memory for ticker. */

void ticker::operator delete (void *mem)
{
  allocate::free (mem);
}

void ticker::operator delete[] (void *mem)
{
  allocate::free (mem);
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
