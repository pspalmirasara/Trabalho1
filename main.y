%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void yyerror(char *c);
int yylex(void);
char strings_printar[4][200]; //Serao usadas para printar na ordem pedida ao final do programa

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
		return 0;
	}
  |
  ;


EXPRESSAO:
	CIDADE_PRESTADOR {
		strcpy (strings_printar[1], $1);
		}

	| CIDADE_TOMADOR {
		strcpy (strings_printar[0], $1);
		}

	| VALOR_SERVICO {
		strcpy (strings_printar[2], $1);
		}

	| VALOR_ISS_RET {
		strcpy (strings_printar[3], $1);
		}



	| EXPRESSAO CIDADE_PRESTADOR {
		strcpy (strings_printar[1], $2);
		}

	| EXPRESSAO CIDADE_TOMADOR {
		strcpy (strings_printar[0], $2);
		}

	| EXPRESSAO VALOR_SERVICO {
		strcpy (strings_printar[2], $2);
		}

	| EXPRESSAO VALOR_ISS_RET {
		strcpy (strings_printar[3], $2);
		}
	;


%%

void yyerror(char *s) {
}

int main() {

	yyparse();

	printf("\"%s\", \"%s\", \"%s\", \"%s\"\n", strings_printar[0], strings_printar[1], strings_printar[2], strings_printar[3]);

	return 0;

}
