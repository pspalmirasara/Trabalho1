%{
#include <stdio.h>
#include <stdlib.h>
#include "ccc_lib.h"

void yyerror(char *c);
int yylex(void);
int erro = 1; //variavel para saber se ha erro

%}

%union 
{
        int number;
        char *string;
}

%token <string> CIDADE_PRESTADOR CIDADE_TOMADOR VALOR_SERVICO VALOR_ISS_RET
%token EOL
%left CIDADE_PRESTADOR CIDADE_TOMADOR VALOR_SERVICO VALOR_ISS_RET

%%

PROGRAMA:
    PROGRAMA EXPRESSAO EOL {
		erro = 0; //se passou por aqui, eh porque nao ha erro
		return 0;
	}
  |
  ;


EXPRESSAO:
	CIDADE_PRESTADOR {
	printf ("Cidade Prestador = [%s]\n", $1);

	}
	;

	| CIDADE_TOMADOR {printf ("Cidade Tomador = [%s]\n", $1);

	}
	;

	| VALOR_SERVICO {printf ("Valor Servico = [%s]\n", $1);

	}
	;

	| VALOR_ISS_RET {printf ("Valor ISS Retido = [%s]\n", $1);

	}
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
