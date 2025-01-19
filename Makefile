# Compiler and flags
CC = g++
FLEX = flex
BISON = bison
CFLAGS = -lfl -std=c++11

# Source files
LEX_FILE = lexer.l
BISON_FILE = parser.y
LEX_OUT = lex.yy.c
BISON_OUT = parser.tab.c
EXECUTABLE = parser

# Default rule: build and run
all: build run

# Rule to build lexer and parser
build: $(LEX_OUT) $(BISON_OUT)
	$(CC) $(BISON_OUT) $(LEX_OUT) -o $(EXECUTABLE) $(CFLAGS)

# Rule to generate lex.yy.c
$(LEX_OUT): $(LEX_FILE)
	$(FLEX) $(LEX_FILE)

# Rule to generate parser.tab.c (and parser.tab.h if needed)
$(BISON_OUT): $(BISON_FILE)
	$(BISON) -d $(BISON_FILE)

# Rule to run the parser with input
run:
	@echo "Running the parser..."
	./$(EXECUTABLE) < main.cpp

# Clean up generated files
clean:
	rm -f $(LEX_OUT) $(BISON_OUT) parser.tab.h $(EXECUTABLE)

# Phony targets
.PHONY: all build run clean
