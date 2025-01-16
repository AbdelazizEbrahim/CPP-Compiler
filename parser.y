%{
#include <iostream>
#include <fstream>
#include <string>
#include <cstdlib>
#include "parser.tab.h"

extern int yylineno;
extern int yylval;
extern FILE *yyin;

void yyerror(const char *s);
int yylex();
%}

%token INT FLOAT DOUBLE BOOLEAN CHAR STRING VOID
%token IF ELSE WHILE FOR BREAK CONTINUE RETURN
%token TRY CATCH CLASS PUBLIC PRIVATE PROTECTED NEW STATIC
%token IDENTIFIER NUMBER FLOAT_LITERAL STRING_LITERAL CHAR_LITERAL
%token PLUS MINUS MULT DIV MOD
%token EQ NEQ GT LT GTE LTE ASSIGN
%token AND OR NOT
%token SEMICOLON COMMA DOT LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET
%token INCLUDE STREAM INSERTION EXTRACTION ENDL
%token PREPROCESSOR_DIRECTIVE NAMESPACE COUT CIN INSERTION_OPERATOR EXTRACTION_OPERATOR SCOPE_RESOLUTION

%left OR
%left AND
%left EQ NEQ
%left GT LT GTE LTE
%left PLUS MINUS
%left MULT DIV MOD
%right NOT
%right UMINUS

%%

program:
    program include_directive
    | program class_declaration
    | program function_definition
    | include_directive
    | class_declaration
    | function_definition
    | PREPROCESSOR_DIRECTIVE program
    | NAMESPACE IDENTIFIER ';' program
    | statement program
    ;

include_directive:
    INCLUDE STRING_LITERAL
    ;

class_declaration:
    access_modifier CLASS IDENTIFIER LBRACE class_body RBRACE
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

function_definition:
    type IDENTIFIER LPAREN parameter_list RPAREN block
    ;

variable_declaration:
    static_modifier type IDENTIFIER SEMICOLON
    | static_modifier type IDENTIFIER ASSIGN expression SEMICOLON
    ;

static_modifier:
    STATIC
    | /* empty */
    ;

type:
    INT | FLOAT | DOUBLE | BOOLEAN | CHAR | STRING | VOID | type LBRACKET RBRACKET
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
    | stream_statement
    | block
    | COUT INSERTION_OPERATOR IDENTIFIER ';'
    | CIN EXTRACTION_OPERATOR IDENTIFIER ';'
    ;

assignment_statement:
    IDENTIFIER ASSIGN expression SEMICOLON
    ;

method_call_statement:
    method_invocation SEMICOLON
    ;

stream_statement:
    STREAM object_chain INSERTION expression ENDL SEMICOLON
    | STREAM expression INSERTION ENDL SEMICOLON
    ;

method_invocation:
    object_chain DOT IDENTIFIER LPAREN argument_list RPAREN
    | IDENTIFIER LPAREN argument_list RPAREN
    ;

object_chain:
    IDENTIFIER
    | object_chain DOT IDENTIFIER
    ;

argument_list:
    argument_list COMMA expression
    | expression
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
    expression PLUS expression         /* Addition */
    | expression MINUS expression      /* Subtraction */
    | expression MULT expression       /* Multiplication */
    | expression DIV expression        /* Division */
    | expression MOD expression        /* Modulus */
    | expression GT expression         /* Greater Than */
    | expression LT expression         /* Less Than */
    | expression GTE expression        /* Greater Than or Equal To */
    | expression LTE expression        /* Less Than or Equal To */
    | expression EQ expression         /* Equal To */
    | expression NEQ expression        /* Not Equal To */
    | expression AND expression        /* Logical AND */
    | expression OR expression         /* Logical OR */
    | NOT expression                   /* Logical NOT */
    | MINUS expression %prec UMINUS    /* Unary minus (e.g., -x) */
    | LPAREN expression RPAREN         /* Parenthesized expressions */
    | IDENTIFIER LPAREN arg_list RPAREN /* Function calls */
    | IDENTIFIER LBRACKET expression RBRACKET /* Array indexing */
    | IDENTIFIER                      /* Variable */
    | NUMBER                          /* Integer literal */
    | FLOAT_LITERAL                   /* Float literal */
    | STRING_LITERAL                  /* String literal */
    | CHAR_LITERAL                    /* Character literal */
    ;

/* Argument list for function calls */
arg_list:
    expression                        /* Single argument */
    | arg_list COMMA expression       /* Multiple arguments */
    | /* Empty argument list */
    ;
%%

void yyerror(const char *s) {
    std::cerr << "Syntax Error: " << s << " at line " << yylineno << std::endl;
}

int main(int argc, char** argv) {
    FILE* input_file = fopen("input_file.txt", "r");
    if (!input_file) {
        perror("Error opening file");
        return 1;
    }
    yyin = input_file;

    if (yyparse() == 0) { // yyparse() returns 0 if parsing is successful
        std::cout << "Parsing completed successfully!" << std::endl;
    }

    fclose(input_file);
    return 0;
}
