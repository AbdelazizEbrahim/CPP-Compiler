CC = gcc
LEX = flex
YACC = bison
CFLAGS = -g

all: compiler

compiler: lexer.c parser.tab.c main.o
	$(CC) -o compiler lexer.c parser.tab.c main.o -lfl

lexer.c: lexer.l
	$(LEX) -o lexer.c lexer.l

parser.tab.c: parser.y
	$(YACC) -d parser.y

main.o: main.c
	$(CC) $(CFLAGS) -c main.c

clean:
	rm -f *.o lexer.c parser.tab.c parser.tab.h compiler
