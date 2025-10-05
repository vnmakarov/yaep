/* Process-based concurrent parse test.
   This test forks several child processes; each child creates its own
   grammar, reads the description and runs a trivial parse. Because each
   child has its own address space and stack, this demonstrates that the
   parser can be used safely from multiple processes in parallel even when
   thread-safety is not yet fully achieved.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

#include "yaep.h"

static const char *desc =
  "S : 'a' ;\n";

/* Simple token provider for the child process: returns a single 'a' token
   once then EOF. */
static int
child_read_token (void **attr)
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

static void
child_main (void)
{
  struct grammar *g;
  struct yaep_tree_node *root;
  int ambiguous_p;

  if ((g = yaep_create_grammar ()) == NULL)
    {
      fprintf (stderr, "yaep_create_grammar failed\n");
      exit (1);
    }
  if (yaep_parse_grammar (g, 1, desc) != 0)
    {
      fprintf (stderr, "yaep_parse_grammar failed: %s\n", yaep_error_message (g));
      yaep_free_grammar (g);
      exit (1);
    }
  if (yaep_parse (g, child_read_token, simple_syntax_error, NULL, NULL, &root, &ambiguous_p) != 0)
    {
      fprintf (stderr, "yaep_parse failed: %s\n", yaep_error_message (g));
      yaep_free_grammar (g);
      exit (1);
    }
  yaep_free_grammar (g);
  exit (0);
}

int
main (void)
{
  const int nproc = 6;
  pid_t pids[nproc];
  for (int i = 0; i < nproc; ++i)
    {
      pid_t pid = fork ();
      if (pid < 0)
        {
          perror ("fork");
          return 1;
        }
      if (pid == 0)
        {
          /* Child */
          child_main ();
        }
      pids[i] = pid;
    }

  /* Parent: wait for children. */
  int exit_status = 0;
  for (int i = 0; i < nproc; ++i)
    {
      int st;
      if (waitpid (pids[i], &st, 0) < 0)
        {
          perror ("waitpid");
          exit_status = 1;
          continue;
        }
      if (WIFEXITED (st))
        {
          int code = WEXITSTATUS (st);
          if (code != 0)
            {
              fprintf (stderr, "child %d exited with code %d\n", pids[i], code);
              exit_status = 1;
            }
        }
      else if (WIFSIGNALED (st))
        {
          fprintf (stderr, "child %d killed by signal %d\n", pids[i], WTERMSIG (st));
          exit_status = 1;
        }
    }

  if (exit_status == 0)
    printf ("concurrent parse (process) test done\n");

  return exit_status;
}
