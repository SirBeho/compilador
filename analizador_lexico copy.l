%{
#include <stdio.h>
%}

%option noyywrap

DIGITO   [0-9]
LETRA    [a-zA-Z]
NUMERO   {DIGITO}+
OPERADOR [+*-/]
IDENTIFICADOR {LETRA}(({LETRA}|{DIGITO}|_)*)

%}

%token <num_val> NUMERO
%token <str_val> IDENTIFICADOR
%token <str_val> OPERADOR
%token <str_val> SIGNO_NEGATIVO
%token NUMERO_DECIMAL
%token <str_val> SIMBOLO_ASIGNACION
%token <str_val> SIMBOLO_PARENTESIS
%token <str_val> SIMBOLO_COMPARACION

%%

(int|char|float|double|bool|void) {
    yylval.str_val = strdup(yytext); // Almacena la palabra reservada en yylval
    return PALABRA_RESERVADA;
}

(for|while|do) {
    yylval.str_val = strdup(yytext); // Almacena la palabra reservada en yylval
    return PALABRA_RESERVADA;
}

(return|break|continue|switch|case|default) {
    yylval.str_val = strdup(yytext); // Almacena la palabra reservada en yylval
    return PALABRA_RESERVADA;
}

(if|else|elseif) {
    yylval.str_val = strdup(yytext); // Almacena la palabra reservada en yylval
    return PALABRA_RESERVADA;
}

{IDENTIFICADOR} {
    yylval.str_val = strdup(yytext); // Almacena el identificador en yylval
    return IDENTIFICADOR;
}

{NUMERO} {
    yylval.num_val = atoi(yytext); // Convierte el número en un valor entero y almacénalo en yylval
    return NUMERO;
}

- {
    return SIGNO_NEGATIVO; // Token para el signo negativo
}

{NUMERO}\.{NUMERO} {
    yylval.str_val = strdup(yytext); // Almacena el número decimal en yylval
    return NUMERO_DECIMAL;
}

[+*-/] {
    yylval.str_val = strdup(yytext); // Almacena el operador en yylval
    return OPERADOR;
}

[=] {
    yylval.str_val = strdup(yytext); // Almacena el símbolo de asignación en yylval
    return SIMBOLO_ASIGNACION;
}

[><=] {
    yylval.str_val = strdup(yytext); // Almacena el símbolo de comparación en yylval
    return SIMBOLO_COMPARACION;
}

[(|)] {
    yylval.str_val = strdup(yytext); // Almacena el símbolo de paréntesis en yylval
    return SIMBOLO_PARENTESIS;
}

...

[ \t\n] {
    // Ignorar espacios en blanco y saltos de línea
}

. {
    yylval.str_val = strdup(yytext); // Almacena cualquier carácter no reconocido en yylval
    return yytext[0];
}

%%
