# Makefile for building the C++ compiler

# Compiler and flags
CC = gcc
CFLAGS = -Wall -g

# Files
LEXER = lexer.l
PARSER = parser.y
SEMANTIC = semantic.c
EXECUTABLE = compiler

# Generated files
LEXER_OUTPUT = lex.yy.c
PARSER_OUTPUT = parser.tab.c
PARSER_HEADER = parser.tab.h

# Targets
all: $(EXECUTABLE)

$(EXECUTABLE): $(LEXER_OUTPUT) $(PARSER_OUTPUT) $(SEMANTIC)
	$(CC) $(CFLAGS) -o $@ $(LEXER_OUTPUT) $(PARSER_OUTPUT) $(SEMANTIC) -ll

$(LEXER_OUTPUT): $(LEXER)
	flex $<

$(PARSER_OUTPUT): $(PARSER)
	bison -d $<

clean:
	rm -f $(EXECUTABLE) $(LEXER_OUTPUT) $(PARSER_OUTPUT) $(PARSER_HEADER)

# Phony targets
.PHONY: all clean
