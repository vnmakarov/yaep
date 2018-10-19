# YAEP -- standalone Earley parser library
  * **YAEP** is an abbreviation of Yet Another Earley Parser.
  * This standalone library is created for convenience.
  * The parser development is actually done as a part of the [*Dino* language
    project](https://github.com/dino-lang/dino).
  * YAEP is licensed under LGPL v.2.

# YAEP features:
  * It is sufficiently fast and does not require much memory.
    This is the **fastest** implementation of the Earley parser which I
    know of. If you know a faster one, please send me a message. It can parse
    **300K lines of C program per second** on modern computers
    and allocates about **5MB memory for 10K line C program**.
  * YAEP does simple syntax directed translation, producing an **abstract
    syntax tree** as its output.
  * It can parse input described by an **ambiguous** grammar.  In
    this case the parse result can be a single abstract tree or all
    possible abstract trees. YAEP produces a compact
    representation of all possible parse trees by using DAG instead
    of real trees.
  * YAEP can parse input described by an ambiguous grammar
    according to **abstract node costs**.  In this case the parse
    result can be a **minimal cost** abstract tree or all possible
    minimal cost abstract trees.  This feature can be used to code
    selection task in compilers.
  * It can perform **syntax error recovery**.  Moreover its error
    recovery algorithm finds error recovery with a **minimal** number of
    ignored tokens.  This permits implementing parsers with very good
    error recovery and reporting.
  * It has **fast startup**.  There is only a tiny and insignificant delay
    between processing grammar and the start of parsing.
  * A grammar for YAEP can be constructed through function calls or using
    a YACC-like description syntax.
 
# Usage example:
* The following is a small example of how to use YAEP to parse expressions.
  We have omitted the functions `read_token`, `syntax_error_func`,
  and `parse_alloc_func` which are needed to provide tokens, print syntax
  error messages, and allocate memory for the parser.

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
  * To add error recovery, just add a reserved symbol ``error`` to
    the rules. Skipped terminals during error recovery will be
    represented in the resulting abstract tree by a node called ``error``.
    For example, if you want to include expression- and statement-level
    error-recovery in a programming language grammar, the rules could look
    like the following:
```
  stmt : IF '(' expr ')' stmt ELSE stmt # if (2 4 6)
       | ...
       | error # 0
       ;
  expr : IDENT # 0
       | ...
       | error # 0
       ;
``` 
  * For more details, please see the documentation in directory ``src/``,
    or the YAEP examples in file ``yaep.tst.in``.

# Installing:
  * ``mkdir build``
  * ``cd build``
  * ``cmake -DCMAKE_BUILD_TYPE=Release`` (make sure you have CMake installed)
  * ``make``
  * ``make test`` (optional) 
  * ``make install``

# Speed comparison of YACC, MARPA, YAEP, and GCC parsers:

* Tested parsers:
  * YACC 1.9 from Linux Fedora Core 21.
  * MARPA C Library, version 8.3.0. A popular Earley parser implementation
    using the Practical Earley Parser algorithm and Leo Joop's approach.
  * The C parser in GCC-4.9.2.
  * YAEP as of Oct. 2015.
* Grammar:
  * The base test grammar is the **ANSI C** grammar which is mostly
    a left recursion grammar.
  * For MARPA and YAEP, the grammar is slightly ambiguous as typenames
    are represented with the same kind of token as identifiers.
  * For the YACC description, typename is a separate token type distinct from
    other identifiers.  The YACC description does not contain any actions except
    for a small number needed to give feedback to the scanner on how to treat
    the next identifier (as a typename or regular identifier).
* Scanning test files for YACC, MARPA, and YAEP:
  * We prepare all tokens beforehand in order to exclude scanning time from our benchmark.
  * For YACC, at the scanning stage we do not yet distinguish identifiers and typenames. 
* Tests:
  * The first test is based on the file ``gen.c`` from parser-generator MSTA.  The file
    was concatenated 10 times and the resulting file size was 67K C lines.
  * The second test is a pre-release version of gcc-4.0 for i686 with all the source
    code combined into one file
    ([source](http://people.csail.mit.edu/smcc/projects/single-file-programs/)).
    The file size was 635K C lines.
  * The C pre-processor was applied to the files.
  * Additional preparations were made for YACC, MARPA, and YAEP:
    * GCC extensions (mostly attributes and asm) were removed from the
      pre-processed files.  The removed code is a tiny and insignificant
      fraction of the entire code.
    * A very small number of identifiers were renamed to avoid confusing the simple
      YACC actions to distinguish typenames and identifiers.  So the resulting code
      is not correct as C code but it is correct from the syntactic point of view.
* Measurements:
  * The result times are elapsed (wall) times.
  * Memory requirements are measured by comparing the output of Linux ``sbrk`` before and
    after parsing.
  * For GCC, memory was instead measured as max resident memory reported by ``/usr/bin/time``.
* How to reproduce: please use the shell script ``compare-parsers.tst``
  from directory ``src``.


* Results:
  * First file (**67K** lines).  Test machine is i7-2600 (4 x 3.4GHz)
    with 8GB memory under FC21.


|                      |Parse time only  |Overall    |Memory (parse only) MB|
|----------------------|----------------:|----------:|---------------------:|
|YACC                  |   0.07          | 0.17      |   20                 |
|MARPA                 |   3.48          | 3.77      |  516                 |
|YAEP                  |   0.18          | 0.28      |   26                 |

  * Second file (**635K** lines).  Test machine is 2xE5-2697 (2 x 14 x 2.6GHz)
    with 128GB memory under FC21.

|                      |Parse time only  |Overall    |Memory (parse only) MB|
|----------------------|----------------:|----------:|---------------------:|
|YACC                  |  0.25           | 0.55      |  120                 |
|gcc -fsyntax-only     |      -          | 1.22      |  194                 |
|gcc -O0               |      -          |19.37      |  761                 |
|MARPA                 | 22.23           |23.41      |30310                 |
|YAEP                  |  1.43           | 1.68      |  142                 |

* Conclusions:
  * YAEP without a scanner is up to **20** times faster than Marpa and requires
    up to **200** times less memory.
  * Still, it is **2.5** - **6** times slower (**1.6** - **3** times when
     taking the scanner into account) than YACC.

# Future directions
  * Implement YACC-style description syntax for operator precedence and associativity.
  * Implement bindings for popular scripting languages.
  * Introduce abstract node codes (instead of string labels) for faster work with abstract trees.
  * Permit nested abstract nodes in simple translation.
