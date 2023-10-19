%{
#include <string.h>    
#include <stdio.h>
#include <stdlib.h>

void print_token(const char* token_text, const char* token_description) {
    printf("%-20s  %s \n", token_text, token_description );
}
%}

%option case-insensitive    
%option noyywrap  

%%

[\t \n \r] ;  // Caracteres en blanco y saltos de línea

(int|char|float|double|bool|void) {
    print_token(yytext, "Tipo de Dato");
}

"if" {
    print_token(yytext, "Palabra Reservada");
}

[a-zA-Z][a-zA-Z0-9_]* {
    print_token(yytext, "Identificador");
}

[0-9]+(\.[0-9]+)? {
    print_token(yytext, "Número");
}

"=" {
    print_token(yytext, "Asignación");
}

("=="|"<"|">"|"<="|">=") {
    print_token(yytext, "Comparación");
}

";" {
    print_token(yytext, "Fin de Instrucción");
}

[\{\}\[\]\(\)] {
    print_token(yytext, "Símbolo AGRUPACION");
}

[-+*/] {
    print_token(yytext, "Operador Aritmético");
}

. {
    fprintf(stderr, "Caracter no reconocido: %s\n", yytext);
}

%%

int main() {
    yylex(); // Inicia el análisis léxico.
    return 0;
}
