#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "yaep.h"
#include <stdint.h>
#include <pthread.h>

/* Simple thread routine that creates a grammar, parses a trivial input
   string and then disposes the grammar. This exercises concurrent
   usage of yaep_read_grammar / yaep_parse on the same description. */

static const char *desc =
  "S : 'a' ;\n";

/* Thread-specific key for per-thread token state. */
static pthread_key_t reader_state_key;

static int reader_wrapper(void **attr)
{
  (void)attr;
  int *stp = (int *) pthread_getspecific(reader_state_key);
  if (!stp) return -1;
  int st = *stp;
  if (st == 0) { *stp = 1; return 0; } /* EOF */
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
  (void)arg;
  struct grammar *g = yaep_create_grammar ();
  if (!g) {
    fprintf(stderr, "yaep_create_grammar failed\n");
    return (void*)1;
  }

  if (yaep_parse_grammar (g, 1, desc) != 0) {
    fprintf(stderr, "yaep_parse_grammar failed\n");
    yaep_free_grammar (g);
    return (void*)1;
  }

  /* Do a trivial parse: token provider returns single 'a' token then EOF. */
  struct yaep_tree_node *root = NULL;

  /* Per-thread state: 0 -> EOF, 1 -> done. Use the thread id as an
     index into an array of simple contexts. */
  /* Install thread-specific state. */
  int *stp = malloc(sizeof *stp);
  if (!stp) return (void*)1;
  *stp = 0;
  pthread_setspecific(reader_state_key, stp);

  if (yaep_parse (g, reader_wrapper, simple_syntax_error, NULL, NULL, &root, &(int){0}) != 0) {
    fprintf(stderr, "yaep_parse failed\n");
    yaep_free_grammar (g);
    free(stp);
    return (void*)1;
  }

  yaep_free_grammar (g);
  free(stp);
  return 0;
}

int main(void)
{
  pthread_key_create(&reader_state_key, free);
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
  printf("concurrent parse test done\n");
  return 0;
}
