%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
extern int yylval;
extern FILE *yyin;

void yyerror(const char *s);
int yylex();
%}

%token INT FLOAT DOUBLE BOOL CHAR VOID
%token IF ELSE WHILE FOR BREAK CONTINUE RETURN
%token CLASS STRUCT PUBLIC PRIVATE PROTECTED NEW DELETE
%token IDENTIFIER NUMBER FLOAT_LITERAL STRING_LITERAL CHAR_LITERAL
%token PLUS MINUS MULT DIV MOD
%token EQ NEQ GT LT GTE LTE ASSIGN
%token AND OR NOT
%token SEMICOLON COMMA DOT SCOPE LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET HASH

%left OR
%left AND
%left EQ NEQ
%left GT LT GTE LTE
%left PLUS MINUS
%left MULT DIV MOD
%right NOT

%%

program:
    program class_declaration
    | class_declaration
    ;

class_declaration:
    access_modifier CLASS IDENTIFIER LBRACE class_body RBRACE
    | access_modifier STRUCT IDENTIFIER LBRACE class_body RBRACE
    ;

access_modifier:
    PUBLIC
    | PRIVATE
    | PROTECTED
    | /* empty */
    ;

class_body:
    class_body member_declaration
    | member_declaration
    ;

member_declaration:
    variable_declaration
    | method_declaration
    ;

variable_declaration:
    static_modifier type IDENTIFIER SEMICOLON
    | static_modifier type IDENTIFIER ASSIGN expression SEMICOLON
    ;

static_modifier:
    /* empty */ // No explicit 'static' modifier in C++ class variables
    ;

type:
    INT | FLOAT | DOUBLE | BOOL | CHAR | VOID | type LBRACKET RBRACKET
    ;

method_declaration:
    access_modifier static_modifier type IDENTIFIER LPAREN parameter_list RPAREN block
    ;

parameter_list:
    parameter_list COMMA parameter
    | parameter
    | /* empty */
    ;

parameter:
    type IDENTIFIER
    ;

block:
    LBRACE block_statements RBRACE
    ;

block_statements:
    block_statements statement
    | statement
    ;

statement:
    variable_declaration
    | assignment_statement
    | if_statement
    | while_statement
    | for_statement
    | return_statement
    | break_statement
    | continue_statement
    | method_call_statement
    | block
    ;

assignment_statement:
    IDENTIFIER ASSIGN expression SEMICOLON
    ;

method_call_statement:
    method_invocation SEMICOLON
    ;

method_invocation:
    object_chain DOT IDENTIFIER LPAREN argument_list RPAREN
    | IDENTIFIER LPAREN argument_list RPAREN
    ;

object_chain:
    IDENTIFIER
    | object_chain DOT IDENTIFIER
    | object_chain SCOPE IDENTIFIER
    ;

argument_list:
    argument_list COMMA expression
    | expression | method_invocation
    | /* empty */
    ;

if_statement:
    IF LPAREN expression RPAREN statement
    | IF LPAREN expression RPAREN statement ELSE statement
    ;

while_statement:
    WHILE LPAREN expression RPAREN statement
    ;

for_statement:
    FOR LPAREN assignment_statement expression SEMICOLON expression RPAREN statement
    ;

return_statement:
    RETURN expression SEMICOLON
    | RETURN SEMICOLON
    ;

break_statement:
    BREAK SEMICOLON
    ;

continue_statement:
    CONTINUE SEMICOLON
    ;

expression:
    expression PLUS expression
    | expression MINUS expression
    | expression MULT expression
    | expression DIV expression
    | expression MOD expression
    | expression GT expression
    | expression LT expression
    | expression GTE expression
    | expression LTE expression
    | expression EQ expression
    | expression NEQ expression
    | expression AND expression
    | expression OR expression
    | NOT expression
    | LPAREN expression RPAREN
    | IDENTIFIER
    | NUMBER
    | FLOAT_LITERAL
    | STRING_LITERAL
    | CHAR_LITERAL
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s at line %d\n", s, yylineno);
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <Main.cpp>\n", argv[0]);
        return 1;
    }

    FILE *input_file = fopen(argv[1], "r");
    if (!input_file) {
        perror("Error opening file");
        return 1;
    }

    yyin = input_file;

    printf("C++ Compiler - Parsing Started\n");
    if (yyparse() == 0) {
        printf("Parsing Completed Successfully\n");
    } else {
        printf("Parsing Failed\n");
    }

    fclose(input_file);
    return 0;
}
