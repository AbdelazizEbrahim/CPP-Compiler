%{
#include "parser.tab.h"
#include <stdio.h>
%}

%%
"int"                { printf("Token: INT\n"); return INT; }
"float"              { printf("Token: FLOAT\n"); return FLOAT; }
"double"             { printf("Token: DOUBLE\n"); return DOUBLE; }
"boolean"            { printf("Token: BOOLEAN\n"); return BOOLEAN; }
"char"               { printf("Token: CHAR\n"); return CHAR; }
"String"             { printf("Token: STRING\n"); return STRING; }
"std::string"        { printf("Token: STD STRING\n"); return STDSTRING; }
"void"               { printf("Token: VOID\n"); return VOID; }

"if"                 { printf("Token: IF\n"); return IF; }
"else"               { printf("Token: ELSE\n"); return ELSE; }
"while"              { printf("Token: WHILE\n"); return WHILE; }
"do"                 { printf("Token: DO\n"); return DO; }
"for"                { printf("Token: FOR\n"); return FOR; }
"break"              { printf("Token: BREAK\n"); return BREAK; }
"continue"           { printf("Token: CONTINUE\n"); return CONTINUE; }
"return"             { printf("Token: RETURN\n"); return RETURN; }
"try"                { printf("Token: TRY\n"); return TRY; }
"catch"              { printf("Token: CATCH\n"); return CATCH; }

"main"               { printf("Token: MAIN\n"); return MAIN; }
"std"                { printf("Token: STD\n"); return STD; }
"cout"               { printf("Token: COUT\n"); return COUT; }
"cin"                { printf("Token: CIN\n"); return CIN; } 
"endl"               { printf("Token: ENDL\n"); return ENDL; }

"<<"                 { printf("Token: LSHIFT\n"); return LSHIFT; }
">>"                 { printf("Token: RSHIFT\n"); return RSHIFT; }
"::"                 { printf("Token: SCOPE\n"); return SCOPE; }
"="                  { printf("Token: ASSIGN\n"); return ASSIGN; }
"+"                  { printf("Token: PLUS\n"); return PLUS; }
"-"                  { printf("Token: MINUS\n"); return MINUS; }
"*"                  { printf("Token: MULT\n"); return MULT; }
"/"                  { printf("Token: DIV\n"); return DIV; }
"%"                  { printf("Token: MOD\n"); return MOD; }
"=="                 { printf("Token: EQ\n"); return EQ; }
"!="                 { printf("Token: NEQ\n"); return NEQ; }
">="                 { printf("Token: GTE\n"); return GTE; }
"<="                 { printf("Token: LTE\n"); return LTE; }
">"                  { printf("Token: GT\n"); return GT; }
"<"                  { printf("Token: LT\n"); return LT; }
"&&"                 { printf("Token: AND\n"); return AND; }
"||"                 { printf("Token: OR\n"); return OR; }
"!"                  { printf("Token: NOT\n"); return NOT; }

"switch"             { printf("Found 'switch'\n"); return SWITCH; }
"case"               { printf("Found 'case'\n"); return CASE; }
"default"            { printf("Found 'default'\n"); return DEFAULT; }
":"                  { printf("Found ':'\n"); return COLON; }

[0-9]+               { printf("Token: NUMBER (%s)\n", yytext); return NUMBER; }
[A-Za-z_][A-Za-z0-9_]* { printf("Token: IDENTIFIER (%s)\n", yytext); return IDENTIFIER; }

\"[^\"]*\"           { printf("Token: STRING_LITERAL\n"); return STRING_LITERAL; } // String literals
\'[^\']\'            { printf("Token: CHAR_LITERAL\n"); return CHAR_LITERAL; } // Char literals

";"                  { printf("Token: SEMICOLON\n"); return SEMICOLON; }
","                  { printf("Token: COMMA\n"); return COMMA; }
"{"                  { printf("Token: LBRACE\n"); return LBRACE; }
"}"                  { printf("Token: RBRACE\n"); return RBRACE; }
"["                  { printf("Token: LBRACKET\n"); return LBRACKET; }
"]"                  { printf("Token: RBRACKET\n"); return RBRACKET; }
"("                  { printf("Token: LPAREN\n"); return LPAREN; }
")"                  { printf("Token: RPAREN\n"); return RPAREN; }
"."                  { printf("Token: DOT\n"); return DOT; }

[ \t\n\r]+           { /* Ignore whitespace */ }
"//".*               { /* Ignore single-line comments */ }
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+"/" {} // Multi-line comments

.                    { printf("Unknown token: %s\n", yytext); return ERROR; }

%%

int yywrap() {
    return 1;
}