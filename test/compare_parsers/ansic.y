/*
   YAEP (Yet Another Earley Parser)

   Copyright (c) 1997-2018  Vladimir Makarov <vmakarov@gcc.gnu.org>

   Permission is hereby granted, free of charge, to any person obtaining a
   copy of this software and associated documentation files (the
   "Software"), to deal in the Software without restriction, including
   without limitation the rights to use, copy, modify, merge, publish,
   distribute, sublicense, and/or sell copies of the Software, and to
   permit persons to whom the Software is furnished to do so, subject to
   the following conditions:

   The above copyright notice and this permission notice shall be included
   in all copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

*/

%{
#define YYSTYPE string_t
%}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME INLINE

%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST VOLATILE VOID
%token STRUCT UNION ENUM ELIPSIS

%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN

%start file
%%

primary_expr
	: identifier
	| CONSTANT
	| STRING_LITERAL
	| '(' expr ')'
	;

postfix_expr
	: primary_expr
	| postfix_expr '[' expr ']'
	| postfix_expr '(' ')'
	| postfix_expr '(' argument_expr_list ')'
	| postfix_expr '.' identifier
	| postfix_expr PTR_OP identifier
	| postfix_expr INC_OP
	| postfix_expr DEC_OP
	;

argument_expr_list
	: assignment_expr
	| argument_expr_list ',' assignment_expr
	;

unary_expr
	: postfix_expr
	| INC_OP unary_expr
	| DEC_OP unary_expr
	| unary_operator cast_expr
	| SIZEOF unary_expr
	| SIZEOF '(' type_name ')'
	;

unary_operator
	: '&'
	| '*'
	| '+'
	| '-'
	| '~'
	| '!'
	;

cast_expr
	: unary_expr
	| '(' type_name ')' cast_expr
	;

multiplicative_expr
	: cast_expr
	| multiplicative_expr '*' cast_expr
	| multiplicative_expr '/' cast_expr
	| multiplicative_expr '%' cast_expr
	;

additive_expr
	: multiplicative_expr
	| additive_expr '+' multiplicative_expr
	| additive_expr '-' multiplicative_expr
	;

shift_expr
	: additive_expr
	| shift_expr LEFT_OP additive_expr
	| shift_expr RIGHT_OP additive_expr
	;

relational_expr
	: shift_expr
	| relational_expr '<' shift_expr
	| relational_expr '>' shift_expr
	| relational_expr LE_OP shift_expr
	| relational_expr GE_OP shift_expr
	;

equality_expr
	: relational_expr
	| equality_expr EQ_OP relational_expr
	| equality_expr NE_OP relational_expr
	;

and_expr
	: equality_expr
	| and_expr '&' equality_expr
	;

exclusive_or_expr
	: and_expr
	| exclusive_or_expr '^' and_expr
	;

inclusive_or_expr
	: exclusive_or_expr
	| inclusive_or_expr '|' exclusive_or_expr
	;

logical_and_expr
	: inclusive_or_expr
	| logical_and_expr AND_OP inclusive_or_expr
	;

logical_or_expr
	: logical_and_expr
	| logical_or_expr OR_OP logical_and_expr
	;

conditional_expr
	: logical_or_expr
	| logical_or_expr '?' logical_or_expr ':' conditional_expr
	;

assignment_expr
	: conditional_expr
	| unary_expr assignment_operator assignment_expr
	;

assignment_operator
	: '='
	| MUL_ASSIGN
	| DIV_ASSIGN
	| MOD_ASSIGN
	| ADD_ASSIGN
	| SUB_ASSIGN
	| LEFT_ASSIGN
	| RIGHT_ASSIGN
	| AND_ASSIGN
	| XOR_ASSIGN
	| OR_ASSIGN
	;

expr
	: assignment_expr
	| expr ',' assignment_expr
	;

constant_expr
	: conditional_expr
	;

declaration
	: declaration_specifiers ';'
            {typedef_flag = NULL;}
	| declaration_specifiers init_declarator_list ';' 
            {typedef_flag = NULL;}
	;


declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	;

init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;

init_declarator
	: declarator
	| declarator '=' initializer
	;

storage_class_specifier
	: TYPEDEF         {typedef_flag = (string_t) 64;}
	| EXTERN
	| STATIC
	| AUTO
	| REGISTER
        | INLINE
	;

type_specifier
	: CHAR
	| SHORT
	| INT
	| LONG
	| SIGNED
	| UNSIGNED
	| FLOAT
	| DOUBLE
	| CONST
	| VOLATILE
	| VOID
	| struct_or_union_specifier
	| enum_specifier
	| TYPE_NAME
	;

struct_or_union_specifier
	: struct_or_union after_struct identifier  {after_struct_flag = 0;}
             '{' {$$ = typedef_flag;level++;typedef_flag = NULL;}
             struct_declaration_list {typedef_flag = $6;level--;} '}'
	| struct_or_union after_struct  {after_struct_flag = 0;}
             '{' {$$ = typedef_flag;level++;typedef_flag = NULL;}
                              struct_declaration_list
                              {typedef_flag = $5;level--;} '}'
	| struct_or_union after_struct identifier  {after_struct_flag = 0;}
	;

after_struct : {after_struct_flag = 1;}
             ;

struct_or_union
	: STRUCT
	| UNION
	;

struct_declaration_list
	: struct_declaration
	| struct_declaration_list struct_declaration
	;

struct_declaration
	: type_specifier_list struct_declarator_list ';'
	;

struct_declarator_list
	: struct_declarator
	| struct_declarator_list ',' struct_declarator
	;

struct_declarator
	: declarator
	| ':' constant_expr
	| declarator ':' constant_expr
	;

enum_specifier
	: ENUM '{' enumerator_list '}'
	| ENUM identifier '{' enumerator_list '}'
	| ENUM identifier
	;

enumerator_list
	: enumerator
	| enumerator_list ',' enumerator
	;

enumerator
	: identifier
	| identifier '=' constant_expr
	;

declarator
	: declarator2
	| pointer declarator2
	;

declarator2
	: identifier                  {if (typedef_flag != NULL)
                                         add_typedef ((char *) $1, level);}
	| '(' declarator ')'
	| declarator2 '[' ']'
	| declarator2 '[' constant_expr ']'
	| declarator2 '(' ')'
	| declarator2 '(' parameter_type_list ')'
	| declarator2 '(' parameter_identifier_list ')'
	;

pointer
	: '*'
	| '*' type_specifier_list
	| '*' pointer
	| '*' type_specifier_list pointer
	;

type_specifier_list
	: type_specifier
	| type_specifier_list type_specifier
	;

parameter_identifier_list
	: identifier_list
	| identifier_list ',' ELIPSIS
	;

identifier_list
	: identifier
	| identifier_list ',' identifier
	;

parameter_type_list
	: parameter_list
	| parameter_list ',' ELIPSIS
	;

parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;

parameter_declaration
	: type_specifier_list declarator
	| type_name
	;

type_name
	: type_specifier_list
	| type_specifier_list abstract_declarator
	;

abstract_declarator
	: pointer
	| abstract_declarator2
	| pointer abstract_declarator2
	;

abstract_declarator2
	: '(' abstract_declarator ')'
	| '[' ']'
	| '[' constant_expr ']'
	| abstract_declarator2 '[' ']'
	| abstract_declarator2 '[' constant_expr ']'
	| '(' ')'
	| '(' parameter_type_list ')'
	| abstract_declarator2 '(' ')'
	| abstract_declarator2 '(' parameter_type_list ')'
	;

initializer
	: assignment_expr
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	;

initializer_list
	: initializer
	| initializer_list ',' initializer
	;

statement
	: labeled_statement
	| compound_statement
	| expression_statement
	| selection_statement
	| iteration_statement
	| jump_statement
	;

labeled_statement
	: identifier ':' statement
	| CASE constant_expr ':' statement
	| DEFAULT ':' statement
	;

compound_statement
	: '{' '}'
	| '{' incr_level statement_list {level--;} '}'
	| '{' incr_level declaration_list {level--;} '}'
	| '{' incr_level declaration_list statement_list {level--;} '}'
	;

/* mine */
incr_level : {level++;}
           ;

declaration_list
	: declaration
	| declaration_list declaration
	;

statement_list
	: statement
	| statement_list statement
	;

expression_statement
	: ';'
	| expr ';'
	;

selection_statement
	: IF '(' expr ')' statement
	| IF '(' expr ')' statement ELSE statement
	| SWITCH '(' expr ')' statement
	;

iteration_statement
	: WHILE '(' expr ')' statement
	| DO statement WHILE '(' expr ')' ';'
	| FOR '(' ';' ';' ')' statement
	| FOR '(' ';' ';' expr ')' statement
	| FOR '(' ';' expr ';' ')' statement
	| FOR '(' ';' expr ';' expr ')' statement
	| FOR '(' expr ';' ';' ')' statement
	| FOR '(' expr ';' ';' expr ')' statement
	| FOR '(' expr ';' expr ';' ')' statement
	| FOR '(' expr ';' expr ';' expr ')' statement
	;

jump_statement
	: GOTO identifier ';'
	| CONTINUE ';'
	| BREAK ';'
	| RETURN ';'
	| RETURN expr ';'
	;

file
	: external_definition
	| file external_definition
	;

external_definition
	: function_definition
	| declaration
	;

function_definition
	: declarator function_body
	| declaration_specifiers declarator function_body
	;

function_body
	: compound_statement
	| declaration_list compound_statement
	;

identifier
	: IDENTIFIER  {$$ = $1;}
	;
%%

#include <stdio.h>

extern int column;
extern int line;

int
yyerror (const char *s)
{
	(void)s;
	fprintf (stderr, "syntax error line - %d, column - %d\n", line, column + 1);
	return 0;
}
