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

/* FILE NAME:   hashtab.h

   TITLE:       Include file of package for work with variable length
                hash tables 

   DESCRIPTION: This header file contains type definitions and ANSI C
       prototype definitions of the package functions and definition of
       external variable of the package and C++ class `hash table'.

*/

#ifndef __HASH_TABLE__
#define __HASH_TABLE__

#include <stdlib.h>

#include"allocate.h"

/* The hash table element is represented by the following type. */

typedef const void *hash_table_entry_t;


#ifndef __cplusplus


/* Hash tables are of the following type.  The structure
   (implementation) of this type is not needed for using the hash
   tables.  All work with hash table should be executed only through
   functions mentioned below. */

typedef struct
{
  /* Current size (in entries) of the hash table */
  size_t size;
  /* Current number of elements including also deleted elements */
  size_t number_of_elements;
  /* Current number of deleted elements in the table */
  size_t number_of_deleted_elements;
  /* The following member is used for debugging. Its value is number
     of all calls of `find_hash_table_entry' for the hash table. */
  int searches;
  /* The following member is used for debugging.  Its value is number
     of collisions fixed for time of work with the hash table. */
  int collisions;
  /* Pointer to function for evaluation of hash value (any unsigned value).
     This function has one parameter of type hash_table_entry_t. */
  unsigned (*hash_function) (hash_table_entry_t el_ptr);
  /* Pointer to function for test on equality of hash table elements (two
     parameter of type hash_table_entry_t. */
  int (*eq_function) (hash_table_entry_t el1_ptr,
                      hash_table_entry_t el2_ptr);
  /* Table itself */
  hash_table_entry_t *entries;
  /* Allocator */
  YaepAllocator * alloc;
} *hash_table_t;


/* The following variable is used for debugging. Its value is number
   of all calls of `find_hash_table_entry' for all hash tables. */

extern int all_searches;

/* The following variable is used for debugging. Its value is number
   of collisions fixed for time of work with all hash tables. */

extern int all_collisions;

/* The prototypes of the package functions. */

extern hash_table_t create_hash_table(
  YaepAllocator * allocator, size_t size, unsigned int ( *hash_function )( hash_table_entry_t el_ptr ), int ( *eq_function )( hash_table_entry_t el1_ptr, hash_table_entry_t el2_ptr )
);

extern void empty_hash_table (hash_table_t htab);

extern void delete_hash_table (hash_table_t htab);

extern hash_table_entry_t *find_hash_table_entry
  (hash_table_t htab, hash_table_entry_t element, int reserve);

extern void remove_element_from_hash_table_entry (hash_table_t htab,
                                                  hash_table_entry_t element);

extern size_t hash_table_size (hash_table_t htab);

extern size_t hash_table_elements_number (hash_table_t htab);

/* The following function returns number of searches during all work
   with given hash table. */
static inline int
get_searches (hash_table_t htab)
{
  return htab->searches;
}

/* The following function returns number of occurred collisions during
   all work with given hash table. */
static inline int
get_collisions (hash_table_t htab)
{
  return htab->collisions;
}

/* The following function returns number of searches during all work
   with all hash tables. */
static inline int
get_all_searches (void)
{
  return all_searches;
}

/* The following function returns number of occurred collisions
   during all work with all hash tables. */
static inline int
get_all_collisions (void)
{
  return all_collisions;
}

extern int hash_table_collision_percentage (hash_table_t htab);

extern int all_hash_table_collision_percentage (void);

#else /* #ifndef __cplusplus */



/* Hash tables are of the following class. */

class hash_table
{
  /* Current size (in entries) of the hash table */
  size_t _size;
  /* Current number of elements including also deleted elements */
  size_t number_of_elements;
  /* Current number of deleted elements in the table */
  size_t number_of_deleted_elements;
  /* The following member is used for debugging. Its value is number
     of all calls of `find_hash_table_entry' for the hash table. */
  int searches;
  /* The following member is used for debugging.  Its value is number
     of collisions fixed for time of work with the hash table. */
  int collisions;
  /* Pointer to function for evaluation of hash value (any unsigned value).
     This function has one parameter of type hash_table_entry_t. */
  unsigned (*hash_function) (hash_table_entry_t el_ptr);
  /* Pointer to function for test on equality of hash table elements (two
     parameter of type hash_table_entry_t. */
  int (*eq_function) (hash_table_entry_t el1_ptr,
                      hash_table_entry_t el2_ptr);
  /* Table itself */
  hash_table_entry_t *entries;
  /* Allocator */
  YaepAllocator * alloc;

  /* The following variable is used for debugging. Its value is number
     of all calls of `find_hash_table_entry' for all hash tables. */

  static int all_searches;

  /* The following variable is used for debugging. Its value is number
     of collisions fixed for time of work with all hash tables. */

  static int all_collisions;

public:

  /* Constructor. */
  hash_table( YaepAllocator * allocator, size_t size, unsigned int ( *hash_function )( hash_table_entry_t el_ptr ), int ( *eq_function )( hash_table_entry_t el1_ptr, hash_table_entry_t el2_ptr ) );
  /* Destructor. */
  ~hash_table (void);

  void empty (void);

  hash_table_entry_t *find_entry (hash_table_entry_t element, int reserve);
  
  void remove_element_from_entry (hash_table_entry_t element);

  /* The following function returns current size of given hash
     table. */

  inline size_t size (void)
    {
      return _size;
    }

  /* The following function returns current number of elements in
     given hash table. */

  inline size_t elements_number (void)
    {
      return number_of_elements - number_of_deleted_elements;
    }
  
  /* The following function returns number of searches during all work
     with given hash table. */

  inline int get_searches (void)
    {
      return this->searches;
    }

  /* The following function returns number of occurred collisions
     during all work with given hash table. */

  inline int get_collisions (void)
    {
      return this->collisions;
    }

  /* The following function returns number of searches
     during all work with all hash tables. */
  
  static inline int get_all_searches (void)
    {
      return all_searches;
    }

  /* The following function returns number of occurred collisions
     during all work with all hash tables. */
  
  static inline int get_all_collisions (void)
    {
      return all_collisions;
    }
private:

  void expand_hash_table (void);

};

typedef class hash_table *hash_table_t;


#endif /* #ifndef __cplusplus */

#endif /* #ifndef __HASH_TABLE__ */
