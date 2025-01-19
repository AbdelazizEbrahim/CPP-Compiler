%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
extern int yylval;
extern FILE *yyin;

void yyerror(const char *s);
int yylex();
%}

%token INT FLOAT DOUBLE BOOLEAN CHAR STRING STDSTRING VOID
%token IF ELSE WHILE FOR BREAK CONTINUE RETURN DO
%token TRY CATCH CLASS PUBLIC PRIVATE PROTECTED NEW STATIC
%token IDENTIFIER NUMBER STRING_LITERAL CHAR_LITERAL
%token PLUS MINUS MULT DIV MOD ERROR
%token EQ NEQ GT LT GTE LTE ASSIGN DEFAULT CASE SWITCH CIN
%token AND OR NOT
%token SEMICOLON COLON COMMA DOT LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET
%token MAIN STD SCOPE COUT LSHIFT ENDL RSHIFT

%left OR
%left AND
%left EQ NEQ
%left GT LT GTE LTE
%left PLUS MINUS
%left MULT DIV MOD
%right NOT

%%

program:
    main_function
    | function_declarations main_function additional_function_declarations
;

main_function:
    type MAIN LPAREN RPAREN LBRACE statements RBRACE
;

statements:
    statement
    | statements statement
    ;

statement:
    variable_declaration
    | assignment
    | print_statement
    | cin_statement
    | switch_statement
    | if_statement
    | for_loop
    | while_loop
    | do_while_loop
    | RETURN expression SEMICOLON
    | function_call_statement
    ;

variable_declaration:
    type variable_list SEMICOLON
    | type variable_list ASSIGN expression SEMICOLON
    ;

variable_list:
    IDENTIFIER
    | variable_list COMMA IDENTIFIER
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON
    | IDENTIFIER PLUS ASSIGN expression SEMICOLON
    ;

if_statement:
    IF LPAREN expression RPAREN LBRACE statements RBRACE optional_else
    ;

optional_else:
    ELSE LBRACE statements RBRACE
    | /* empty */
    ;

for_loop:
    FOR LPAREN optional_expression SEMICOLON optional_expression SEMICOLON optional_expression RPAREN LBRACE statements RBRACE
    ;

while_loop:
    WHILE LPAREN expression RPAREN LBRACE statements RBRACE
    ;

do_while_loop:
    DO LBRACE statements RBRACE WHILE LPAREN expression RPAREN SEMICOLON
    ;

optional_expression:
    expression
    | 
    ;

expression:
    expression binary_operator expression
    | NOT expression
    | LPAREN expression RPAREN
    | IDENTIFIER
    | type IDENTIFIER ASSIGN expression
    | IDENTIFIER ASSIGN expression
    | NUMBER
    | float_literal
    | STRING_LITERAL
    | CHAR_LITERAL
    | IDENTIFIER LPAREN argument_list RPAREN
    ;

float_literal:
    digits DOT digits   
    ;

digits:
    NUMBER  
    ;


binary_operator:
    PLUS | MINUS | MULT | DIV | MOD | GT | LT | GTE | LTE | EQ | NEQ | AND | OR
    ;

type:
    INT | FLOAT | DOUBLE | BOOLEAN | CHAR | STRING | VOID
    ;

print_statement:
    STD SCOPE COUT LSHIFT output_values SEMICOLON
    ;

output_values:
    output_values LSHIFT output_value
    | output_value
    ;

output_value:
    STRING_LITERAL
    | IDENTIFIER
    | NUMBER
    | STD SCOPE ENDL
    | expression
    ;

cin_statement:
    STD SCOPE CIN RSHIFT IDENTIFIER SEMICOLON
    ;

switch_statement:
    SWITCH LPAREN IDENTIFIER RPAREN LBRACE case_statements default_statement RBRACE
    ;

case_statements:
    case_statements case_statement
    | case_statement
    ;

case_statement:
    CASE case_label COLON statements optional_break
    ;

optional_break:
    BREAK SEMICOLON
    | /* empty */
    ;

case_label:
    NUMBER
    | CHAR_LITERAL
    | STRING_LITERAL
    ;

default_statement:
    DEFAULT COLON statements
    | 
    ;

function_declarations:
    function_declaration
    | function_declarations function_declaration
    | 
;

additional_function_declarations:
    function_declaration
    | additional_function_declarations function_declaration
    | 
;

function_declaration:
    type IDENTIFIER LPAREN parameters RPAREN LBRACE statements RBRACE
    | type IDENTIFIER LPAREN parameters RPAREN SEMICOLON
;

parameters:
    parameter_list
    | 
;

parameter_list:
    parameter
    | parameter_list COMMA parameter
;

parameter:
    type IDENTIFIER
;

function_call_statement:
    IDENTIFIER LPAREN argument_list RPAREN SEMICOLON
;

argument_list:
    argument
    | argument_list COMMA argument
;

argument:
    expression
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}

int main() {
    if (yyparse() == 0) { 
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}
