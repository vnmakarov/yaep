# YAEP -- standalone Earley parser library
  * **YAEP** is an abbreviation of Yet Another Earley Parser.
  * This standalone library is created for convenience.
  * The parser development is actually done as a part of the [*Dino* language
    project](https://github.com/dino-lang/dino).
  * YAEP is licensed under the MIT license.

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
    the Unicode notes in ``doc/unicode_support.md``,
    or the YAEP examples in files ``test*.c`` in directories ``test/C`` or ``test/C++``.

  ## Encoding / Unicode

  YAEP expects UTF-8 encoded input for grammar descriptions, symbol names,
  terminal names, abstract node labels, and other public string APIs. Strings
  passed to YAEP (for example, the `description` argument to
  `yaep_parse_grammar`) must be valid UTF-8. The project includes a small
  Unicode wrapper and uses the vendored `utf8proc` library to validate and
  normalize UTF-8 where appropriate (see `src/unicode/yaep_unicode.*`).

  Notes for callers:
  - YAEP stores strings as UTF-8 byte buffers; stored lengths are byte counts,
    not code point counts.
  - YAEP performs NFC normalization on names in some symbol-insertion paths.
    Callers that need canonicalization may also call the helpers in
    `src/unicode/yaep_unicode.h`.
  - If YAEP encounters invalid UTF-8 in a grammar description or symbol name,
    it will report the error code `YAEP_INVALID_UTF8` (see `src/yaep.h`).

  If you need to work in a different encoding, convert text to UTF-8 before
  calling YAEP.

# Installing:
  * ``mkdir build``
  * ``cd build``
  * ``<srcdir>/configure --srcdir=<srcdir> --prefix=<prefix for install dirs>``
    or ``cmake -DCMAKE_BUILD_TYPE=Release`` (make sure you have CMake installed)
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

## Recent measurements (Oct 2025)

The benchmark tables above are historical and were produced by the original
maintainer on the machines listed.  To provide a lightly-updated snapshot we
ran the repository's `test/compare_parsers/compare_parsers.sh` harness on both
the `master` branch and a development branch (`unicode-feature`) on Oct 4, 2025.
These measurements are intended as a reproducible snapshot (medians over 10
runs) and are not meant to supplant the historical tables above.

### Test machine and environment

The measurements in the Recent measurements section above were produced on the
following machine and environment (UTC):

```
OS: Ubuntu 24.04.3 LTS
Kernel: Linux 6.14.0-32-generic
CPU: AMD Ryzen 9 9950X 16-Core Processor (32 logical cores)
Cores: 32
Memory: 249 GiB
GCC: gcc (Ubuntu 13.3.0) 13.3.0
Python3: 3.13.5
Git branch used for the snapshot: unicode-feature
Date (UTC): 2025-10-04T23:24:43Z
```

Small (parse-only) medians from our run:

| Test case | master median (s) | unicode median (s) | master RSS (KB) | unicode RSS (KB) |
|----------:|-----------------:|-------------------:|---------------:|-----------------:|
| YACC (small) | 0.040 | 0.040 | ~21264 | ~21176 |
| Bison (small) | 0.040 | 0.040 | ~21251 | ~21251 |
| YAEP static (small) | 0.080 | 0.080 | ~57235 | ~57235 |

Large (parse-only) medians from our run:

| Test case | master median (s) | unicode median (s) | master RSS (KB) | unicode RSS (KB) |
|----------:|-----------------:|-------------------:|---------------:|-----------------:|
| YACC (big) | 0.230 | 0.230 | ~121274 | ~121274 |
| Bison (big) | 0.240 | 0.230 | ~121299 | ~121299 |
| YAEP static (big) | 0.745 | 0.740 | ~397006 | ~397006 |

Summary: in our runs the `unicode-feature` branch showed no material
performance regressions compared with `master` (median deltas within a few
percent and RSS differences negligible).  Results will vary by machine,
compiler and build flags; see `test/compare_parsers/` for the exact harness and
raw logs (`test/compare_parsers/logs_master` and
`test/compare_parsers/logs_unicode`).

If you reproduce these tests please report machine, compiler and exact
commands used so we can keep the benchmark data useful to others.

# Future directions
  * Implement YACC-style description syntax for operator precedence and associativity.
  * Implement bindings for popular scripting languages.
  * Introduce abstract node codes (instead of string labels) for faster work with abstract trees.
  * Permit nested abstract nodes in simple translation.
