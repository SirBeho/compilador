%{
#include <stdio.h>
extern int yylex();
%}

%token PALABRA_RESERVADA IDENTIFICADOR OPERADOR
%token NUMERO NUMERO_DECIMAL SIMBOLO_ASIGNACION SIGNO_NEGATIVO
%left '<' '>' EQ NEQ LTE GTE
%left '+' '-'
%left '*' '/'

%%

programa: sentencia
       | programa sentencia
       ;

sentencia: asignacion
         | expresion
         | estructura_if
         | estructura_while
         ;

asignacion: IDENTIFICADOR SIMBOLO_ASIGNACION expresion
          ;

estructura_if: PALABRA_RESERVADA '(' expresion ')' sentencia
             | PALABRA_RESERVADA '(' expresion ')' sentencia PALABRA_RESERVADA sentencia
             ;

estructura_while: PALABRA_RESERVADA '(' expresion ')' sentencia
                ;

expresion: expresion '+' termino
         | expresion '-' termino
         | termino
         ;

termino: termino '*' factor
       | termino '/' factor
       | factor
       ;

factor: NUMERO
      | NUMERO_DECIMAL
      | IDENTIFICADOR
      | PALABRA_RESERVADA
      | '(' expresion ')'
      | OPERADOR factor
      | SIGNO_NEGATIVO factor
      ;

%%

int main() {
    yyparse(); // Inicia el análisis sintáctico
    return 0;
}

int yyerror(char *msg) {
    fprintf(stderr, "Error: %s\n", msg);
    return 0;
}
