/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 32 "./src/sgramm.y"


#include <ctype.h>
#include <string.h>

#include <assert.h>

#include "yaep_unicode.h"

/* The following is necessary if we use YAEP with byacc/bison/msta
   parser. */

#define yylval yaep_yylval
#define yylex yaep_yylex
#define yyerror yaep_yyerror
#define yyparse yaep_yyparse
#define yychar yaep_yychar
#define yynerrs yaep_yynerrs
#define yydebug yaep_yydebug
#define yyerrflag yaep_yyerrflag
#define yyssp yaep_yyssp
#define yyval yaep_yyval
#define yyvsp yaep_yyvsp
#define yylhs yaep_yylhs
#define yylen yaep_yylen
#define yydefred yaep_yydefred
#define yydgoto yaep_yydgoto
#define yysindex yaep_yysindex
#define yyrindex yaep_yyrindex
#define yygindex yaep_yygindex
#define yytable yaep_yytable
#define yycheck yaep_yycheck
#define yyss yaep_yyss
#define yyvs yaep_yyvs

/* The following structure describes syntax grammar terminal. */
struct sterm
{
  char *repr; /* terminal representation. */
  int code;   /* terminal code. */
  int num;    /* order number. */
};

/* The following structure describes syntax grammar rule. */
struct srule
{
  /* The following members are left hand side nonterminal
     representation and abstract node name (if any) for the rule. */
  char *lhs, *anode;
  /* The following is the cost of given anode if it is defined.
     Otherwise, the value is zero. */
  int anode_cost;
  /* The following is length of right hand side of the rule. */
  int rhs_len;
  /* Terminal/nonterminal representations in RHS of the rule.  The
     array end marker is NULL. */
  char **rhs;
  /* The translations numbers. */
  int *trans;
};

/* The following vlos contain all syntax terminal and syntax rule
   structures. */
#ifndef __cplusplus
static vlo_t sterms, srules;
#else
static vlo_t *sterms, *srules;
#endif

/* The following contain all right hand sides and translations arrays.
   See members rhs, trans in structure `rule'. */
#ifndef __cplusplus
static os_t srhs, strans; 
#else
static os_t *srhs, *strans; 
#endif

/* The following is cost of the last translation which contains an
   abstract node. */
static int anode_cost;

/* This variable is used in yacc action to process alternatives. */
static char *slhs;

/* Forward declarations. */
extern int yyerror (const char *str);
extern int yylex (void);
extern int yyparse (void);


#line 162 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif


/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENT = 258,                   /* IDENT  */
    SEM_IDENT = 259,               /* SEM_IDENT  */
    CHAR = 260,                    /* CHAR  */
    NUMBER = 261,                  /* NUMBER  */
    TERM = 262                     /* TERM  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define IDENT 258
#define SEM_IDENT 259
#define CHAR 260
#define NUMBER 261
#define TERM 262

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 124 "./src/sgramm.y"

    void *ref;
    int num;
  

#line 232 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);



/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_IDENT = 3,                      /* IDENT  */
  YYSYMBOL_SEM_IDENT = 4,                  /* SEM_IDENT  */
  YYSYMBOL_CHAR = 5,                       /* CHAR  */
  YYSYMBOL_NUMBER = 6,                     /* NUMBER  */
  YYSYMBOL_TERM = 7,                       /* TERM  */
  YYSYMBOL_8_ = 8,                         /* ';'  */
  YYSYMBOL_9_ = 9,                         /* '='  */
  YYSYMBOL_10_ = 10,                       /* '|'  */
  YYSYMBOL_11_ = 11,                       /* '#'  */
  YYSYMBOL_12_ = 12,                       /* '-'  */
  YYSYMBOL_13_ = 13,                       /* '('  */
  YYSYMBOL_14_ = 14,                       /* ')'  */
  YYSYMBOL_YYACCEPT = 15,                  /* $accept  */
  YYSYMBOL_file = 16,                      /* file  */
  YYSYMBOL_opt_sem = 17,                   /* opt_sem  */
  YYSYMBOL_terms = 18,                     /* terms  */
  YYSYMBOL_number = 19,                    /* number  */
  YYSYMBOL_rule = 20,                      /* rule  */
  YYSYMBOL_21_1 = 21,                      /* $@1  */
  YYSYMBOL_rhs = 22,                       /* rhs  */
  YYSYMBOL_alt = 23,                       /* alt  */
  YYSYMBOL_seq = 24,                       /* seq  */
  YYSYMBOL_trans = 25,                     /* trans  */
  YYSYMBOL_numbers = 26,                   /* numbers  */
  YYSYMBOL_cost = 27                       /* cost  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  7
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   26

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  15
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  13
/* YYNRULES -- Number of rules.  */
#define YYNRULES  30
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  37

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   262


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,    11,     2,     2,     2,     2,
      13,    14,     2,     2,     2,    12,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     8,
       2,     9,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,    10,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   138,   138,   139,   140,   141,   144,   145,   148,   157,
     160,   161,   164,   164,   167,   168,   171,   191,   197,   216,
     219,   220,   221,   228,   235,   239,   245,   246,   252,   260,
     261
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "IDENT", "SEM_IDENT",
  "CHAR", "NUMBER", "TERM", "';'", "'='", "'|'", "'#'", "'-'", "'('",
  "')'", "$accept", "file", "opt_sem", "terms", "number", "rule", "$@1",
  "rhs", "alt", "seq", "trans", "numbers", "cost", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-4)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      13,    -4,    -4,     1,     8,    -4,    -4,    -4,     8,    -4,
      -2,    -4,    -4,    11,    -4,    -1,    -4,     9,    -4,    -4,
      -4,    -4,    -4,    -3,    -4,    -4,    -4,    16,    -4,    -4,
      -4,    10,    -4,     0,    -4,    -4,    -4
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,    12,     9,     0,     6,     5,    19,     1,     6,     3,
      10,     7,     4,     6,    15,    20,     2,     0,     8,    19,
      13,    17,    18,    21,    16,    11,    14,    29,    22,    23,
      30,    25,    26,     0,    27,    28,    24
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
      -4,    -4,     5,    21,    -4,    22,    -4,    -4,     7,    -4,
      -4,    -4,    -4
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     3,    12,     4,    18,     5,     6,    13,    14,    15,
      24,    33,    31
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      27,     7,    21,    28,    22,     1,    34,    17,     2,    29,
      23,    10,    35,    16,    36,    25,    11,     1,    20,    11,
       2,    19,    30,    32,     8,     9,    26
};

static const yytype_int8 yycheck[] =
{
       3,     0,     3,     6,     5,     4,     6,     9,     7,    12,
      11,     3,    12,     8,    14,     6,     8,     4,    13,     8,
       7,    10,     6,    13,     3,     3,    19
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     4,     7,    16,    18,    20,    21,     0,    18,    20,
       3,     8,    17,    22,    23,    24,    17,     9,    19,    10,
      17,     3,     5,    11,    25,     6,    23,     3,     6,    12,
       6,    27,    13,    26,     6,    12,    14
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    15,    16,    16,    16,    16,    17,    17,    18,    18,
      19,    19,    21,    20,    22,    22,    23,    24,    24,    24,
      25,    25,    25,    25,    25,    25,    26,    26,    26,    27,
      27
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     3,     2,     2,     1,     0,     1,     3,     1,
       0,     2,     0,     4,     3,     1,     2,     2,     2,     0,
       0,     1,     2,     2,     6,     3,     0,     2,     2,     0,
       1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 8: /* terms: terms IDENT number  */
#line 149 "./src/sgramm.y"
        {
	  struct sterm term;
	  
	  term.repr = (char *) (yyvsp[-1].ref);
	  term.code = (yyvsp[0].num);
          term.num = VLO_LENGTH (sterms) / sizeof (term);
	  VLO_ADD_MEMORY (sterms, &term, sizeof (term));
	}
#line 1258 "y.tab.c"
    break;

  case 10: /* number: %empty  */
#line 160 "./src/sgramm.y"
                    {(yyval.num) = -1;}
#line 1264 "y.tab.c"
    break;

  case 11: /* number: '=' NUMBER  */
#line 161 "./src/sgramm.y"
                    {(yyval.num) = (yyvsp[0].num);}
#line 1270 "y.tab.c"
    break;

  case 12: /* $@1: %empty  */
#line 164 "./src/sgramm.y"
                 {slhs = (char *) (yyvsp[0].ref);}
#line 1276 "y.tab.c"
    break;

  case 16: /* alt: seq trans  */
#line 172 "./src/sgramm.y"
      {
	struct srule rule;
	int end_marker = -1;

	OS_TOP_ADD_MEMORY (strans, &end_marker, sizeof (int));
	rule.lhs = slhs;
	rule.anode = (char *) (yyvsp[0].ref);
	rule.anode_cost = (rule.anode == NULL ? 0 : anode_cost);
	rule.rhs_len = OS_TOP_LENGTH (srhs) / sizeof (char *);
	OS_TOP_EXPAND (srhs, sizeof (char *));
	rule.rhs = (char **) OS_TOP_BEGIN (srhs);
	rule.rhs [rule.rhs_len] = NULL;
	OS_TOP_FINISH (srhs);
	rule.trans = (int *) OS_TOP_BEGIN (strans);
	OS_TOP_FINISH (strans);
        VLO_ADD_MEMORY (srules, &rule, sizeof (rule));
      }
#line 1298 "y.tab.c"
    break;

  case 17: /* seq: seq IDENT  */
#line 192 "./src/sgramm.y"
       {
	 char *repr = (char *) (yyvsp[0].ref);

	 OS_TOP_ADD_MEMORY (srhs, &repr, sizeof (repr));
       }
#line 1308 "y.tab.c"
    break;

  case 18: /* seq: seq CHAR  */
#line 198 "./src/sgramm.y"
       {
	  struct sterm term;
	  
	  term.repr = (char *) (yyvsp[0].ref);
	  {
	    size_t repr_len = strlen (term.repr);
	    yaep_codepoint_t literal_cp;
	    /* yylex appends the decoded code point directly after the NUL
	       terminator so we can recover it without maintaining a side table. */
	    memcpy (&literal_cp,
		    term.repr + repr_len + 1,
		    sizeof (literal_cp));
	    term.code = (int) literal_cp;
	  }
          term.num = VLO_LENGTH (sterms) / sizeof (term);
	  VLO_ADD_MEMORY (sterms, &term, sizeof (term));
	  OS_TOP_ADD_MEMORY (srhs, &term.repr, sizeof (term.repr));
       }
#line 1331 "y.tab.c"
    break;

  case 20: /* trans: %empty  */
#line 219 "./src/sgramm.y"
            {(yyval.ref) = NULL;}
#line 1337 "y.tab.c"
    break;

  case 21: /* trans: '#'  */
#line 220 "./src/sgramm.y"
            {(yyval.ref) = NULL;}
#line 1343 "y.tab.c"
    break;

  case 22: /* trans: '#' NUMBER  */
#line 222 "./src/sgramm.y"
        {
	  int symb_num = (yyvsp[0].num);

  	  (yyval.ref) = NULL;
	  OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
        }
#line 1354 "y.tab.c"
    break;

  case 23: /* trans: '#' '-'  */
#line 229 "./src/sgramm.y"
        {
	  int symb_num = YAEP_NIL_TRANSLATION_NUMBER;

  	  (yyval.ref) = NULL;
	  OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
        }
#line 1365 "y.tab.c"
    break;

  case 24: /* trans: '#' IDENT cost '(' numbers ')'  */
#line 236 "./src/sgramm.y"
        {
	  (yyval.ref) = (yyvsp[-4].ref);
	}
#line 1373 "y.tab.c"
    break;

  case 25: /* trans: '#' IDENT cost  */
#line 240 "./src/sgramm.y"
        {
	  (yyval.ref) = (yyvsp[-1].ref);
	}
#line 1381 "y.tab.c"
    break;

  case 27: /* numbers: numbers NUMBER  */
#line 247 "./src/sgramm.y"
          {
	    int symb_num = (yyvsp[0].num);
	    
	    OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
          }
#line 1391 "y.tab.c"
    break;

  case 28: /* numbers: numbers '-'  */
#line 253 "./src/sgramm.y"
          {
	    int symb_num = YAEP_NIL_TRANSLATION_NUMBER;
	    
	    OS_TOP_ADD_MEMORY (strans, &symb_num, sizeof (int));
          }
#line 1401 "y.tab.c"
    break;

  case 29: /* cost: %empty  */
#line 260 "./src/sgramm.y"
               { anode_cost = 1;}
#line 1407 "y.tab.c"
    break;

  case 30: /* cost: NUMBER  */
#line 261 "./src/sgramm.y"
               { anode_cost = (yyvsp[0].num); }
#line 1413 "y.tab.c"
    break;


#line 1417 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 263 "./src/sgramm.y"

/* The following is current input character of the grammar
   description. */
static const char *curr_ch;

/* The following is current line number of the grammar description. */
static int ln;

/* The following contains all representation of the syntax tokens. */
#ifndef __cplusplus
static os_t stoks;
#else
static os_t *stoks;
#endif

/* The following is number of syntax terminal and syntax rules being
   read. */
static int nsterm, nsrule;

/* The following implements lexical analyzer for yacc code.
 * 
 * This lexer has been updated to support UTF-8 encoded grammar descriptions.
 * It uses yaep_utf8_next() to iterate through code points rather than bytes,
 * and yaep_utf8_isalpha/isalnum/isdigit for character classification.
 *
 * ASCII Fast Path: The UTF-8 functions are optimized for ASCII, so there
 * is minimal overhead for typical (ASCII-only) grammars.
 *
 * Error Handling: Invalid UTF-8 sequences are detected and reported as
 * lexical errors with appropriate diagnostic messages.
 */
int
yylex (void)
{
  yaep_codepoint_t cp;
  const char *tok_start;
  int n_errs = 0;

  for (;;)
    {
      /* Save the position before reading the next code point,
       * in case we need to report errors at this location. */
      tok_start = curr_ch;
      cp = yaep_utf8_next(&curr_ch);
      
      /* Check for UTF-8 decoding errors */
      if (cp == YAEP_CODEPOINT_INVALID)
	{
	  if (n_errs == 0)
	    {
	      yyerror ("invalid UTF-8 sequence in grammar");
	      n_errs++;
	    }
	  continue;
	}
      
      /* End of string */
      if (cp == YAEP_CODEPOINT_EOS)
	return 0;
      
      /* Handle ASCII characters that map directly to single-byte checks.
       * For these, the code point value equals the byte value. */
      if (cp < 128)
	{
	  switch (cp)
	    {
	    case '\n':
	      ln++;
	    case '\t':
	    case ' ':
	      break;
	    case '/':
	      /* Comment handling */
	      cp = yaep_utf8_next(&curr_ch);
	      if (cp != '*' && n_errs == 0)
		{
		  n_errs++;
		  curr_ch = tok_start + 1; /* Back up to after the '/' */
		  yyerror ("invalid input character /");
		}
	      for (;;)
		{
		  cp = yaep_utf8_next(&curr_ch);
		  if (cp == YAEP_CODEPOINT_EOS)
		    yyerror ("unfinished comment");
		  if (cp == YAEP_CODEPOINT_INVALID)
		    {
		      if (n_errs == 0)
			{
			  yyerror ("invalid UTF-8 in comment");
			  n_errs++;
			}
		      continue;
		    }
		  if (cp == '\n')
		    ln++;
		  if (cp == '*')
		    {
		      const char *star_pos = curr_ch;
		      cp = yaep_utf8_next(&curr_ch);
		      if (cp == '/')
			break;
		      curr_ch = star_pos; /* Back up if not end of comment */
		    }
		}
	      break;
	    case '=':
	    case '#':
	    case '|':
	    case ';':
	    case '-':
	    case '(':
	    case ')':
	      return (int)cp;
			case '\'':
				{
					/* Character literal: 'x' where x can be any single Unicode scalar.
						 We preserve the exact UTF-8 bytes so downstream consumers see the
						 literal exactly as authored, and we append the decoded code point
						 after the NUL terminator for later retrieval. */
					const char *repr_start = tok_start;
					yaep_codepoint_t literal_cp;
					yaep_codepoint_t closing_cp;

					literal_cp = yaep_utf8_next (&curr_ch);
					if (literal_cp == YAEP_CODEPOINT_EOS || literal_cp == YAEP_CODEPOINT_INVALID)
						{
							yyerror ("invalid character literal");
							break;
						}

					closing_cp = yaep_utf8_next (&curr_ch);
					if (closing_cp != '\'')
						{
							yyerror ("unterminated character literal");
							break;
						}

					{
						size_t repr_len = curr_ch - repr_start;
						yaep_codepoint_t stored_cp = literal_cp;

						OS_TOP_ADD_MEMORY (stoks, repr_start, repr_len);
						OS_TOP_ADD_BYTE (stoks, '\0');
						OS_TOP_ADD_MEMORY (stoks, &stored_cp, sizeof (stored_cp));
						yylval.ref = OS_TOP_BEGIN (stoks);
						OS_TOP_FINISH (stoks);
					}

					return CHAR;
				}
	    default:
	      /* Check if this is the start of an identifier (ASCII fast path) */
	      if ((cp >= 'A' && cp <= 'Z') || (cp >= 'a' && cp <= 'z') || cp == '_')
		goto identifier;
		/* Check if this is the start of a number (ASCII fast path) */
		if (cp >= '0' && cp <= '9')
		goto number;
	      /* Otherwise, this is an error */
	      goto error;
	    }
	}
      else
	{
	  /* Non-ASCII code point: classify using Unicode predicates. */
	  if (yaep_utf8_isdigit (cp))
	    goto number;
	  if (yaep_utf8_isalpha (cp))
	    goto identifier;
	  /* Otherwise, it's an invalid token */
	  goto error;
	}
      continue;

    identifier:
      /* Identifier: starts with letter or underscore, continues with
       * alphanumeric or underscore. Now supports full Unicode identifiers. */
      {
	const char *id_start = tok_start;
	int id_byte_len;

	/*
	 * Iterate with `yaep_utf8_next_with_len` which returns the decoded
	 * code point and the number of bytes consumed.  This lets the lexer
	 * advance and remember byte boundaries without reparsing from the
	 * token start.  The previous implementation re-parsed from
	 * `id_start` to back up when a non-identifier character was found;
	 * that was correct but redundant and costlier.  Using the _with_len
	 * helper makes the code simpler and more efficient while preserving
	 * exact byte-level semantics.
	 */
	{
	  const char *p = curr_ch;
	  const char *last_good = id_start; /* last pointer just after a valid cp */
	  size_t bytes_len = 0;
	  yaep_codepoint_t test_cp;

	  /* The first code point was already validated as a start character; mark it */
	  last_good = curr_ch;

	  while ((test_cp = yaep_utf8_next_with_len(&p, &bytes_len)) != YAEP_CODEPOINT_EOS &&
	         test_cp != YAEP_CODEPOINT_INVALID)
	    {
	      if (!yaep_utf8_isalnum(test_cp) && test_cp != '_')
	        break;
	      /* Advance last_good to the byte position after this code point */
	      last_good = p;
	    }

		/* Set curr_ch to the last byte position that is still part of the identifier */
		curr_ch = last_good;
		}

		/* Now compute byte length for copying */
	id_byte_len = curr_ch - id_start;
	for (int i = 0; i < id_byte_len; i++)
	  /* Ensure bytes are treated as unsigned when stored: avoid
	     platform-dependent sign-extension later during hashing or
	     byte-wise operations. Store each source byte as an
	     unsigned char value. */
	  OS_TOP_ADD_BYTE (stoks, (unsigned char) id_start[i]);
	OS_TOP_ADD_BYTE (stoks, '\0');
	yylval.ref = OS_TOP_BEGIN (stoks);
	
	/* Check for keyword "TERM" */
	if (strcmp ((char *) yylval.ref, "TERM") == 0)
	  {
	    OS_TOP_NULLIFY (stoks);
	    return TERM;
	  }
	OS_TOP_FINISH (stoks);
	
	/* Skip whitespace and check for ':' to distinguish identifiers.
	 * We need to look ahead past whitespace to see if there's a ':' character.
	 * If not, we need to back up curr_ch to before the first non-whitespace char.
	 */
	const char *before_nonws = curr_ch; /* Position before any whitespace */
	while ((cp = yaep_utf8_next(&curr_ch)) != YAEP_CODEPOINT_EOS)
	  {
	    if (cp == YAEP_CODEPOINT_INVALID)
	      {
		if (n_errs == 0)
		  {
		    yyerror ("invalid UTF-8 after identifier");
		    n_errs++;
		  }
		continue;
	      }
	    if (cp == '\n')
	      {
		ln++;
		before_nonws = curr_ch;
	      }
	    else if (yaep_utf8_isspace(cp))
	      {
		before_nonws = curr_ch;
	      }
	    else
	      {
		/* Found non-whitespace character. If it's not ':', back up. */
		if (cp != ':')
		  curr_ch = before_nonws;
		break;
	      }
	  }
	
	return (cp == ':' ? SEM_IDENT : IDENT);
      }

			number:
				{
					/* Number: sequence of Unicode decimal digits (Nd).  We track the
						 originating block so that scripts cannot be mixed within a single
						 literal, mirroring guidance from UAX #31. */
					int digit_value;
					yaep_codepoint_t digit_block;
					const char *digit_boundary;

				if (!yaep_utf8_digit_value (cp, &digit_value, &digit_block))
					{
						if (n_errs == 0)
							{
								yyerror ("invalid digit in number literal");
								n_errs++;
							}
						return NUMBER;
					}

				yylval.num = digit_value;

				for (;;)
					{
						digit_boundary = curr_ch;
						yaep_codepoint_t next_cp = yaep_utf8_next (&curr_ch);

						if (next_cp == YAEP_CODEPOINT_EOS)
							break;

						if (next_cp == YAEP_CODEPOINT_INVALID)
							{
								if (n_errs == 0)
									{
										yyerror ("invalid UTF-8 in number literal");
										n_errs++;
									}
								break;
							}

						int next_digit;
						yaep_codepoint_t next_block;
						if (!yaep_utf8_digit_value (next_cp, &next_digit, &next_block))
							{
								curr_ch = digit_boundary;
								break;
							}

						if (next_block != digit_block)
							{
								if (n_errs == 0)
									{
										yyerror ("mixed-digit Unicode number literal");
										n_errs++;
									}
								curr_ch = digit_boundary;
								break;
							}

						yylval.num = yylval.num * 10 + next_digit;
					}

				return NUMBER;
			}

    error:
      /* Invalid character encountered */
      n_errs++;
			if (n_errs == 1)
		{
			char str[YAEP_MAX_ERROR_MESSAGE_LENGTH / 2];
			int written = 0;

			if (cp < 128 && isprint((int)cp))
				written = snprintf (str, sizeof (str), "invalid input character '%c'", (char)cp);
			else if (cp >= 0)
				written = snprintf (str, sizeof (str), "invalid input character U+%04X", cp);
			else
				written = snprintf (str, sizeof (str), "invalid UTF-8 sequence");

			/* Ensure NUL termination and pass to yyerror */
			if (written < 0)
				str[0] = '\0';
			else
				str[sizeof (str) - 1] = '\0';
			yyerror (str);
		}
    }
}


/* The following implements syntactic error diagnostic function yacc
   code. */
int
yyerror (const char *str)
{
  (void) str;
  yaep_error (YAEP_DESCRIPTION_SYNTAX_ERROR_CODE,
	      "description syntax error on ln %d", ln);
  return 0;
}

/* The following function is used to sort array of syntax terminals by
   names. */
static int
sterm_name_cmp (const void *t1, const void *t2)
{
  return strcmp (((struct sterm *) t1)->repr, ((struct sterm *) t2)->repr);
}

/* The following function is used to sort array of syntax terminals by
   order number. */
static int
sterm_num_cmp (const void *t1, const void *t2)
{
  return ((struct sterm *) t1)->num - ((struct sterm *) t2)->num;
}

static void free_sgrammar (void);

/* The following is major function which parses the description and
   transforms it into IR. */
static int
set_sgrammar (struct grammar *g, const char *grammar)
{
  int i, j, num;
  struct sterm *term, *prev, *arr;
  int code = 256;

  ln = 1;
  if ((code = setjmp (error_longjump_buff)) != 0)
    {
      free_sgrammar ();
      return code;
    }
  OS_CREATE (stoks, g->alloc, 0);
  VLO_CREATE (sterms, g->alloc, 0);
  VLO_CREATE (srules, g->alloc, 0);
  OS_CREATE (srhs, g->alloc, 0);
  OS_CREATE (strans, g->alloc, 0);
  curr_ch = grammar;
  yyparse ();
  /* sort array of syntax terminals by names. */
  num = VLO_LENGTH (sterms) / sizeof (struct sterm);
  arr = (struct sterm *) VLO_BEGIN (sterms);
  qsort (arr, num, sizeof (struct sterm), sterm_name_cmp);
  /* Check different codes for the same syntax terminal and remove
     duplicates. */
  for (i = j = 0, prev = NULL; i < num; i++)
    {
      term = arr + i;
      if (prev == NULL || strcmp (prev->repr, term->repr) != 0)
	{
	  prev = term;
	  arr[j++] = *term;
	}
      else if (term->code != -1 && prev->code != -1
	       && prev->code != term->code)
	{
	  char str[YAEP_MAX_ERROR_MESSAGE_LENGTH / 2];

	  strncpy (str, prev->repr, sizeof (str));
	  str[sizeof (str) - 1] = '\0';
	  yaep_error (YAEP_REPEATED_TERM_CODE,
		      "term %s described repeatedly with different code",
		      str);
	}
      else if (prev->code != -1)
	prev->code = term->code;
    }
  VLO_SHORTEN (sterms, (num - j) * sizeof (struct sterm));
  num = j;
  /* sort array of syntax terminals by order number. */
  qsort (arr, num, sizeof (struct sterm), sterm_num_cmp);
  /* Assign codes. */
  for (i = 0; i < num; i++)
    {
      term = (struct sterm *) VLO_BEGIN (sterms) + i;
      if (term->code < 0)
	term->code = code++;
    }
  nsterm = nsrule = 0;
  return 0;
}

/* The following frees IR. */
static void
free_sgrammar (void)
{
  OS_DELETE (strans);
  OS_DELETE (srhs);
  VLO_DELETE (srules);
  VLO_DELETE (sterms);
  OS_DELETE (stoks);
}

/* The following two functions implements functions used by YAEP. */
static const char *
sread_terminal (int *code)
{
  struct sterm *term;
  const char *name;

  term = &((struct sterm *) VLO_BEGIN (sterms))[nsterm];
  if ((char *) term >= (char *) VLO_BOUND (sterms))
    return NULL;
  *code = term->code;
  name = term->repr;
  nsterm++;
  return name;
}

static const char *
sread_rule (const char ***rhs, const char **abs_node, int *anode_cost,
	    int **transl)
{
  struct srule *rule;
  const char *lhs;

  rule = &((struct srule *) VLO_BEGIN (srules))[nsrule];
  if ((char *) rule >= (char *) VLO_BOUND (srules))
    return NULL;
  lhs = rule->lhs;
  *rhs = (const char **) rule->rhs;
  *abs_node = rule->anode;
  *anode_cost = rule->anode_cost;
  *transl = rule->trans;
  nsrule++;
  return lhs;
}

/* The following function parses grammar desrciption. */
int
yaep_parse_grammar (struct grammar *g, int strict_p, const char *description)
{
	int code;
	size_t error_offset = 0;
	int validation_error = 0;

	assert (g != NULL);
	grammar = g;
	if (!yaep_utf8_validate (description, NULL,
													 &error_offset, &validation_error))
		{
			const char *msg = yaep_utf8_error_message (validation_error);

			g->error_code = YAEP_INVALID_UTF8;
			snprintf (g->error_message, sizeof (g->error_message),
								"invalid UTF-8 in grammar description at byte %zu: %s",
								error_offset, msg);
			return YAEP_INVALID_UTF8;
		}
  if ((code = set_sgrammar (g, description)) != 0)
    return code;
  code = yaep_read_grammar (g, strict_p, sread_terminal, sread_rule);
  free_sgrammar ();
  return code;
}
