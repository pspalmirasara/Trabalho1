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


%}

PALAVRA [0-9a-zA-ZÇÃ\-\ ]+
NUMERO [0-9]+[,]*[.]*[0-9]*
EMAIL [a-zA-Z0-9.]*@[a-zA-Z0-9.]*

%%

(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<ns3:OrgaoGerador>[ \t\r\n]+<ns3:CodigoMunicipio>{NUMERO}<\/ns3:CodigoMunicipio>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 2);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><Email>{EMAIL}<\/Email><\/Contato><\/Tomador>) { //JOAO MOLENVADE_1

(<ns3:PrestadorServico>[ \t\r\n]*<ns3:IdentificacaoPrestador>[ \t\r\n]*<ns3:CpfCnpj>[ \t\r\n]*(<ns3:Cnpj>{NUMERO}<\/ns3:Cnpj>[ \t\r\n]*)*(<ns3:Cpf>{NUMERO}<\/ns3:Cpf>[ \t\r\n]*)*<\/ns3:CpfCnpj>[ \t\r\n]*<ns3:InscricaoMunicipal>{NUMERO}<\/ns3:InscricaoMunicipal>[ \t\r\n]*<\/ns3:IdentificacaoPrestador>[ \t\r\n]*<ns3:RazaoSocial>{PALAVRA}<\/ns3:RazaoSocial>[ \t\r\n]*<ns3:NomeFantasia>{PALAVRA}<\/ns3:NomeFantasia>[ \t\r\n]*<ns3:Endereco>[ \t\r\n]*<ns3:Endereco>{PALAVRA}<\/ns3:Endereco>[ \t\r\n]*<ns3:Numero>{NUMERO}<\/ns3:Numero>[ \t\r\n]*<ns3:Complemento>{PALAVRA}<\/ns3:Complemento>[ \t\r\n]*<ns3:Bairro>{PALAVRA}<\/ns3:Bairro>[ \t\r\n]*[ \t\r\n]*<ns3:CodigoMunicipio>{NUMERO}<\/ns3:CodigoMunicipio>) { //CORUMBÁ
	retirar_maiorque_e_menorque(yytext, nova_str, 23);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<TOMADOR_CIDADE>{PALAVRA}<\/TOMADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><\/Contato><\/Tomador>) { //JOAO MOLENVADE_2
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_TOMADOR;
}

(<PRESTADOR_CIDADE>{PALAVRA}<\/PRESTADOR_CIDADE>) { //BELÉM
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
}

(<CodigoMunicipio>{NUMERO}<\/CodigoMunicipio><Uf>{PALAVRA}<\/Uf><Cep>{NUMERO}<\/Cep><\/Endereco><Contato><Telefone>{NUMERO}<\/Telefone><Email>{EMAIL}<\/Email><\/Contato><\/PrestadorServico>) { //JOAO MOLENVADE
	retirar_maiorque_e_menorque(yytext, nova_str, 1);
	yylval.string=strdup(nova_str);
	return CIDADE_PRESTADOR;
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


(<ValorServicos>{NUMERO}<\/ValorServicos>) { //JOAO MONLEVADE
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

(<IssRetido>{NUMERO}<\/IssRetido>) { //JOAO MONLEVADE
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
