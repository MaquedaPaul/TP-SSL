#include <stdio.h>
#include <string.h>
#include "parser.h"
#include "semantic.h"
#include "symbol.h"

int numeroTemporal = 1;
int erroresSemanticos = 0;
char buffer[200];
char temp[30];

void generarAccion(char *operador, char *A, char *B, char *C)
{
    if (!strcmp(C, ""))
    {
        printf("%s %s,%s\n", operador, A, B);
    }
    else if (!strcmp(B, ""))
    {
        printf("%s %s,,%s\n", operador, A, C);
    }
    else
    {
        printf("%s %s,%s,%s\n", operador, A, B, C);
    }
}

void comenzar(char *nombreprog)
{
    generarAccion("Load", "rtlib", nombreprog, "");
}

void terminar(void)
{
    generarAccion("Exit", "", "", "");
}

void asignar(char *resultado, char *identificador)
{
    generarAccion("Store", resultado, identificador, "");
}

void leer(char *identificador)
{
    generarAccion("Read", identificador, "Integer", "");
}

void escribir(char *identificador)
{
    generarAccion("Write", identificador, "Integer", "");
}

int procesarID(char *identificador)
{

    if (!buscar(identificador))
    {
        erroresSemanticos++;
        sprintf(buffer, "Error semántico: identificador %s NO declarado", identificador);
        yyerror(buffer);
        return 1;
    }
    return 0;
}

char *genInfijo(char *e1, char operador, char *e2)
{
    char *nuevoTemporal = generarTemporal();
    declararEntero(nuevoTemporal, 4);

    switch (operador)
    {
    case '+':
        generarAccion("ADD", e1, e2, nuevoTemporal);
        break;
    case '-':
        generarAccion("SUB", e1, e2, nuevoTemporal);
        break;
    case '*':
        generarAccion("MUL", e1, e2, nuevoTemporal);
        break;
    case '/':
        generarAccion("DIV", e1, e2, nuevoTemporal);
        break;
    case '%':
        generarAccion("MOD", e1, e2, nuevoTemporal);
        break;
    }

    return nuevoTemporal;
}

char *genUnario(char *entrada)
{
    char *nuevoTemporal = generarTemporal();
    declararEntero(nuevoTemporal, 4);
    generarAccion("INV", entrada, "", nuevoTemporal);
    return nuevoTemporal;
}

int declararEntero(char *identificador, int bytes)
{
    if (buscar(identificador))
    {
        sprintf(buffer, "Error semántico: identificador %s ya declarado", identificador);
        erroresSemanticos++;
        yyerror(buffer);
        return 1;
    }
    else
    {
        agregar(identificador);
        printf("Reserve %s,%d\n", identificador, bytes);
        return 0;
    }
}

char *generarTemporal(void)
{
    sprintf(temp, "Temp@%d", numeroTemporal);
    numeroTemporal++;
    return strdup(temp);
}