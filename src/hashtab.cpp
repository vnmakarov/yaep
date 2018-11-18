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

/* FILE NAME:   hashtab.cpp

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
         Defining macro `NDEBUG' (e.g. by option `-D' in C++ compiler
       command line) during the file compilation disables to fix
       some internal errors and errors of usage of the package.

*/

#include "allocate.h"
#include "hashtab.h"

#include <assert.h>

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

/* This constructor creates table with length slightly longer than
   given source length.  Created hash table is initiated as empty (all
   the hash table entries are EMPTY_ENTRY). */

hash_table::hash_table (YaepAllocator * allocator, size_t size, unsigned int (*hash_function) (hash_table_entry_t el_ptr), int (*eq_function) (hash_table_entry_t el1_ptr, hash_table_entry_t el2_ptr)):alloc
  (allocator)
{
  hash_table_entry_t *
    entry_ptr;

  size = higher_prime_number (size);
  entries =
    (hash_table_entry_t *) yaep_malloc (alloc,
					size * sizeof (hash_table_entry_t));
  this->_size = size;
  this->hash_function = hash_function;
  this->eq_function = eq_function;
  number_of_elements = 0;
  number_of_deleted_elements = 0;
  collisions = 0;
  searches = 0;
  for (entry_ptr = entries; entry_ptr < entries + size; entry_ptr++)
    *entry_ptr = EMPTY_ENTRY;
}

/* This destructor frees all memory allocated for given hash table. */

hash_table::~hash_table (void)
{
  yaep_free (alloc, entries);
}

/* This function makes the table empty.  Naturally the hash table must
   already exist. */

void
hash_table::empty (void)
{
  hash_table_entry_t *entry_ptr;

  number_of_elements = 0;
  number_of_deleted_elements = 0;
  for (entry_ptr = entries; entry_ptr < entries + _size; entry_ptr++)
    *entry_ptr = EMPTY_ENTRY;
}

/* The following function changes size of memory allocated for the
   entries and repeatedly inserts the table elements.  The occupancy
   of the table after the call will be about 50%.  Remember also that
   the place of the table entries is changed. */

void
hash_table::expand_hash_table (void)
{
  hash_table_t new_htab;
  hash_table_entry_t *entry_ptr;
  hash_table_entry_t *new_entry_ptr;

  new_htab =
    new hash_table (alloc, number_of_elements * 2, hash_function,
		    eq_function);
  for (entry_ptr = entries; entry_ptr < entries + _size; entry_ptr++)
    if (*entry_ptr != EMPTY_ENTRY && *entry_ptr != DELETED_ENTRY)
      {
	new_entry_ptr = new_htab->find_entry (*entry_ptr, 1 /* TRUE */ );
	assert (*new_entry_ptr == EMPTY_ENTRY);
	*new_entry_ptr = (*entry_ptr);
      }
  yaep_free (alloc, entries);
  *this = (*new_htab);
  new_htab->entries = nullptr;
  delete new_htab;
}

/* The following variable is used for debugging. Its value is number
   of all calls of `find_hash_table_entry' for all hash tables. */

int hash_table::all_searches = 0;

/* The following variable is used for debugging. Its value is number
   of collisions fixed for time of work with all hash tables. */

int hash_table::all_collisions = 0;

/* This function searches for hash table entry which contains element
   equal to given value or empty entry in which given value can be
   placed (if the element with given value does not exist in the
   table).  The function works in two regimes.  The first regime is
   used only for search.  The second is used for search and
   reservation empty entry for given value.  The table is expanded if
   occupancy (taking into accout also deleted elements) is more than
   75%.  If reservation flag is TRUE then the element with given value
   should be inserted into the table entry before another call of
   `find_entry'. */

hash_table_entry_t *
hash_table::find_entry (hash_table_entry_t element, int reserve)
{
  hash_table_entry_t *entry_ptr;
  hash_table_entry_t *first_deleted_entry_ptr;
  unsigned hash_value, secondary_hash_value;

  if (_size / 4 <= number_of_elements / 3)
    expand_hash_table ();
  hash_value = (*hash_function) (element);
  secondary_hash_value = 1 + hash_value % (_size - 2);
  hash_value %= _size;
  searches++;
  all_searches++;
  first_deleted_entry_ptr = NULL;
  for (;; collisions++, all_collisions++)
    {
      entry_ptr = entries + hash_value;
      if (*entry_ptr == EMPTY_ENTRY)
	{
	  if (reserve)
	    {
	      number_of_elements++;
	      if (first_deleted_entry_ptr != NULL)
		{
		  entry_ptr = first_deleted_entry_ptr;
		  *entry_ptr = DELETED_ENTRY;
		}
	    }
	  break;
	}
      else if (*entry_ptr != DELETED_ENTRY)
	{
	  if ((*eq_function) (*entry_ptr, element))
	    break;
	}
      else if (first_deleted_entry_ptr == NULL)
	first_deleted_entry_ptr = entry_ptr;
      hash_value += secondary_hash_value;
      if (hash_value >= _size)
	hash_value -= _size;
    }
  return entry_ptr;
}

/* This function deletes element with given value from hash table.
   The hash table entry value will be `DELETED_ENTRY' after the
   function call.  Hash table entry for given value should be not
   empty (or deleted). */

void
hash_table::remove_element_from_entry (hash_table_entry_t element)
{
  hash_table_entry_t *entry_ptr;

  entry_ptr = find_entry (element, 0);
  assert (*entry_ptr != EMPTY_ENTRY && *entry_ptr != DELETED_ENTRY);
  *entry_ptr = DELETED_ENTRY;
  number_of_deleted_elements++;
}
