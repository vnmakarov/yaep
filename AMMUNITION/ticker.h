/*
   FILE NAME:   ticker.h

   TITLE:       Include file of package for work with tickers (timers)

   DESCRIPTION: This header file contains type definition and ANSI C
       prototype definitions of the package functions and C++ class of
       the ticker.

*/

#ifndef __TICKER__

#define __TICKER__

#ifdef HAVE_CONFIG_H
#include "cocom-config.h"
#else /* In this case we are oriented to ANSI C */
#define HAVE_TIME_H
#endif /* #ifdef HAVE_CONFIG_H */

#ifdef HAVE_TIME_H
#include <time.h>
#else
#include <sys/types.h>
extern clock_t clock (void);
#endif

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

  void *operator new (size_t);
  void *operator new[] (size_t);
  void operator delete (void *);
  void operator delete[] (void *);

  void ticker_on (void);
  void ticker_off (void);
  double active_time (void);
  const char *active_time_string (void);
};

/* The ticker is represented also by the following type. */

typedef class ticker ticker_t;

#endif /* #ifndef __cplusplus */

#endif /* __TICKER__ */
