%{
#include "parser.tab.h"
#include <stdio.h>
%}

%{
#include <stdio.h> 
#include <stdlib.h>
%}

%token INT MAIN RETURN STD COUT ENDL LSHIFT SCOPE LPAREN RPAREN LBRACE RBRACE SEMICOLON PLUS NUMBER STRING_LITERAL ASSIGN IDENTIFIER COMMA

%%

program:
    INT MAIN LPAREN RPAREN LBRACE statements RBRACE
    ;

statements:
    statement
    | statements statement
    ;

statement:
    declaration
    | assignment
    | print_statement
    | RETURN NUMBER SEMICOLON
    ;

declaration:
    INT IDENTIFIER ASSIGN NUMBER SEMICOLON
    | INT IDENTIFIER ASSIGN NUMBER COMMA IDENTIFIER ASSIGN NUMBER SEMICOLON  
    ;

assignment:
    IDENTIFIER ASSIGN NUMBER SEMICOLON
    | IDENTIFIER ASSIGN NUMBER COMMA IDENTIFIER ASSIGN NUMBER SEMICOLON  
    | IDENTIFIER ASSIGN IDENTIFIER PLUS IDENTIFIER SEMICOLON             
    ;


print_statement:
    STD SCOPE COUT LSHIFT output_value LSHIFT STD SCOPE ENDL SEMICOLON
    ;

output_value:
    STRING_LITERAL
    | IDENTIFIER
    | output_value LSHIFT STRING_LITERAL
    | output_value LSHIFT IDENTIFIER
    ;
%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    yyparse();
    return 0;
}
