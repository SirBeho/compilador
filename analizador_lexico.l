%{
#include <stdio.h>
%}

%option noyywrap

%%

(for|while|if|true|false|else|case|break) {
    printf("%s Palabras reservadas o claves\n", yytext);
}

[a-z]+ {
    printf("%s Es una Constante\n", yytext);
}

[1-9][0-9]* {
    printf("%s Numero\n", yytext);
}

bin[01]+ {
    printf("%s Binario\n", yytext);
}

[*] {
    printf("%s Multiplicacion\n", yytext);
}

[+] {
    printf("%s Suma\n", yytext);
}

[-] {
    printf("%s Menos\n", yytext);
}

[/] {
    printf("%s Division\n", yytext);
}

[(){}] {
    printf("%s Delimitador\n", yytext);
}

[;,] {
    printf("%s Puntuacion\n", yytext);
}

[<>=] {
    printf("%s Operador de Comparacion\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("%s Identificador\n", yytext);
}

.|\n {
    // Ignorar caracteres no reconocidos
}

%%

int main() {
    yylex();
    return 0;
}
