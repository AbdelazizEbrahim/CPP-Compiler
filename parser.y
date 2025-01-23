%{
#include <stdio.h>
#include <stdlib.h>

extern int yylineno;
extern FILE *yyin;

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s at line %d\n", s, yylineno);
}
int yylex();

struct variable_list {
    char **names; // Array of variable names
    int count;    // Count of variables
};
%}

%union {
    int number;             // For numeric tokens
    char *string;           // For string-based tokens (e.g., IDENTIFIER)
    struct variable_list *variable_list; // For variable lists
}

%token INT FLOAT DOUBLE BOOLEAN CHAR STRING STDSTRING VOID
%token IF ELSE WHILE FOR BREAK CONTINUE RETURN DO
%token TRY CATCH CLASS PUBLIC PRIVATE PROTECTED NEW STATIC
%token IDENTIFIER NUMBER STRING_LITERAL CHAR_LITERAL HASH
%token INCREMENT DECREMENT PLUS MINUS MULT DIV MOD ERROR 
%token EQ NEQ GT LT GTE LTE ASSIGN DEFAULT CASE SWITCH CIN
%token AND OR NOT
%token SEMICOLON COLON COMMA DOT LBRACE RBRACE LPAREN RPAREN LBRACKET RBRACKET
%token MAIN STD SCOPE COUT LSHIFT ENDL RSHIFT

%type <variable_list> variable_list
%type <string> type
%type <string> expression
%token <string> IDENTIFIER

%left OR
%left AND
%left EQ NEQ
%left GT LT GTE LTE
%left PLUS MINUS
%left MULT DIV MOD
%right NOT

%%

program:
    includes main_program
    ;

includes:
    includes include_statement
    | include_statement
    |
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
    | RETURN expression SEMICOLON
    | function_call_statement
    | INCREMENT IDENTIFIER SEMICOLON
    | DECREMENT IDENTIFIER SEMICOLON
    | IDENTIFIER INCREMENT SEMICOLON
    | IDENTIFIER DECREMENT SEMICOLON
    ;

variable_declaration:
    type variable_list SEMICOLON {
        struct variable_list *vars = $2; // Correct type
        for (int i = 0; i < vars->count; i++) {
            if (!semantic_insert_symbol(vars->names[i], $1)) {
                yyerror("Variable redeclared");
                // Free all allocated memory and exit
                for (int j = 0; j < vars->count; j++) {
                    free(vars->names[j]);
                }
                free(vars->names);
                free(vars);
                YYABORT;
            }
            free(vars->names[i]); // Free the allocated memory for the name
        }
        free(vars->names);
        free(vars); // Free the variable_list structure
    }
    | type variable_list ASSIGN expression SEMICOLON {
        struct variable_list *vars = $2; // Correct type
        for (int i = 0; i < vars->count; i++) {
            if (!semantic_insert_symbol(vars->names[i], $1)) {
                yyerror("Variable redeclared");
                // Free all allocated memory and exit
                for (int j = 0; j < vars->count; j++) {
                    free(vars->names[j]);
                }
                free(vars->names);
                free(vars);
                YYABORT;
            }
            // Check type consistency between variable type and expression type
            if (!semantic_check_type($1, $4)) {
                yyerror("Type mismatch in initialization");
                // Free all allocated memory and exit
                for (int j = 0; j < vars->count; j++) {
                    free(vars->names[j]);
                }
                free(vars->names);
                free(vars);
                YYABORT;
            }
            free(vars->names[i]); // Free the allocated memory for the name
        }
        free(vars->names);
        free(vars); // Free the variable_list structure
    }
    ;

variable_list:
    IDENTIFIER {
        $$ = malloc(sizeof(struct variable_list)); // Allocate memory for the structure
        if (!$$) { // Check for malloc failure
            yyerror("Memory allocation failed");
            YYABORT;
        }
        $$->names = malloc(sizeof(char *));
        if (!$$->names) { // Check for malloc failure
            free($$);
            yyerror("Memory allocation failed");
            YYABORT;
        }
        if (!$1) { // Ensure $1 is valid
            free($$->names);
            free($$);
            yyerror("Invalid IiDENTFIER");
            YYABORT;
        }
        $$->names[0] = strdup($1);                // Copy the variable name
        if (!$$->names[0]) { // Check for strdup failure
            free($$->names);
            free($$);
            yyerror("Memory allocation failed");
            YYABORT;
        }
        $$->count = 1;                            // Single variable in the list
    }
    | variable_list COMMA IDENTIFIER {
        char **new_names = realloc($1->names, sizeof(char *) * ($1->count + 1));
        if (!new_names) { // Check for realloc failure
            for (int i = 0; i < $1->count; i++) {
                free($1->names[i]);
            }
            free($1->names);
            free($1);
            yyerror("Memory allocation failed");
            YYABORT;
        }
        $1->names = new_names;
        $1->names[$1->count] = strdup($3);        // Copy the new variable name
        if (!$1->names[$1->count]) { // Check for strdup failure
            for (int i = 0; i < $1->count; i++) {
                free($1->names[i]);
            }
            free($1->names);
            free($1);
            yyerror("Memory allocation failed");
            YYABORT;
        }
        $1->count += 1;                           // Increment the variable count
        $$ = $1;                                  // Propagate the updated list
    }
    ;

assignment:
    IDENTIFIER ASSIGN expression SEMICOLON {
        const char *value_type = $3; // Type returned from `expression`
        if (!semantic_check_type($1, value_type))
        {
            YYABORT;
        }
    }
    | IDENTIFIER PLUS ASSIGN expression SEMICOLON {
        const char *value_type = $4; // Type returned from `expression`
        if (!semantic_check_type($1, "+", value_type))
        {
            YYABORT;
        }
    }
    | IDENTIFIER MINUS ASSIGN expression SEMICOLON {
        const char *value_type = $4; // Type returned from `expression`
        if (!semantic_check_type($1, "-", value_type))
        {
            YYABORT;
        }
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
    INT | FLOAT | DOUBLE | BOOLEAN | CHAR | STRING | VOID | STDSTRING
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
    |
;

argument:
    expression
;

%%

int main() {
    if (yyparse() == 0) { 
        printf("Parsing completed successfully.\n");
    } else {
        printf("Parsing failed.\n");
    }
    return 0;
}


