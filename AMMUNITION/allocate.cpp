/*
   FILE NAME:   allocate.cpp

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
   equals to 1. */

void
allocate::default_error_function (void)
{
  fputs ("*** no memory ***\n", stderr);
  exit (1);
}

/* Additional memory is reserved for subsequent processing no memory
   error by user-defined function. */

static char *additional_memory = NULL;

/* The following variable is to be used only by the package functions. */

static void (*current_allocation_error_function) (void)
            = allocate::default_error_function;


/* This function is used for changing up action on the situation `no
   memory'.  the function returns pointer to former function which was
   action on the situation `no_memory'. */

void
(*allocate::change_error_function (void (*error_function) (void))) (void)
{
  void (*result) (void);

  if (additional_memory == NULL)
    additional_memory = (char *)::malloc (10000);
  result = current_allocation_error_function;
  current_allocation_error_function = error_function;
  return result;
}

/* The following function is used only by package macros.  This is
   internal function of the package. */

void
allocate::allocation_error_function (void)
{
  if (additional_memory != NULL)
    {
      ::free (additional_memory);
      additional_memory = NULL;
    }
  (*current_allocation_error_function) (); 
}
