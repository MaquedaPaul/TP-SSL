%code top{
	#include <stdio.h>
	#include "scanner.h"
}

%code provides {
	void yyerror(const char *);
	extern int erroreslexicos;
	extern int yynerrs;
}

%define api.value.type{char *}

%defines "parser.h"					
%output "parser.c"

%start programa
%define parse.error verbose

%token FDT PROGRAMA LEER ENTERO ESCRIBIR IDENTIFICADOR CONSTANTE
%token ASIGNACION "<<"


%left  '-'  '+'   
%left  '*'  '/'  '%'
%precedence NEG

%%
programa :				PROGRAMA IDENTIFICADOR listaSentencias FDT			{if (yynerrs || erroreslexicos) YYABORT;}
					;

listaSentencias :		sentencia 
					| 	sentencia listaSentencias
					;

sentencia :				                            

						ENTERO IDENTIFICADOR';'				        {printf("entero %s\n", $IDENTIFICADOR);}
					|	IDENTIFICADOR ASIGNACION expresion';'		{printf("asignación \n");}
                    |	ESCRIBIR'('listaExpresiones')'';'			{printf("escribir\n");} 
					|   LEER'('listaIdentificadores')'';'	        {printf("leer\n");} 
                    |   error ';'
					;

listaExpresiones :		expresion
				    | 	expresion','listaExpresiones
					;

listaIdentificadores :	IDENTIFICADOR 								
					| 	IDENTIFICADOR','listaIdentificadores
					;


						
expresion:			  	valor
			        | 	'-'valor %prec NEG							{printf("inversion\n");}
                   	| 	'('expresion')' 							{printf("paréntesis\n");}
                    | 	expresion '+' expresion 					{printf("suma\n");}
                  	| 	expresion '-' expresion 					{printf("resta\n");}
                   	| 	expresion '*' expresion 					{printf("multiplicación\n");}
                  	| 	expresion '/' expresion 					{printf("division\n");}
                    |   expresion '%' expresion                     {printf("modulo\n");}
					;
                        
valor :					IDENTIFICADOR
					|	CONSTANTE
					;
%%

int erroreslexicos = 0;

void yyerror(const char *s){
		printf("línea #%d  %s\n", yylineno, s);
}














