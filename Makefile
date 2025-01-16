# Compiler and tools
CC = gcc
LEX = flex
YACC = yacc

# Flags
CFLAGS = -g -Wall
YACC_FLAGS = -d
LEX_FLAGS = 

# Files
LEX_FILE = lexer.l
YACC_FILE = parser.y
TARGET = compiler

# Generated files
LEX_OUTPUT = lex.yy.c
YACC_OUTPUT = y.tab.c y.tab.h

# Default rule
all: $(TARGET)

# Compile the parser first (yacc/bison)
$(YACC_OUTPUT): $(YACC_FILE)
	$(YACC) $(YACC_FLAGS) $(YACC_FILE)

# Compile the lexer second (flex)
$(LEX_OUTPUT): $(LEX_FILE)
	$(LEX) $(LEX_FILE)

# Compile the final program
$(TARGET): $(YACC_OUTPUT) $(LEX_OUTPUT)
	$(CC) $(CFLAGS) $(LEX_OUTPUT) y.tab.c -o $(TARGET) -lfl

# Clean rule to remove generated files
clean:
	rm -f $(TARGET) $(LEX_OUTPUT) $(YACC_OUTPUT)
