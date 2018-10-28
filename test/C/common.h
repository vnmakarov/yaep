#ifndef YAEP_TEST_C_COMMON_H_
#define YAEP_TEST_C_COMMON_H_

#include<assert.h>
#include<stdlib.h>

static void *
test_parse_alloc (int size)
{
  void * result;

  assert ((size > 0) && ((unsigned int) size == (size_t) size));
  result = malloc (size);
  assert (result != NULL);

  return result;
}

static void
test_parse_free (void * mem)
{
  free( mem );
}

#endif
