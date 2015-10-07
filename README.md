# YAEP -- standalone Earley parser library
  * **YAEP** is an abbreviation of Yet Another Ealrey Parser.
  * This standalone library is created for convenience.
  * The parser development is actually done as a part of *Dino* language project.
    [Here is the link](https://github.com/dino-lang/dino)
  * YEAP license is LGPL v.2. 
# YAEP features:
  * It is sufficiently fast and does not require much memory.
    This is the **fastest** implementation of Earley parser which I
    know (if you know a faster one, please send me a message). It can parse **300K lines of
    C program per second** on modern computers
    and allocates about **5MB memory for 10K line C program**.
  * It makes simple syntax directed translation.  So an
    **abstract tree** is already the output of YAEP.
  * It can parse input described by an **ambiguous** grammar.  In
    this case the parse result can be an abstract tree or all
    possible abstract trees.  Moreover it produces a compact
    representation of all possible parse trees by using DAG instead
    of real trees.
  * It can parse input described by an ambiguous grammar
    according to the **abstract node costs**.  In this case the parse
    result can be an **minimal cost** abstract tree or all possible
    minimal cost abstract trees.  This feature can be used to code
    selection task in compilers.
  * It can make **syntax error recovery**.  Moreover its error
    recovery algorithms finds error recovery with **minimal** number of
    ignored tokens.  It permits to implement parsers with very good
    error recovery and reporting.
  * It has **fast startup**.  There is only tiny and insignificant delay between
    processing grammar and start of parsing.
  * The grammar can be described through function calls or through YACC-like description.
 
# Usage example:
* Here is a small simple example how to use YAEP to parse expressions.  We omitted functions
  `read_token`, `syntax_error_func`, and `parse_alloc_func` used to provide tokens, print
  syntax error messages, and allocate memory for the parser.

```
static const char *description =
"\n"
"TERM NUMBER;\n"
"E : T         # 0\n"
"  | E '+' T   # plus (0 2)\n"
"  ;\n"
"T : F         # 0\n"
"  | T '*' F   # mult (0 2)\n"
"  ;\n"
"F : NUMBER    # 0\n"
"  | '(' E ')' # 1\n"
"  ;\n"
  ;

static void parse (void)
{
  struct grammar *g;
  struct earley_tree_node *root;
  int ambiguous_p;

  if ((g = earley_create_grammar ()) == NULL) {
      fprintf (stderr, "earley_create_grammar: No memory\n");
      exit (1);
  }
  if (earley_parse_grammar (g, TRUE, description) != 0) {
      fprintf (stderr, "%s\n", earley_error_message (g));
      exit (1);
    }
  if (earley_parse (g, read_token_func, syntax_error_func, parse_alloc_func,
                    NULL, &root, &ambiguous_p))
    fprintf (stderr, "earley_parse: %s\n", earley_error_message (g));
  earley_free_grammar (g);
}
```

# Installing
  * ``<YAEP source path>/configure --srcdir=<YAEP source path> --prefix=<YAEP install directory>``
  * ``cd src``
  * ``make``
  * optional ``make test`` 
  * ``make install``

# Speed of YACC, MARPA, YAEP, and GCC parser.

* Tested parsers:
  * YACC 1.9 from Linux Fedora Core 21.
  * MARPA C Library, version 8.3.0. A popular Earley's parser using Practical Earley parser algorithm
    and Leo Joop's approach.
  * GCC-4.9.2.
  * YAEP as Oct. 2015.
* Grammar:
  * The base test grammar was **ANSI C** grammar which is mostly left recursion grammar.
  * For MARPA and YAEP, the grammar is lightly ambiguous as a typename is also an identifier.
  * For YACC description, typename is a separate token different from
    other identifiers.  YACC description contains only small number of
    actions to give feedback to scanner how to treat next identifier (as a
    typename or identifier itself).
* Scanning test files for YACC, MARPA, and YAEP:
  * We prepared all tokens first and only after that we did parsing.
  * For YACC, at this stage we does not differ identifier and typename yet. 
* Tests
  * The first test is made from gen.c file of parser-generator MSTA.  The file was concatenated
    10 times and the result file size was 67K C lines.
  * The second one is a pre-release version of gcc-4.0 for i686 as one file
    ([source](http://people.csail.mit.edu/smcc/projects/single-file-programs/)).
    The file size was 635K C lines.
  * The files were pre-processed.
  * Additional preparations were made for YACC, MARPA, and YAEP
    * GCC extensions (mostly attributes and asm) were removed from the
      pre-processed files.  The removed code is a tiny and an insignificant
      fraction of all code.
    * A very small number of identifiers were renamed not to confuse the simple
      YACC actions to differ typenames and identifiers.  So the result code
      is not correct as C code but it is correct with syntactic point of view.
* Measurements:
  * The results are elapsed (wall) times.
  * Memory requirements was measured by Linux ``sbrk`` difference before and after parsing.
  * For GCC, memory was max resident memory.
* Results:
  * First file (**67K** lines).  Test machine is i7-2600 (4 x 3.4GHz) with 8GB memory
    under FC21.


|                      |Parse time only  |Overall    |Memory (parse only) MB|
|----------------------|----------------:|----------:|---------------------:|
|YACC                  |   0.07          | 0.17      |   20                 |
|MARPA                 |   3.48          | 3.77      |  516                 |
|YAEP                  |   0.18          | 0.28      |   26                 |

  * Second file (**635K** lines).  Test machine is 2xE5-2697 (2 x 14 x 2.6GHz) with
    128GB memory under FC21.

|                      |Parse time only  |Overall    |Memory (parse only) MB|
|----------------------|----------------:|----------:|---------------------:|
|YACC                  |  0.25           | 0.55      |  120                 |
|gcc -fsyntax-only     |      -          | 1.22      |  194                 |
|gcc -O0               |      -          |19.37      |  761                 |
|MARPA                 | 22.23           |23.41      |30310                 |
|YAEP                  |  1.43           | 1.68      |  142                 |

* YEAP without scanner is up to **20** times faster Marpa and requires up to **200**
times less memory.
* Still it is **2.5** - **6** times slower (**1.6** - **3** times with taking scanner into account) than YACC.

# Implementation details
  * All numbers below are given for our biggest C test (GCC as one file).
  1. **Earley set** representation is very compact and only **set core** pointer and vector of **distances**
     for start situations of the set core.
  2. The distances are **relative**, not absolute.  The distance vector is stored in **one exemplar**.
     In average, the distance vector is reused 22 times.
  3. Earley sets are represented in **one exemplar** and parser list consists of only pointers to the sets.
     In average one set occurs 20 times.
  4. The **situation** is mostly a triple (rule, the dot place in the rule, optional possible lookahead).
     In other words, the situation is the set tuple in original Earley algorithm but without distances.
     The situation is stored in **one exemplar** and only pointer to it is used.
  5. The **set core** is set of situations which can occur during YAEP work.
  6. **Start situations** in the set core are situations produced by Earley Scanning and Completion passes
     excluding situations added by the completion pass from processing rules with empty right hand side.
  7. Start situations and their distances **define** all the rest situations and their distances created by
     predictor pass and completer pass processing rules with empty right hand side.
  8. More dynamic programming.  There are a lot of repeated parsing parts in the input.
     We build **map** (Earley set, input token, lookahead) -> a few possible Earley sets (currently 3 sets)
     and try to reuse a set from a map.  In 70% cases, the reuse is successful.
  9. We **do use lookahead** and it speeds up the parser in almost 2 times.  Which is opposite to 
     researches showed the lookahead usage has little practical effect on the parsing efficiency.
 10. We **don't use PEP** (Practical Earley Parser algorithm).  It would complicate the implementation
     much and, in my estimation, could give only a few percent speedup for our tests.
 11. We **don't use Leo Joop's approach**.  Using right recursion creates the same number of start situations
     in overall as using the left recursion.  Simply Earley set corresponding to the end of right recursion
     contains a lot of start situations (created by the completer).
     * Moreover, using the right recursion considerably improves reuse of a set from the map (see 8).
       For example, parsing 1M token list described by a grammar with the **right** recursion takes only
       **0.14s vs 1.05s** for a grammar described with the **left** recursion.  Usage of the right
       recursion also results in **3 times** less memory consumption.