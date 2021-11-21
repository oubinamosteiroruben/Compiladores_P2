
#include "analizadorLexico.h"
#include "abb.h"
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdio.h>

#include "definiciones.h"
#include "tablaSimbolos.h"
#include "gestorErrores.h"

#include "lex.yy.c"


// Función que carga devuelve un nuevo lexema
tipoelem  siguienteLexema(abb * tablaSimbolos, int tamMaxBloque){
    tipoelem  E;
    E.componenteLexico = yylex();
    E.lexema =  strdup(yytext);
    // Si se trata de un identificador y no está en la tabla, se insertará una copia de este
    if(E.componenteLexico == CL_ID ){
        tipoelem EAux;
        if(es_miembro(*tablaSimbolos,E)){
            buscar_nodo(*tablaSimbolos,E.lexema,&EAux);
            E.componenteLexico = EAux.componenteLexico;
        }else {
            EAux.lexema = strdup(E.lexema);
            EAux.componenteLexico = E.componenteLexico;
            insertarPalabra(EAux,tablaSimbolos);
        }
    }
    return E;
}

void abrirArchivoFlex(char * nombreArchivo){
    FILE * fd = fopen(nombreArchivo,"r");
    if(fd){
        yyin = fd;
    }else{
        nuevoError(-1,3,"",'\0');
        exit(1);
    }
}

void cerrarArchivoFlex(){
    fclose(yyin);
    yylex_destroy();
}

