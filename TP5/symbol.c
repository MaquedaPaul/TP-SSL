#include <stdio.h>
#include "scanner.h"
#include "parser.h"
#include "semantic.h"
#include "symbol.h"

#define max 350

char *tablaDeSimbolos[max];
int posicion = 0;

int buscar(char *cadena)
{
    for (int i = 0; i < posicion; i++)
    {
        if (!strcmp(tablaDeSimbolos[i], cadena))
        {
            return 1;
        }
    }
    return 0;
}

void agregar(char *cadena)
{
    if (posicion < max)
    {
        tablaDeSimbolos[posicion] = cadena;
        posicion++;
    }
    else
        printf("\n Se llenó la tabla de símbolos");
}
