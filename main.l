%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

char nova_str[200];

void yyerror(char *);

//Funcao para tratar os XML de BELEM
char entrada[200], saida[200];
int tam_str;
int k; //indice da saida
void retirar_maiorque_e_menorque(char *entrada, char *saida){

	//Limpando a de saida
	for (int j=0; j<200; j++){
		saida[j] = '\0';
	}
	k = 0;

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


//Funcao para achar o numero do municipio

// <PRESTADOR_CIDADE>BELEM</PRESTADOR_CIDADE>
// <TOMADOR_CIDADE>CANAA DOS CARAJAS</TOMADOR_CIDADE>
// <VALOR_SERVICO>38223,48</VALOR_SERVICO>
// <VALOR_ISS_RET>0</VALOR_ISS_RET>


//<CodigoMunicipio>3127701</CodigoMunicipio><Uf>MG</Uf><Cep>35010330</Cep></Endereco><Contato><Telefone>3155032400</Telefone></Contato></Tomador>
//<CodigoMunicipio>3136207</CodigoMunicipio><Uf>MG</Uf><Cep>35930074</Cep></Endereco><Contato><Telefone>3138521111</Telefone><Email>
//<ValorServicos>4124.00</ValorServicos>
//<IssRetido>1</IssRetido>



%}

PALAVRA [a-zA-Z\ ]+
NUMERO [0-9]+[,]*[.]*[0-9]*
%%


(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) {
	//printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<PRESTADOR_CIDADE>{PALAVRA}<\/PRESTADOR_CIDADE>) {
	//printf("reconheceu a string: [%s]\n", yytext);

	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<VALOR_SERVICO>{NUMERO}<\/VALOR_SERVICO>) {
	//printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<VALOR_ISS_RET>{NUMERO}<\/VALOR_ISS_RET>) {
	//printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}






(<ValorServicos>{NUMERO}<\/ValorServicos>) {
	//printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<IssRetido>{NUMERO}<\/IssRetido>) {
	//printf("reconheceu a string: [%s]\n", yytext);
	retirar_maiorque_e_menorque(yytext, nova_str);

	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}




. ;

[ \t\r\n] ;


<<EOF>> {
	//printf("Fim de Linha\n");
	return EOL;
}

%%

int yywrap() {
  return 1;
}
