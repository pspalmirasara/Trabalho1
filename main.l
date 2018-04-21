%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
//#include "ccc_lib.h"
#include "y.tab.h"

char nova_str[200];

void yyerror(char *);



char entrada[200], saida[200];
int tam_str;
int k; //indice da saida
void retirar_maiorque_e_menorque(char *entrada, char *saida){
	int tam_str;
	int k; //indice da saida

	tam_str = strlen(entrada);

	for (int i=0; i<tam_str; i++){
		if (entrada[i] == '>'){
			i++;
			k = 0;
			while (entrada[i] != '<'){
				saida[k] = entrada[i];
				i++;
				k++;
			}
			break;
		}
	}

	return;
}


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

	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) {
	printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<VALOR_SERVICO>{NUMERO}<\/VALOR_SERVICO>) {
	printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<VALOR_ISS_RET>{NUMERO}<\/VALOR_ISS_RET>) {
	printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
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
