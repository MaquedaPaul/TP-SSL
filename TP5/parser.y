%code top{
	#include <stdio.h>
	#include "scanner.h"
	#include "semantic.h"
	#include "symbol.h"
}

%code provides {
	void yyerror(const char *);
	extern int erroreslexicos;
	extern int yynerrs;
	extern int erroresSemanticos;
}

%defines "parser.h"					
%output "parser.c"


%define api.value.type{char *}
%define parse.error verbose

%start programa


%token FDT PROGRAMA LEER ENTERO ESCRIBIR IDENTIFICADOR CONSTANTE
%token ASIGNACION "<<"


%left  '-'  '+'   
%left  '*'  '/'  '%'
%precedence NEG

%%
programa :				 PROGRAMA IDENTIFICADOR {comenzar($2);} listaSentencias FDT {terminar();}				{if (yynerrs || erroreslexicos || erroresSemanticos) YYABORT; else YYACCEPT;}
					;

listaSentencias :		%empty
					| 	sentencia listaSentencias
					;

sentencia :				                            

						ENTERO IDENTIFICADOR';'				        {if (declararEntero($2,4)) YYERROR;}
					|	identificador "<<"expresion';'		{asignar($3,$1);}
                    |	ESCRIBIR'('listaExpresiones')'';'			
					|   LEER'('listaIdentificadores')'';'	        
                    |   error ';'
					;

listaExpresiones :		expresion {escribir($1);}
				    | 	listaExpresiones','expresion {escribir($3);}
					;

listaIdentificadores :	identificador 	{leer($1);}							
					| 	listaIdentificadores','identificador {leer($3);}
					;


						
expresion:			  	valor
			        | 	'-'valor %prec NEG							{$$ = genUnario($2);}
                   	| 	'('expresion')' 							{$$ = $2;}
                    | 	expresion '+' expresion 					{$$ = genInfijo($1, '+', $3);}
                  	| 	expresion '-' expresion 					{$$ = genInfijo($1, '-', $3);}
                   	| 	expresion '*' expresion 					{$$ = genInfijo($1, '*', $3);}
                  	| 	expresion '/' expresion 					{$$ = genInfijo($1, '/', $3);}
                    |   expresion '%' expresion                     {$$ = genInfijo($1, '%', $3);}
					;
                        
valor :					identificador
					|	CONSTANTE
					;
identificador			: IDENTIFICADOR										{if(procesarID($1)) YYERROR;}
						;
%%

int erroreslexicos = 0;

void yyerror(const char *mensaje){
		printf("línea #%d  %s\n", yylineno, mensaje);
}














