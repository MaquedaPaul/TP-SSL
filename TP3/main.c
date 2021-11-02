/*Datos del grupo
Apellido Nombres - Legajo

Maqueda Pablo David - 1762620
Bruno Juan Pablo    - 1768920
GonzalezRiverol Camila - 1745663

*/

#include "scanner.h"
int TOKEN;
char *token_names[] = {"Fin de archivo", "Programa", "Leer", "Entero", "Escribir", "Asignacion", "Identificador", "Constante"};

int main()
{
    do
    {
        TOKEN = yylex();
        if (TOKEN <= ASIGNACION)
        {
            printf("Token: %s\n", token_names[TOKEN]);
        }
        else if (TOKEN == IDENTIFICADOR || TOKEN == CONSTANTE)
        {

            printf("Token: %s\tlexema: %s\n", token_names[TOKEN], yytext);
        }
        else
        {

            printf("Token: \'%c\'\n", TOKEN);
        }
    } while (TOKEN != FDT);

    return EXIT_SUCCESS;
}
