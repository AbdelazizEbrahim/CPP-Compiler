# Compiler and flags
CC = g++
CFLAGS = -g -Wall
LEX = flex
BISON = bison
BISONFLAGS = -d

# Files
LEX_FILE = lexer.l
PARSER_FILE = parser.y
LEX_OUTPUT = lex.yy.c
PARSER_OUTPUT_C = parser.tab.c
PARSER_OUTPUT_H = parser.tab.h
EXECUTABLE = compiler

# Targets
all: $(EXECUTABLE)

$(EXECUTABLE): $(LEX_OUTPUT) $(PARSER_OUTPUT_C) $(PARSER_OUTPUT_H)
	$(CC) $(CFLAGS) $(LEX_OUTPUT) $(PARSER_OUTPUT_C) -o $(EXECUTABLE) -lfl

$(LEX_OUTPUT): $(LEX_FILE)
	$(LEX) $(LEX_FILE)

$(PARSER_OUTPUT_C) $(PARSER_OUTPUT_H): $(PARSER_FILE)
	$(BISON) $(BISONFLAGS) $(PARSER_FILE)

clean:
	rm -f $(LEX_OUTPUT) $(PARSER_OUTPUT_C) $(PARSER_OUTPUT_H) $(EXECUTABLE)

# Optional: Add a run command to test the program
run: $(EXECUTABLE)
	./$(EXECUTABLE) input.cpp

.PHONY: all clean run
