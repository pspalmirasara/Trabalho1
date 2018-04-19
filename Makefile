all: lex.yy.c y.tab.c
	gcc -omainz lex.yy.c y.tab.c -ll

lex.yy.c:main.l y.tab.c
	lex main.l

y.tab.c:main.y
	bison -dy main.y

clean:
	rm y.tab.c lex.yy.c y.tab.h main
