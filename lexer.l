%{
#include "parser.tab.h"
#include <iostream>
#include <cstdlib>  // For atoi and atof
#include <cstring> // For string manipulation
%}

%%

#.*                  { std::cout << "Token: PREPROCESSOR_DIRECTIVE\n"; return PREPROCESSOR_DIRECTIVE; }
"include"            { std::cout << "Token: INCLUDE\n"; return INCLUDE; }

"int"                { std::cout << "Token: INT\n"; return INT; }
"float"              { return FLOAT; }
"double"             { return DOUBLE; }
"bool"               { return BOOLEAN; }
"char"               { return CHAR; }
"string"             { return STRING; }
"void"               { return VOID; }
"if"                 { return IF; }
"else"               { return ELSE; }
"while"              { return WHILE; }
"for"                { return FOR; }
"break"              { return BREAK; }
"continue"           { return CONTINUE; }
"return"             { return RETURN; }
"try"                { return TRY; }
"catch"              { return CATCH; }
"class"              { std::cout << "Token: CLASS\n"; return CLASS; }
"namespace"          { std::cout << "Token: NAMESPACE\n"; return NAMESPACE; }
"public"             { std::cout << "Token: PUBLIC\n"; return PUBLIC; }
"private"            { return PRIVATE; }
"static"             { std::cout << "Token: STATIC\n"; return STATIC; }
"protected"          { return PROTECTED; }
"new"                { return NEW; }

"std::cout"          { std::cout << "Token: COUT\n"; return COUT; }
"std::cin"           { std::cout << "Token: CIN\n"; return CIN; }
"<<"                 { std::cout << "Token: INSERTION_OPERATOR\n"; return INSERTION_OPERATOR; }
">>"                 { std::cout << "Token: EXTRACTION_OPERATOR\n"; return EXTRACTION_OPERATOR; }

[0-9]+               { yylval = std::stoi(yytext); std::cout << "Token: NUMBER\n"; return NUMBER; } // Integers
[0-9]+"."[0-9]+      { yylval = std::stof(yytext); return FLOAT_LITERAL; } // Floating-point numbers
\"[^\"]*\"           { std::cout << "Token: STRING_LITERAL\n"; return STRING_LITERAL; } // String literals
\'[^\']\'            { return CHAR_LITERAL; } // Char literals

[a-zA-Z_][a-zA-Z0-9_]* { std::cout << "Token: IDENTIFIER\n"; return IDENTIFIER; }

"=="                { return EQ; }
"!="                { return NEQ; }
">="                { return GTE; }
"<="                { return LTE; }
">"                 { return GT; }
"<"                 { return LT; }
"="                 { std::cout << "Token: ASSIGN\n"; return ASSIGN; }
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
"::"                { return SCOPE_RESOLUTION; }

[ \t\n\r]+          { /* Ignore whitespace */ }
"//".*              { /* Ignore single-line comments */ }
"/*"([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+"/" { /* Ignore multi-line comments */ }

.                   { std::cerr << "Error: Invalid character '" << yytext << "' at line " << yylineno << std::endl; exit(1); }

%%

int yywrap() {
    return 1;
}
