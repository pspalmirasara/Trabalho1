
%{
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
void yyerror(char *);

#include "y.tab.h"
// <PRESTADOR_CIDADE>BELEM</PRESTADOR_CIDADE>
// <TOMADOR_CIDADE>CANAA DOS CARAJAS</TOMADOR_CIDADE>
// <VALOR_SERVICO>38223,48</VALOR_SERVICO>
// <VALOR_ISS_RET>0</VALOR_ISS_RET>

%}

PALAVRA [a-zA-Z\ ]+
NUMERO [0-9]+[,]*[0-9]*
%%

(<PRESTADOR_CIDADE>{PALAVRA}<\/PRESTADOR_CIDADE>) {
	printf("reconheceu a string: [%s]\n", yytext);
	return CIDADE_PRESTADOR;
}

(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) {
	printf("reconheceu a string: [%s]\n", yytext);
	return CIDADE_TOMADOR;
}

(<VALOR_SERVICO>{NUMERO}<\/VALOR_SERVICO>) {
	printf("reconheceu a string: [%s]\n", yytext);
	return VALOR_SERVICO;
}

(<VALOR_ISS_RET>{NUMERO}<\/VALOR_ISS_RET>) {
	printf("reconheceu a string: [%s]\n", yytext);
	return VALOR_ISS_RET;
}

\n {
  return EOL;
}

[ \t] ;

.	{
	yyerror("Token nao reconhecido!\n");
}

%%

int yywrap() {
  return 1;
}
