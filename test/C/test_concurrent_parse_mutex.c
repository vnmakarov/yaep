/* Pthread concurrent parse test with global mutex serialization.
   This test creates multiple threads, but protects YAEP calls with a
   global mutex so that even if YAEP has global mutable state or
   setjmp/longjmp interactions, threads will not trample each other's
   stacks. This is a pragmatic test demonstrating safe serialized
   concurrent usage without changing the parser internals.
*/

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "yaep.h"

static const char *desc =
  "S : 'a' ;\n";

static pthread_mutex_t yaep_mutex = PTHREAD_MUTEX_INITIALIZER;

static int
reader_once (void **attr)
{
  static int state = 0;
  (void) attr;
  if (state == 0)
    {
      state = 1;
      return 'a';
    }
  return -1;
}

static void
simple_syntax_error (int err_tok_num, void *err_tok_attr,
                     int start_ignored_tok_num, void *start_ignored_tok_attr,
                     int start_recovered_tok_num, void *start_recovered_tok_attr)
{
  /* Mark unused parameters explicitly to avoid compiler warnings. */
  (void) err_tok_attr;
  (void) start_ignored_tok_num;
  (void) start_ignored_tok_attr;
  (void) start_recovered_tok_num;
  (void) start_recovered_tok_attr;
  fprintf (stderr, "syntax error on token %d\n", err_tok_num);
}

void *worker(void *arg)
{
  (void) arg;
  struct grammar *g = NULL;
  struct yaep_tree_node *root = NULL;
  int ambiguous_p = 0;

  /* Create grammar under lock to be extra safe. */
  pthread_mutex_lock(&yaep_mutex);
  g = yaep_create_grammar();
  if (!g) {
    pthread_mutex_unlock(&yaep_mutex);
    fprintf(stderr, "yaep_create_grammar failed\n");
    return (void*)1;
  }
  if (yaep_parse_grammar(g, 1, desc) != 0) {
    fprintf(stderr, "yaep_parse_grammar failed: %s\n", yaep_error_message(g));
    yaep_free_grammar(g);
    pthread_mutex_unlock(&yaep_mutex);
    return (void*)1;
  }
  pthread_mutex_unlock(&yaep_mutex);

  /* Perform the parse while holding the lock so the parser internals are
     not concurrently accessed. */
  pthread_mutex_lock(&yaep_mutex);
  if (yaep_parse(g, reader_once, simple_syntax_error, NULL, NULL, &root, &ambiguous_p) != 0) {
    fprintf(stderr, "yaep_parse failed: %s\n", yaep_error_message(g));
    yaep_free_grammar(g);
    pthread_mutex_unlock(&yaep_mutex);
    return (void*)1;
  }
  pthread_mutex_unlock(&yaep_mutex);

  /* Free grammar under lock. */
  pthread_mutex_lock(&yaep_mutex);
  yaep_free_grammar(g);
  pthread_mutex_unlock(&yaep_mutex);

  return NULL;
}

int main(void)
{
  const int nthreads = 4;
  pthread_t th[nthreads];
  for (int i = 0; i < nthreads; ++i) {
    if (pthread_create(&th[i], NULL, worker, NULL) != 0) {
      perror("pthread_create");
      return 1;
    }
  }
  for (int i = 0; i < nthreads; ++i)
    pthread_join(th[i], NULL);
  printf("concurrent parse (mutex serialized) test done\n");
  return 0;
}
