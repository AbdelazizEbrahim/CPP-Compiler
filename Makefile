# Compiler and flags
CC = gcc
FLEX = flex
BISON = bison
CFLAGS = -Wall -g
LDFLAGS = -lfl

# Files
LEXER = lexer.l
PARSER = parser.y
LEXER_C = lexer.c
PARSER_C = parser.c
PARSER_H = parser.h
EXECUTABLE = parser

# Targets
all: $(EXECUTABLE)

$(EXECUTABLE): $(LEXER_C) $(PARSER_C)
	$(CC) $(CFLAGS) -o $(EXECUTABLE) $(PARSER_C) $(LEXER_C) $(LDFLAGS)

$(LEXER_C): $(LEXER) $(PARSER_H)
	$(FLEX) -o $(LEXER_C) $(LEXER)

$(PARSER_C) $(PARSER_H): $(PARSER)
	$(BISON) -d -o $(PARSER_C) $(PARSER)

clean:
	rm -f $(LEXER_C) $(PARSER_C) $(PARSER_H) $(EXECUTABLE)
