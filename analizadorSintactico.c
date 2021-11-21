

#include "analizadorSintactico.h"
#include "analizadorLexico.h"
#include "tablaSimbolos.h"
#include "gestorErrores.h"
#include <stdio.h>
#include <stdlib.h>


void iniciarAnalizadorSintactico(abb * tablaSimbolos, int tamMaxBloque){
    tipoelem E;
    printf("\nLista Componentes Léxicos:\n\n");
    // El analizador sintáctico le pedirá todos los componentes léxicos al analizador léxico
    do{
        // Se genera el siguiente componente léxico
        E = siguienteLexema(tablaSimbolos,tamMaxBloque);
        // Si el componente léxico es el final del documento, se indicará y finalizará la búsqueda
        if(E.componenteLexico == EOF){
            printf("\t   ELEM: %-20s  \t--> CL: %3d\n","EOF",E.componenteLexico);
            printf("\t------------------------------------------------\n");
        }else{
            // Se imprimen los componentes léxicos recibidos
            if(E.componenteLexico == CL_SALTO){
                printf("\t   ELEM: %-20s  \t--> CL: %3d\n","Nueva Linea",E.componenteLexico);
            }else if(E.componenteLexico == CL_TAB) {
                printf("\t   ELEM: %-20s  \t--> CL: %3d\n","Tabulador",E.componenteLexico);
            }else{
                    printf("\t   ELEM: %-20s  \t--> CL: %3d\n",E.lexema,E.componenteLexico);
            }
            printf("\t------------------------------------------------\n");
        }
        //Se libera el lexema previamente reservado en memoria dinámicamente
        free(E.lexema);
    }while(E.componenteLexico!=EOF);
}