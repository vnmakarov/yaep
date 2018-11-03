#include <stdlib.h>

#include"common.h"

/* The following variable is the current number of next input grammar
   terminal. */
static int nterm;

/* The following function imported by YAEP (see comments in the interface file). */
const char *
read_terminal (int *code)
{
  nterm++;
  switch (nterm)
    {
    case 1: *code = 'a'; return "a";
    case 2: *code = '+'; return "+";
    case 3: *code = '*'; return "*";
    case 4: *code = '('; return "(";
    case 5: *code = ')'; return ")";
    default: return NULL;
    }
}

/* The following variable is the current number of next rule grammar
   terminal. */
static int nrule;

/* The following function imported by YAEP (see comments in the interface file). */
const char *
read_rule (const char ***rhs, const char **anode, int *anode_cost, int **transl)
{
  static const char *rhs_1 [] = {"T", NULL};
  static int tr_1 [] = {0, -1};
  static const char *rhs_2 [] = {"E", "+", "T", NULL};
  static int tr_2 [] = {0, 2, -1};
  static const char *rhs_3 [] = {"F", NULL};
  static int tr_3 [] = {0, -1};
  static const char *rhs_4 [] = {"T", "*", "F", NULL};
  static int tr_4 [] = {0, 2, -1};
  static const char *rhs_5 [] = {"a", NULL};
  static int tr_5 [] = {0, -1};
  static const char *rhs_6 [] = {"(", "E", ")", NULL};
  static int tr_6 [] = {1, -1};

  nrule++;
  switch (nrule)
    {
    case 1: *rhs = rhs_1; *anode = NULL; *anode_cost = 0; *transl = tr_1;
      return "E";
    case 2: *rhs = rhs_2; *anode = "plus"; *anode_cost = -1; *transl = tr_2;
      return "E";
    case 3: *rhs = rhs_3; *anode = NULL; *anode_cost = 0; *transl = tr_3;
      return "T";
    case 4: *rhs = rhs_4; *anode = "mult"; *anode_cost = 0; *transl = tr_4;
      return "T";
    case 5: *rhs = rhs_5; *anode = NULL; *anode_cost = 0; *transl = tr_5;
      return "F";
    case 6: *rhs = rhs_6; *anode = NULL; *anode_cost = 0; *transl = tr_6;
      return "F";
    default: return NULL;
    }
}

static const char *input = "a+a*(a*a+a)";

main ()
{
  test_standard_read (read_terminal, read_rule);
  exit (0);
}
