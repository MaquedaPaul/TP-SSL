/*Datos del grupo
Apellido Nombres - Legajo

Maqueda Pablo David - 1762620
Bruno Juan Pablo    - 1768920
Gonzalez Riverol Camila - 1774566

*/

#include <stdio.h>
#include "parser.h"

int main(void)
{
    switch (yyparse())
    {
    case 0:
        printf("\nCompilacion terminada con exito");
        break;
    case 1:
        printf("\nErrores de compilacion");
        break;
    case 2:
        printf("\nNo hay memoria suficiente");
        break;
    }
    printf("\nErrores sintacticos:  %d - Errores lexicos:  %d\n - Errores Semanticos: %d\n", yynerrs, erroreslexicos, erroresSemanticos);

    return 0;
}
