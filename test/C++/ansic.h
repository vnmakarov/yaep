#define IDENTIFIER 1000
#define SIGNED     2000
#define CONST      3000
#define INLINE     4000
#define AUTO       5000
#define BREAK      6000
#define CASE       7000
#define CHAR       8000
#define CONTINUE   9000
#define DEFAULT    1001
#define DO	   2001
#define DOUBLE	   3001
#define ELSE	   4001
#define ENUM	   5001
#define EXTERN	   6001
#define FLOAT	   7001
#define FOR	   8001
#define GOTO	   9001
#define IF         1002
#define INT	   2002
#define LONG	   3002
#define REGISTER   4002
#define RETURN	   5002
#define SHORT	   6002
#define SIZEOF	   7002
#define STATIC	   8002
#define STRUCT	   9002
#define SWITCH     1003
#define TYPEDEF	   2003
#define UNION	   3003
#define UNSIGNED   4003
#define VOID	   5003
#define VOLATILE   6003
#define WHILE	   7003
#define CONSTANT   8003
#define STRING_LITERAL 9003
#define RIGHT_ASSIGN  1004
#define LEFT_ASSIGN   2004
#define ADD_ASSIGN    3004
#define SUB_ASSIGN    4004
#define MUL_ASSIGN    5004
#define DIV_ASSIGN    6004
#define MOD_ASSIGN    7004
#define AND_ASSIGN    8004
#define XOR_ASSIGN    9004
#define OR_ASSIGN     1005
#define RIGHT_OP      2007
#define LEFT_OP	      3005
#define INC_OP	      4005
#define DEC_OP	      5005
#define PTR_OP	      6005
#define AND_OP	      7005
#define OR_OP	      8005
#define LE_OP	      9005
#define GE_OP         1006
#define EQ_OP	      2006
#define NE_OP	      3006
#define ELIPSIS	      4006
#define RESTRICT      5006
#define _BOOL         6006
#define _COMPLEX      7006
#define _IMAGINARY    8006

struct lex {
  short code;
  short column;
  int line;
  const char *id;
  struct lex *next;
};

extern int column;
extern int line;

extern int yylex (void);
extern char *get_yytext (void);
