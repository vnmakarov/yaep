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

%option reentrant
%option extra-type="struct lex *"

D			[0-9]
L			[a-zA-Z_]
H			[a-fA-F0-9]
E			[Ee][+-]?{D}+
FS			(f|F|l|L)
IS			(u|U|l|L)*

%{
#include <stdio.h>
#include "ansic.h"

#ifdef ECHO
#undef ECHO
#endif

#define ECHO

#ifdef __cplusplus
static int yyinput();
#define input yyinput
#endif
int yywrap ();
struct yyguts_t; /* FIXME: internal flex type, needed for the comment()
                    and count() functions, because these functions call
                    unput() or use yytext, which is allowed only inside a rule. */
int comment (yyscan_t yyscanner, struct yyguts_t *yyg);
void count (struct yyguts_t *yyg);
int check_type (void);

%}

%%
"/*"			{ comment (yyscanner, yyg); }

"__signed__"          	{ count (yyg); return(SIGNED); }
"__signed"          	{ count (yyg); return(SIGNED); }
"__const"        	{ count (yyg); return(CONST); }
"__const__"        	{ count (yyg); return(CONST); }
"__inline"        	{ count (yyg); return(INLINE); }
"__inline__"        	{ count (yyg); return(INLINE); }

"auto"			{ count (yyg); return(AUTO); }
"break"			{ count (yyg); return(BREAK); }
"case"			{ count (yyg); return(CASE); }
"char"			{ count (yyg); return(CHAR); }
"const"			{ count (yyg); return(CONST); }
"continue"		{ count (yyg); return(CONTINUE); }
"default"		{ count (yyg); return(DEFAULT); }
"do"			{ count (yyg); return(DO); }
"double"		{ count (yyg); return(DOUBLE); }
"else"			{ count (yyg); return(ELSE); }
"enum"			{ count (yyg); return(ENUM); }
"extern"		{ count (yyg); return(EXTERN); }
"float"			{ count (yyg); return(FLOAT); }
"for"			{ count (yyg); return(FOR); }
"goto"			{ count (yyg); return(GOTO); }
"if"			{ count (yyg); return(IF); }
"int"			{ count (yyg); return(INT); }
"long"			{ count (yyg); return(LONG); }
"register"		{ count (yyg); return(REGISTER); }
"return"		{ count (yyg); return(RETURN); }
"short"			{ count (yyg); return(SHORT); }
"signed"		{ count (yyg); return(SIGNED); }
"sizeof"		{ count (yyg); return(SIZEOF); }
"static"		{ count (yyg); return(STATIC); }
"struct"		{ count (yyg); return(STRUCT); }
"switch"		{ count (yyg); return(SWITCH); }
"typedef"		{ count (yyg); return(TYPEDEF); }
"union"			{ count (yyg); return(UNION); }
"unsigned"		{ count (yyg); return(UNSIGNED); }
"void"			{ count (yyg); return(VOID); }
"volatile"		{ count (yyg); return(VOLATILE); }
"while"			{ count (yyg); return(WHILE); }

{L}({L}|{D})*		{ count (yyg); return(check_type()); }

0[xX]{H}+{IS}?		{ count (yyg); return(CONSTANT); }
0{D}+{IS}?		{ count (yyg); return(CONSTANT); }
{D}+{IS}?		{ count (yyg); return(CONSTANT); }
'(\\.|[^\\'])+'		{ count (yyg); return(CONSTANT); }

{D}+{E}{FS}?		{ count (yyg); return(CONSTANT); }
{D}*"."{D}+({E})?{FS}?	{ count (yyg); return(CONSTANT); }
{D}+"."{D}*({E})?{FS}?	{ count (yyg); return(CONSTANT); }

\"(\\.|[^\\"])*\"	{ count (yyg); return(STRING_LITERAL); }

">>="			{ count (yyg); return(RIGHT_ASSIGN); }
"<<="			{ count (yyg); return(LEFT_ASSIGN); }
"+="			{ count (yyg); return(ADD_ASSIGN); }
"-="			{ count (yyg); return(SUB_ASSIGN); }
"*="			{ count (yyg); return(MUL_ASSIGN); }
"/="			{ count (yyg); return(DIV_ASSIGN); }
"%="			{ count (yyg); return(MOD_ASSIGN); }
"&="			{ count (yyg); return(AND_ASSIGN); }
"^="			{ count (yyg); return(XOR_ASSIGN); }
"|="			{ count (yyg); return(OR_ASSIGN); }
">>"			{ count (yyg); return(RIGHT_OP); }
"<<"			{ count (yyg); return(LEFT_OP); }
"++"			{ count (yyg); return(INC_OP); }
"--"			{ count (yyg); return(DEC_OP); }
"->"			{ count (yyg); return(PTR_OP); }
"&&"			{ count (yyg); return(AND_OP); }
"||"			{ count (yyg); return(OR_OP); }
"<="			{ count (yyg); return(LE_OP); }
">="			{ count (yyg); return(GE_OP); }
"=="			{ count (yyg); return(EQ_OP); }
"!="			{ count (yyg); return(NE_OP); }
";"			{ count (yyg); return(';'); }
"{"			{ count (yyg); return('{'); }
"}"			{ count (yyg); return('}'); }
","			{ count (yyg); return(','); }
":"			{ count (yyg); return(':'); }
"="			{ count (yyg); return('='); }
"("			{ count (yyg); return('('); }
")"			{ count (yyg); return(')'); }
"["			{ count (yyg); return('['); }
"]"			{ count (yyg); return(']'); }
"..."			{ count (yyg); return(ELIPSIS); }
"."			{ count (yyg); return('.'); }
"&"			{ count (yyg); return('&'); }
"!"			{ count (yyg); return('!'); }
"~"			{ count (yyg); return('~'); }
"-"			{ count (yyg); return('-'); }
"+"			{ count (yyg); return('+'); }
"*"			{ count (yyg); return('*'); }
"/"			{ count (yyg); return('/'); }
"%"			{ count (yyg); return('%'); }
"<"			{ count (yyg); return('<'); }
">"			{ count (yyg); return('>'); }
"^"			{ count (yyg); return('^'); }
"|"			{ count (yyg); return('|'); }
"?"			{ count (yyg); return('?'); }

[ \t\v\n\f]		{ count (yyg); }
.			{ /* ignore bad characters */ }

%%

int
yywrap (yyscan_t unused)
{
	return(1);
}

int
comment (yyscan_t yyscanner, struct yyguts_t *yyg)
{
	char c, c1;

loop:
	while ((c = input (yyscanner)) != '*' && c != 0)
		/*putchar(c)*/;

	if ((c1 = input (yyscanner)) != '/' && c != 0)
	{
		unput(c1);
		goto loop;
	}

	if (c != 0)
		/*putchar(c1)*/;
}

void
count (struct yyguts_t *yyg)
{
	int i;
        struct lex *lex = yyget_extra (yyg);

	for (i = 0; yytext[i] != '\0'; i++)
		if (yytext[i] == '\n')
                  {
	            lex->column = 0;
                    lex->line++;
                  }
		else if (yytext[i] == '\t')
			lex->column += 8 - (lex->column % 8);
		else
			lex->column++;

	ECHO;
}

int
check_type (void)
{
/*
* pseudo code --- this is what it should check
*
*	if (yytext == type_name)
*		return(TYPE_NAME);
*
*	return(IDENTIFIER);
*/

/*
*	it actually will only return IDENTIFIER
*/

	return(IDENTIFIER);
}
