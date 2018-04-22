%{

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "y.tab.h"

//Declaração de variáveis
char nova_str[200];
void yyerror(char *);
char entrada[200], saida[200];
int tam_str;
int k; //indice da saida

//Funções
void retirar_maiorque_e_menorque(char *entrada, char *saida, int numeroDeTags){
	//Declaração de variáveis
	int tam_str, k, tagsEncontradas;

	//Limpando a saida
	for (int j=0; j<200; j++){
		saida[j] = '\0';
	}

	//Inicializando as variáveis
	tagsEncontradas = 0;
	tam_str = strlen(entrada);

	//Varre a entrada
	for (int i=0; i<tam_str; i++){
		//Se encontra o fim de uma tag
		if (entrada[i] == '>'){
			tagsEncontradas++;
			//Se já abriu tags o suficiente pra pegar o conteúdo
			if(tagsEncontradas == numeroDeTags){
				i++;
				k = 0;
				//Copia o conteúdo até achar a abertura da tag de fechar
				while (entrada[i] != '<'){
					saida[k] = entrada[i];
					i++;
					k++;
				}
				break;
			}
		}
	}
	return;
}


//<CodigoMunicipio>3127701</CodigoMunicipio><Uf>MG</Uf><Cep>35010330</Cep></Endereco><Contato><Telefone>3155032400</Telefone></Contato></Tomador>
//<CodigoMunicipio>3136207</CodigoMunicipio><Uf>MG</Uf><Cep>35930074</Cep></Endereco><Contato><Telefone>3138521111</Telefone><Email>
//<ValorServicos>4124.00</ValorServicos>
//<IssRetido>1</IssRetido>



%}

PALAVRA [a-zA-Z\ ]+
NUMERO [0-9]+[,]*[.]*[0-9]*

%%

(<PRESTADOR_CIDADE>{PALAVRA}<\/PRESTADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<ns3:OrgaoGerador>[ \t\r\n]+<ns3:CodigoMunicipio>{NUMERO}<\/ns3:CodigoMunicipio>) { //CORUMBÁ
			retirar_maiorque_e_menorque(yytext, nova_str, 2);
			yylval.string=strdup(nova_str);
			return CIDADE_TOMADOR;
}

(<VALOR_SERVICO>{NUMERO}<\/VALOR_SERVICO>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<ns3:ValorServicos>{NUMERO}<\/ns3:ValorServicos>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_SERVICO;
}

(<VALOR_ISS_RET>{NUMERO}<\/VALOR_ISS_RET>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}

(<ns3:IssRetido>{NUMERO}<\/ns3:IssRetido>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return VALOR_ISS_RET;
}




. ;

[ \t\r\n] ;

<<EOF>> {
	return EOL;
}

%%

int yywrap() {
  return 1;
}
