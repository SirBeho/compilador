%{
#include <stdio.h>
%}

DIGITO   [0-9]
LETRA    [a-zA-Z]
NUMERO   {DIGITO}+
OPERADOR [+*-/]
IDENTIFICADOR {LETRA}(({LETRA}|{DIGITO}|_)*)

%%

(int|char|float|double|bool|void) {
    printf("Palabra-reservada\n", yytext, yytext);
}

(for|while|do) {
    printf("Palabra-reservada\n", yytext, yytext);
}

(return|break|continue|switch|case|default) {
    printf("Palabra-reservada\n", yytext, yytext);
}

(if|else|elseif) {
    printf("Palabra-reservada\n", yytext, yytext);
}


main {
    printf("Funcion-principal\n", yytext);
}

{IDENTIFICADOR} {
    printf("Identificador\n", yytext);
}

{NUMERO} {
    printf("Numero\n", yytext, yytext);
}

{NUMERO}\.{NUMERO} {
    printf("Numero-decimal\n", yytext, yytext);
}

-?{NUMERO} {
    printf("Número negativo\n", yytext, yytext);
}

-?{NUMERO}\.{NUMERO} {
    printf("Numero-decimal-negativo\n", yytext, yytext);
}

\+ {
    printf("suma\n", yytext);
}

\++ {
    printf("incremento\n", yytext);
}

\- {
    printf("resta\n", yytext);
}


\-- {
    printf("decremento\n", yytext);
}

\* {
    printf("multiplicacion\n", yytext);
}

\/ {
   printf("division\n", yytext);
}


\% {
    printf("modulo\n", yytext);
}

! {
    printf("NOT\n", yytext);
}

\{ {
    printf("A-llave: \n", yytext);
}

\} {
    printf("B-llave:\n", yytext);
}

\[ {
    printf("Símbolo de apertura de corchete\n", yytext);
}

\] {
    printf("Símbolo de cierre de corchete \n", yytext);
}

\( {
    printf("Símbolo de apertura de paréntesis\n", yytext);
}

\) {
    printf("Símbolo de cierre de paréntesis \n", yytext);
}

= {
    printf("asignacion \n", yytext);
}

== {
    printf("comparacion: \n", yytext);
}

!= {
    printf("comparacion: \n", yytext);
}

[ \t\n] {
    // Ignorar espacios en blanco y saltos de línea
}

. {
    printf("Carácter no reconocido\n", yytext);
}

%%

int main() {
    yylex();
    return 0;
}
