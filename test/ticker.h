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

/* FILE NAME:   ticker.h

   TITLE:       Include file of package for work with tickers (timers)

   DESCRIPTION: This header file contains type definition and ANSI C
       prototype definitions of the package functions and C++ class of
       the ticker.

*/

#ifndef __TICKER__

#define __TICKER__

#include <time.h>

#ifndef __cplusplus


/* The following structure describes a ticker. */

struct ticker
{
  /* The following member value is time of the ticker creation with
     taking into account time when the ticker is off.  Active time of
     the ticker is current time minus the value. */
  clock_t modified_creation_time;
  /* The following member value is time (incremented by one) when the
     ticker was off.  Zero value means that now the ticker is on. */
  clock_t incremented_off_time;
};

/* The ticker is represented by the following type. */

typedef struct ticker ticker_t;

/* The prototypes of the package functions: */

extern ticker_t create_ticker (void);

extern void ticker_off (ticker_t *ticker);

extern void ticker_on (ticker_t *ticker);

extern double active_time (ticker_t ticker);

extern const char *active_time_string (ticker_t ticker);


#else /* #ifndef __cplusplus */


/* The following class describes a ticker. */

class ticker
{
  /* The following member value is time of the ticker creation with
     taking into account time when the ticker is off.  Active time of
     the ticker is current time minus the value. */
  clock_t modified_creation_time;
  /* The following member value is time (incremented by one) when the
     ticker was off.  Zero value means that now the ticker is on. */
  clock_t incremented_off_time;
  /* The following class member refers the result of the latest call
     of function `active_time_string'. */
  static char *last_call_active_time_string;
public:
  ticker (void);

  void ticker_on (void);
  void ticker_off (void);
  double active_time (void);
  const char *active_time_string (void);
};

/* The ticker is represented also by the following type. */

typedef class ticker ticker_t;

#endif /* #ifndef __cplusplus */

#endif /* __TICKER__ */
