%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(char *c);
int yylex(void);
int erro = 1; //variavel para saber se ha erro

%}

%token CIDADE_PRESTADOR CIDADE_TOMADOR VALOR_SERVICO VALOR_ISS_RET EOL
%left CIDADE_PRESTADOR

%%

PROGRAMA:
    PROGRAMA EXPRESSAO EOL {
		erro = 0; //se passou por aqui, eh porque nao ha erro
		return 0;
	}
  |
  ;


EXPRESSAO:
  |
  ;

%%

void yyerror(char *s) {
}

int main() {

	yyparse();

	if (erro == 1){
		printf ("ERRO\n");
	}else{
		printf ("OK\n");
	}
	return 0;

}
