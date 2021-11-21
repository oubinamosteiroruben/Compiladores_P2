%{
    #include <stdio.h>
    #include <stdlib.h>

    #include "definiciones.h"

    int numLineas = 1;
%}

%x COMENTARIOCOMILLASDOBLES
%x COMENTARIOCOMILLASSIMPLES

DIGITO [0-9]
FLOATNUM {POINTFLOAT}|{EXPONENTFLOAT}
POINTFLOAT  ({DIGITO})*{FRACTION}|({DIGITO})+[.]
EXPONENTFLOAT ({DIGITO}*|{POINTFLOAT}){EXPONENT}
FRACTION [.]({DIGITO})+
EXPONENT (e|E)[+|-]?({DIGITO})+

INTEGER {BININTEGER}|{HEXINTEGER}|{OCTINTEGER}|{DECINTEGER}
BININTEGER [0](b|B)[0-1]+
HEXINTEGER [0](x|X)[0-9a-zA-Z]+
OCTINTEGER [0](o|O)[0-7]+
DECINTEGER [1-9]{DIGITO}*|"0"

OPERADORESSIMPLES ["\+"|"\-"|"\*"|"\/"|"\%"|"\@"|"\&"|"\|"|"\^"|"\~"|"\<"|"\>"]
DELIMITADORESSIMPLES ["\("|"\)"|"\["|"\]"|"\{"|"\}"|"\,"|"\:"|"\."|"\;"|"\="]

OPERADORESDOBLES "**"|"//"|"<<"|">>"|":="|"<="|">="|"=="|"!="
DELIMITADORESDOBLES "->"|"+="|"-="|"*="|"/="|"%="|"@="|"&="|"|="|"^="
DELIMITADORESTRIPLES "//="|">>="|"<<="|"**="

COMENTARIOALMOHADILLA ("#")[^\n]*

ESPACIO " "

CADENACOMILLAS (\")[^(\")]*(\")|(\')[^(\')]*(\')
IDENTIFICADOR [a-zA-Z_][a-zA-Z0-9_]*

SALTOLINEA "\n"
TABULADOR "\t"

%%

{INTEGER} {return CL_NUM_ENTERO;}
{OPERADORESSIMPLES} {return CL_OP_SIMPLE;}
{DELIMITADORESSIMPLES} {return CL_DEL_SIMPLE;}
{FLOATNUM} {return CL_NUM_FLOAT;}
{OPERADORESDOBLES} {return CL_OP_DOBLE;}
{DELIMITADORESDOBLES} {return CL_DEL_DOBLE;}
{DELIMITADORESTRIPLES} {return CL_DEL_TRIPLE;}
{IDENTIFICADOR} {return CL_ID;}
{CADENACOMILLAS} {return CL_CADENA;}
{SALTOLINEA} {numLineas++; return CL_SALTO;}
{TABULADOR} {return CL_TAB;}
{COMENTARIOALMOHADILLA} {return CL_COMENTARIOALMOHADILLA;}
<<EOF>> {return EOF;}

{ESPACIO} {}



"\'\'\'" yymore(); BEGIN(COMENTARIOCOMILLASSIMPLES);               
<COMENTARIOCOMILLASSIMPLES>[^(\'\'\'')^\n]* yymore();
<COMENTARIOCOMILLASSIMPLES>\n numLineas++; yymore();
<COMENTARIOCOMILLASSIMPLES>"\'\'\'" BEGIN(INITIAL); return CL_COMENTARIO; 


"\"\"\"" yymore(); BEGIN(COMENTARIOCOMILLASDOBLES);               
<COMENTARIOCOMILLASDOBLES>[^(\"\"\")^\n]* yymore();
<COMENTARIOCOMILLASDOBLES>\n numLineas++; yymore();
<COMENTARIOCOMILLASDOBLES>"\"\"\"" BEGIN(INITIAL); return CL_COMENTARIO; 
%% 

