/* FILE NAME:   hashtab.c

   Copyright (C) 1997-2007 Vladimir Makarov.

   Written by Vladimir Makarov <vmakarov@users.sourceforge.net>

   This is part of package for work with hash tables; you can
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

   TITLE:       Package for work with hash tables

   DESCRIPTION: This package implements features analogous to ones of
       public domain functions `hsearch', `hcreate' and `hdestroy'.
       The goal of the package creation is to implement additional
       needed features.  The abstract data permits to work
       simultaneously with several expandable hash tables.  Besides
       insertion and search of elements the elements from the hash
       tables can be also removed.  The table element can be only a
       pointer.  The size of hash tables is not fixed.  The hash table
       will be expanded when its occupancy will became big.  The
       abstract data implementation is based on generalized Algorithm
       D from Knuth's book "The art of computer programming".  Hash
       table is expanded by creation of new hash table and
       transferring elements from the old table to the new table.

   SPECIAL CONSIDERATION:
         Defining macro `NDEBUG' (e.g. by option `-D' in C compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/


#ifdef HAVE_CONFIG_H
#include "cocom-config.h"
#else /* In this case we are oriented to ANSI C */
#ifndef HAVE_ASSERT_H
#define HAVE_ASSERT_H
#endif
#endif /* #ifdef HAVE_CONFIG_H */


#include "allocate.h"
#include "hashtab.h"

#ifdef HAVE_ASSERT_H
#include <assert.h>
#else
#ifndef assert
#define assert(code) do { if (code == 0) abort ();} while (0)
#endif
#endif

/* This macro defines reserved value for empty table entry. */

#define EMPTY_ENTRY    NULL

/* This macro defines reserved value for table entry which contained
   a deleted element. */

#define DELETED_ENTRY  ((void *) 1)

/* The following function returns the nearest prime number which is
   greater than given source number. */

static unsigned long
higher_prime_number (unsigned long number)
{
  unsigned long i;

  for (number = (number / 2) * 2 + 3;; number += 2)
    {
      for (i = 3; i * i <= number; i += 2)
        if (number % i == 0)
          break;
      if (i * i > number)
        return number;
    }
}

/* This function creates table with length slightly longer than given
   source length.  Created hash table is initiated as empty (all the
   hash table entries are EMPTY_ENTRY).  The function returns the
   created hash table. */

hash_table_t
create_hash_table (size_t size,
                   unsigned (*hash_function) (hash_table_entry_t el_ptr),
                   int (*eq_function) (hash_table_entry_t el1_ptr,
                                       hash_table_entry_t el2_ptr))
{
  hash_table_t result;
  hash_table_entry_t *entry_ptr;

  size = higher_prime_number (size);
  MALLOC (result, sizeof (*result));
  MALLOC (result->entries, size * sizeof (hash_table_entry_t));
  result->size = size;
  result->hash_function = hash_function;
  result->eq_function = eq_function;
  result->number_of_elements = 0;
  result->number_of_deleted_elements = 0;
  result->searches = 0;
  result->collisions = 0;
  for (entry_ptr = result->entries;
       entry_ptr < result->entries + size;
       entry_ptr++)
    *entry_ptr = EMPTY_ENTRY;
  return result;
}

/* This function makes the table empty.  Naturally the hash table must
   already exist. */

void
empty_hash_table (hash_table_t htab)
{
  hash_table_entry_t *entry_ptr;

  assert (htab != NULL);
  htab->number_of_elements = 0;
  htab->number_of_deleted_elements = 0;
  for (entry_ptr = htab->entries;
       entry_ptr < htab->entries + htab->size;
       entry_ptr++)
    *entry_ptr = EMPTY_ENTRY;
}

/* This function frees all memory allocated for given hash table.
   Naturally the hash table must already exist. */

void
delete_hash_table (hash_table_t htab)
{
  assert (htab != NULL);
  FREE (htab->entries);
  FREE (htab);
}

/* The following function changes size of memory allocated for the
   entries and repeatedly inserts the table elements.  The occupancy
   of the table after the call will be about 50%.  Naturally the hash
   table must already exist.  Remember also that the place of the
   table entries is changed. */

static void
expand_hash_table (hash_table_t htab)
{
  hash_table_t new_htab;
  hash_table_entry_t *entry_ptr;
  hash_table_entry_t *new_entry_ptr;

  assert (htab != NULL);
  new_htab = create_hash_table (htab->number_of_elements * 2,
                                htab->hash_function, htab->eq_function);
  for (entry_ptr = htab->entries; entry_ptr < htab->entries + htab->size;
       entry_ptr++)
    if (*entry_ptr != EMPTY_ENTRY && *entry_ptr != DELETED_ENTRY)
      {
        new_entry_ptr = find_hash_table_entry (new_htab, *entry_ptr,
                                               1 /* TRUE */);
        assert (*new_entry_ptr == EMPTY_ENTRY);
        *new_entry_ptr = (*entry_ptr);
      }
  FREE (htab->entries);
  *htab = (*new_htab);
  FREE (new_htab);
}

/* The following variable is used for debugging. Its value is number
   of all calls of `find_hash_table_entry' for all hash tables. */

int all_searches = 0;

/* The following variable is used for debugging. Its value is number
   of collisions fixed for time of work with all hash tables. */

int all_collisions = 0;

/* This function searches for hash table entry which contains element
   equal to given value or empty entry in which given value can be
   placed (if the element with given value does not exist in the
   table).  The function works in two regimes.  The first regime is
   used only for search.  The second is used for search and
   reservation empty entry for given value.  The table is expanded if
   occupancy (taking into accout also deleted elements) is more than
   75%.  Naturally the hash table must already exist.  If reservation
   flag is TRUE then the element with given value should be inserted
   into the table entry before another call of
   `find_hash_table_entry'. */

hash_table_entry_t *
find_hash_table_entry (hash_table_t htab,
                       hash_table_entry_t element, int reserve)
{
  hash_table_entry_t *entry_ptr;
  hash_table_entry_t *first_deleted_entry_ptr;
  unsigned hash_value, secondary_hash_value;

  assert (htab != NULL);
  if (htab->size / 4 <= htab->number_of_elements / 3)
    expand_hash_table (htab);
  hash_value = (*htab->hash_function) (element);
  secondary_hash_value = 1 + hash_value % (htab->size - 2);
  hash_value %= htab->size;
  htab->searches++;
  all_searches++;
  first_deleted_entry_ptr = NULL;
  for (;;htab->collisions++, all_collisions++)
    {
      entry_ptr = htab->entries + hash_value;
      if (*entry_ptr == EMPTY_ENTRY)
        {
          if (reserve)
	    {
	      htab->number_of_elements++;
	      if (first_deleted_entry_ptr != NULL)
		{
		  entry_ptr = first_deleted_entry_ptr;
		  *entry_ptr = EMPTY_ENTRY;
		}
	    }
          break;
        }
      else if (*entry_ptr != DELETED_ENTRY)
        {
          if ((*htab->eq_function) (*entry_ptr, element))
            break;
        }
      else if (first_deleted_entry_ptr == NULL)
	first_deleted_entry_ptr = entry_ptr;
      hash_value += secondary_hash_value;
      if (hash_value >= htab->size)
        hash_value -= htab->size;
    }
  return entry_ptr;
}

/* This function deletes element with given value from hash table.
   The hash table entry value will be `DELETED_ENTRY' after the
   function call.  Naturally the hash table must already exist.  Hash
   table entry for given value should be not empty (or deleted). */

void
remove_element_from_hash_table_entry (hash_table_t htab,
                                      hash_table_entry_t element)
{
  hash_table_entry_t *entry_ptr;

  assert (htab != NULL);
  entry_ptr = find_hash_table_entry (htab, element, 0);
  assert (*entry_ptr != EMPTY_ENTRY && *entry_ptr != DELETED_ENTRY);
  *entry_ptr = DELETED_ENTRY;
  htab->number_of_deleted_elements++;
}

/* The following function returns current size of given hash table. */

size_t
hash_table_size (hash_table_t htab)
{
  assert (htab != NULL);
  return htab->size;
}

/* The following function returns current number of elements in given
   hash table. */

size_t
hash_table_elements_number (hash_table_t htab)
{
  assert (htab != NULL);
  return htab->number_of_elements - htab->number_of_deleted_elements;
}

/* The following function returns number of percents of fixed
   collisions during all work with given hash table. */

int
hash_table_collisions (hash_table_t htab)
{
  int searches;

  assert (htab != NULL);
  searches = htab->searches;
  if (searches == 0)
    searches++;
  return htab->collisions * 100 / searches;
}

/* The following function returns number of percents of fixed
   collisions during all work with all hash tables. */

int
all_hash_table_collisions (void)
{
  int searches;

  searches = all_searches;
  if (searches == 0)
    searches++;
  return all_collisions * 100 / searches;
}
