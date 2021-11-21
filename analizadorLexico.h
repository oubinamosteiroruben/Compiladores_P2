

#ifndef PRACTICA2_ANALIZADORLEXICO_H
#define PRACTICA2_ANALIZADORLEXICO_H

#include "abb.h"
#include "definiciones.h"
#include "gestorErrores.h"

#define True 1
#define False 0

/**
 *
 * @param tablaSimbolos :
 * @return devuelve un elemento en el que se encuentra un lexema e información acerca de este
 */
tipoelem siguienteLexema(abb * tablaSimbolos, int tamMaxBloque);
void abrirArchivoFlex(char * nombreArchivo);
void cerrarArchivoFlex();

#endif //PRACTICA2_ANALIZADORLEXICO_H
