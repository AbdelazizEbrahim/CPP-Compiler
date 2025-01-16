%{
#include "y.tab.h"
#include <stdio.h>
%}

%%
"#"                  { return HASH; }; 
"int"                { printf("Token: INT\n"); return INT; }
"float"              { return FLOAT; }
"double"             { return DOUBLE; }
"bool"               { return BOOL; }
"char"               { return CHAR; }
"void"               { return VOID; }
"if"                 { return IF; }
"else"               { return ELSE; }
"while"              { return WHILE; }
"for"                { return FOR; }
"break"              { return BREAK; }
"continue"           { return CONTINUE; }
"return"             { return RETURN; }
"class"              { printf("Token: CLASS\n"); return CLASS; }
"struct"             { return STRUCT; }
"public"             { printf("Token: PUBLIC\n"); return PUBLIC; }
"private"            { return PRIVATE; }
"protected"          { return PROTECTED; }
"new"                { return NEW; }
"delete"             { return DELETE; }

[0-9]+               { yylval = atoi(yytext); printf("Token: NUMBER\n"); return NUMBER; } // Integers
[0-9]+"."[0-9]+      { yylval = atof(yytext); return FLOAT_LITERAL; } // Floating-point numbers
\"[^\"]*\"           { printf("Token: STRING_LITERAL\n"); return STRING_LITERAL; } // String literals
\'[^\']\'            { return CHAR_LITERAL; } // Char literals

[a-zA-Z_][a-zA-Z0-9_]* { printf("Token: IDENTIFIER\n"); return IDENTIFIER; }

"=="                { return EQ; }
"!="                { return NEQ; }
">="                { return GTE; }
"<="                { return LTE; }
">"                 { return GT; }
"<"                 { return LT; }
"="                 { printf("Token: ASSIGN\n"); return ASSIGN; }
"+"                 { return PLUS; }
"-"                 { return MINUS; }
"*"                 { return MULT; }
"/"                 { return DIV; }
"%"                 { return MOD; }
"&&"                { return AND; }
"||"                { return OR; }
"!"                 { return NOT; }

";"                 { return SEMICOLON; }
","                 { return COMMA; }
"{"                 { return LBRACE; }
"}"                 { return RBRACE; }
"["                 { return LBRACKET; }
"]"                 { return RBRACKET; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"."                 { return DOT; }
"::"                { return SCOPE; }

[ \t\n\r]+          { /* Ignore whitespace */ }
"//".*              { /* Ignore single-line comments */ }
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+"/" {}

.                   { fprintf(stderr, "Error: Invalid character '%s' at line %d\n", yytext, yylineno); exit(1);}

%%

int yywrap() {
    return 1;
}
