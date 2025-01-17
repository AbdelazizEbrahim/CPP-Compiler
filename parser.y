%{
#include <stdio.h>
#include <stdlib.h>
%}

%token INT MAIN RETURN STD COUT ENDL LSHIFT SCOPE LPAREN RPAREN LBRACE RBRACE SEMICOLON NUMBER STRING_LITERAL

%%
program:
    INT MAIN LPAREN RPAREN LBRACE statements RBRACE
    ;

statements:
    statement
    | statements statement
    ;

statement:
    STD SCOPE COUT LSHIFT STRING_LITERAL LSHIFT STD SCOPE ENDL SEMICOLON
    | RETURN NUMBER SEMICOLON
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
