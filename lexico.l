%{
#include <string.h>    
#include <stdio.h>
#include <stdlib.h>
#include "sintactico.tab.h"

void add_token(char* type, char* value);
int yyparse(void);

void print_tokens();
void print_syntax_tokens();

%}

%option case-insensitive
%option noyywrap  



%%

[\t \n \r] ;

(int|char|float|double|bool|void) {
   add_token("TIPO_DE_DATO", yytext);
    yylval.str = strdup(yytext);
    return TIPO_DE_DATO;
}


"if" {
   add_token("PALABRA_RESERVADA", yytext);
 yylval.str = strdup(yytext);  
    return PALABRA_RESERVADA;
}

[a-zA-Z][a-zA-Z0-9_]* {
   add_token("IDENTIFICADOR", yytext);
 yylval.str = strdup(yytext);  
    return IDENTIFICADOR;
}


[0-9]+(\.[0-9]+)? {
   add_token("NUMERO", yytext);
 yylval.str = strdup(yytext);  
    return NUMERO;
}

"=" {
  add_token("SIMBOLO_ASIGNACION", yytext);
 yylval.str = strdup(yytext); 
    return SIMBOLO_ASIGNACION;
}


("=="|"<"|">"|"<="|">=") {
  add_token("COMPARACION", yytext);
 yylval.str = strdup(yytext); 
    return COMPARACION;
}

";" {
    add_token("FIN", yytext);
    yylval.str = strdup(yytext);
    return FIN;  
}


[\{\}\[\]\(\)] {
   add_token(*yytext, yytext);
 yylval.str = strdup(yytext); 
    return *yytext; 
}

[-+*/] {
    add_token(*yytext, yytext);
    yylval.str = strdup(yytext); 
    return *yytext;  
}

. {
    fprintf(stderr, "Caracter no reconocido: %s\n", yytext);
}

%%



int main() {
    
    yyparse();
    printf("\{");
    print_tokens();
    print_syntax_tokens();
    
     printf("\}");
    return 0;
}

