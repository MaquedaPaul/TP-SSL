#ifndef SEMANTIC_H_INCLUDED
#define SEMANTIC_H_INCLUDED

void comenzar(char *nombreprog);
void terminar(void);
void asignar(char *resultado, char *identificador);
void leer(char *identificador);
void escribir(char *identificador);
int procesarID(char *identificador);
char *genInfijo(char *e1, char op, char *e2);
char *genUnario(char *entrada);
void generarAccion(char *OP, char *A, char *B, char *C);
int declararEntero(char *identificador, int bytes);
char *generarTemporal(void);

#endif