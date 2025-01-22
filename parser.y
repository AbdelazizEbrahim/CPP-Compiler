%{
#include <stdio.h>
#include <stdlib.h>
#include "semantic_analysis.h" // Include the semantic analysis header
#include "symbol_table.h" // Include the symbol table header

extern int yylineno;
extern int yylval;
extern FILE *yyin;

void yyerror(const char *s);
int yylex();

// Declare an instance of SemanticAnalysis
SemanticAnalysis semanticAnalysis;
%}

%token INT FLOAT DOUBLE BOOLEAN CHAR STRING STDSTRING VOID CONST
%token IF ELSE WHILE FOR BREAK CONTINUE RETURN DO
%token TRY CATCH CLASS PUBLIC PRIVATE PROTECTED NEW STATIC
%token IDENTIFIER NUMBER STRING_LITERAL CHAR_LITERAL
%token INCREMENT DECREMENT PLUS MINUS MULT DIV MOD ERROR 
%token EQ NEQ GT LT GTE LTE ASSIGN DEFAULT CASE SWITCH CIN
%token AND OR NOT
%token SEMICOLON COLON COMMA DOT LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET HASH
%token MAIN STD SCOPE COUT LSHIFT ENDL RSHIFT

%left OR
%left AND
%left EQ NEQ
%left GT LT GTE LTE
%left PLUS MINUS
%left MULT DIV MOD
%right NOT

%%

// Grammar rules
program:
    includes main_program
    ;

includes:
    includes include_statement
    | include_statement
    ;

include_statement:
    HASH IDENTIFIER LT IDENTIFIER GT
    ;

main_program:
    main_function
    | function_declarations main_function function_declarations
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
    | RETURN expression SEMICOLON {
        semanticAnalysis.checkReturnType(std::to_string($2));
    }
    | function_call_statement
    | INCREMENT IDENTIFIER SEMICOLON
    | DECREMENT IDENTIFIER SEMICOLON
    | IDENTIFIER INCREMENT SEMICOLON
    | IDENTIFIER DECREMENT SEMICOLON
    | includes
    ;

variable_declaration:
    type variable_initializations SEMICOLON {
        semanticAnalysis.checkVariableDeclaration(std::to_string($2), std::to_string($1));
    }
    ;

variable_initializations:
    variable_initialization
    | variable_initializations COMMA variable_initialization
    ;

variable_initialization:
    IDENTIFIER
    | IDENTIFIER ASSIGN expression
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON {
        semanticAnalysis.checkVariableUsage(std::to_string($1));
    }
    | IDENTIFIER PLUS ASSIGN expression SEMICOLON {
        semanticAnalysis.checkVariableUsage(std::to_string($1));
    }
    | IDENTIFIER MINUS ASSIGN expression SEMICOLON {
        semanticAnalysis.checkVariableUsage(std::to_string($1));
    }
    ;

if_statement:
    IF LPAREN expression RPAREN statement optional_else
    | IF LPAREN expression RPAREN LBRACE statements RBRACE optional_else
    ;

optional_else:
    ELSE if_statement
    | ELSE LBRACE statements RBRACE
    | ELSE statement
    | 
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
    | INCREMENT IDENTIFIER  
    | DECREMENT IDENTIFIER  
    | IDENTIFIER INCREMENT 
    | IDENTIFIER DECREMENT 
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
    INT | FLOAT | DOUBLE | BOOLEAN | CHAR | STRING | VOID | STDSTRING | CONST
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
    STD SCOPE CIN cin_inputs SEMICOLON
    ;

cin_inputs:
    RSHIFT IDENTIFIER
    | cin_inputs RSHIFT IDENTIFIER
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
    IDENTIFIER LPAREN argument_list RPAREN SEMICOLON {
        semanticAnalysis.checkFunctionCall(std::to_string($1));
    }
    ;

argument_list:
    argument
    | argument_list COMMA argument
    |
;

argument:
    expression
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}

