%{
#include "parser.tab.h"
#include <stdio.h>
%}

%%

"int"          { printf("Token: INT\n"); return INT; }
"main"         { printf("Token: MAIN\n"); return MAIN; }
"return"       { printf("Token: RETURN\n"); return RETURN; }
"std"          { printf("Token: STD\n"); return STD; }
"cout"         { printf("Token: COUT\n"); return COUT; }
"endl"         { printf("Token: ENDL\n"); return ENDL; }
"<<"           { printf("Token: LSHIFT\n"); return LSHIFT; }
"::"           { printf("Token: SCOPE\n"); return SCOPE; }
"+"            { printf("Token: PLUS\n"); return PLUS; }
"("            { printf("Token: LPAREN\n"); return LPAREN; }
")"            { printf("Token: RPAREN\n"); return RPAREN; }
"{"            { printf("Token: LBRACE\n"); return LBRACE; }
"}"            { printf("Token: RBRACE\n"); return RBRACE; }
"<<"           { printf("Token: LSHIFT\n"); return LSHIFT; }
"::"           { printf("Token: SCOPE\n"); return SCOPE; }
"0"            { printf("Token: NUMBER\n"); return NUMBER; }
";"            { printf("Token: SEMICOLON\n"); return SEMICOLON; }
","            { printf("Token: COMMA\n"); return COMMA; }
"="            { printf("Token: ASSIGN\n"); return ASSIGN; }
[0-9]+         { printf("Token: NUMBER (%s)\n", yytext); return NUMBER; }
[A-Za-z_][A-Za-z0-9_]* { printf("Token: IDENTIFIER (%s)\n", yytext); return IDENTIFIER; }
\"[^\"]*\"           { printf("Token: STRING_LITERAL\n"); return STRING_LITERAL; } // String literals
[ \t\n\r]+     { /* Ignore whitespace */ }
"//".*         { /* Ignore single-line comments */ }
.              { printf("Unknown token: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}