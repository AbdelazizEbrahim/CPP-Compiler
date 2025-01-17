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
"("            { printf("Token: LPAREN\n"); return LPAREN; }
")"            { printf("Token: RPAREN\n"); return RPAREN; }
"{"            { printf("Token: LBRACE\n"); return LBRACE; }
"}"            { printf("Token: RBRACE\n"); return RBRACE; }
";"            { printf("Token: SEMICOLON\n"); return SEMICOLON; }
[0-9]+         { printf("Token: NUMBER (%s)\n", yytext); return NUMBER; }
\"[^\"]*\"     { printf("Token: STRING_LITERAL (%s)\n", yytext); return STRING_LITERAL; }
[ \t\n\r]+     { /* Ignore whitespace */ }
"//".*         { /* Ignore single-line comments */ }
.              { printf("Unknown token: %s\n", yytext); }


%%
