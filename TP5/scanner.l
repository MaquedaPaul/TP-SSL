%top{
	#include <stdio.h>
	#include "parser.h"	
}



%{
	int erroreslexicos;
	char mensaje[120];
%}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput
%option nounput
%option yylineno

Letra														[[:alpha:]]
Digito														[0-9]
Letra_Digito												[[:alnum:]]
Espacio														[[:space:]]
OperadorAsignacion											"<<"
Comentario													"//".*
Otros														[[:punct:]]{-}[();,+%\-*/]


%%
programa 													return PROGRAMA;
leer														return LEER;
escribir													return ESCRIBIR;
fin-programa														    return FDT;
entero														return ENTERO;
{Letra}{Letra_Digito}*									    {yylval = strdup	(yytext); return IDENTIFICADOR;}
{Digito}+													return CONSTANTE;
"("															return '(';
")"															return ')';
","															return ',';
"+"															return '+';
"-"															return '-';
"*"															return '*';
"%"															return '%';
"/"															return '/';
";"															return ';';
{OperadorAsignacion} 										return ASIGNACION;
{Otros}+													{erroreslexicos++; sprintf(mensaje, "Error léxico: cadena desconocida: %s", yytext)     ; yyerror(mensaje);}
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*		{erroreslexicos++; sprintf(mensaje, "Error léxico: identificador inválido: %s", yytext) ; yyerror(mensaje);}
{Digito}+{Letra}+{Letra_Digito}*							{erroreslexicos++; sprintf(mensaje, "Error léxico: constante inválida: %s", yytext)     ; yyerror(mensaje);}
{Espacio}+													|
{Comentario}												;
%%
