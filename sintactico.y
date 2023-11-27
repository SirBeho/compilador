%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int yylex(void);

int yyerror(const char *msg) {
    fprintf(stderr, "Error sintáctico: %s\n", msg);
    return 1;
}

// Declaración de la estructura Token - analisis lexico
#define MAX_TOKENS 1000

typedef struct {
    char* type;
    char* value;
} Token;

Token tokens[MAX_TOKENS];
int num_tokens = 0;

void add_token(char* type, char* value) {
    if (num_tokens < MAX_TOKENS) {
        tokens[num_tokens].type = type;
        tokens[num_tokens].value = strdup(value);
        num_tokens++;
    }
}


void print_tokens() {
    printf("\"lexico\":[");
    for (int i = 0; i < num_tokens; i++) {
        printf("{\"type\": \"%s\", \"value\": \"%s\"}", tokens[i].type, tokens[i].value);
        if (i < num_tokens - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}




//definicion token de sintaxis analisis sintactico

#define MAX_SYNTAX_TOKENS 1000

typedef struct {
    char* type;
} SyntaxToken;

SyntaxToken syntax_tokens[MAX_SYNTAX_TOKENS];
int num_syntax_tokens = 0;

void add_syntax_token(char* type) {
    if (num_syntax_tokens < MAX_SYNTAX_TOKENS) {
        syntax_tokens[num_syntax_tokens].type = strdup(type);
        num_syntax_tokens++;
    }
}

void print_syntax_tokens() {
    printf("\,\"sintactico\":[");
    for (int i = 0; i < num_syntax_tokens; i++) {
        printf("{\"type\": \"%s\"}", syntax_tokens[i].type);
        if (i < num_syntax_tokens - 1) {
            printf(", ");
        }
    }
    printf("]\n");
}

%}



%union {
    char* str; // Definir una estructura que coincida con la del analizador léxico
}
%token <str> TIPO_DE_DATO ASIGNACION COMPARACION FIN
%token <str>  IDENTIFICADOR NUMERO PALABRA_RESERVADA 
%token SIMBOLO_ASIGNACION OPERADOR SIGNO_NEGATIVO
%left '+' '-'
%left '*' '/'
%right '^'


%%

programa: sentencia FIN
       | programa sentencia FIN
       ;


sentencia: expresion 
         | declaracion
         | asignacion
         | instruccion
         | comparacion
         | funcion
         ;

instruccion: PALABRA_RESERVADA '(' comparacion ')' '{' programa '}'  { add_syntax_token("INSTRUCCION"); }  
        | PALABRA_RESERVADA '(' expresion ')' '{' programa '}' { add_syntax_token("INSTRUCCION"); }  
 ;

funcion: IDENTIFICADOR '(' ')' { add_syntax_token("FUNCION"); }
    |  IDENTIFICADOR '(' ')' '{' programa '}' { add_syntax_token("FUNCION"); }
 ;
        
declaracion: TIPO_DE_DATO IDENTIFICADOR { add_syntax_token("DECLARACION"); }
        | TIPO_DE_DATO asignacion {  add_syntax_token("DECLARACION"); }
        | TIPO_DE_DATO funcion {  add_syntax_token("DECLARACION"); }
;

asignacion: IDENTIFICADOR SIMBOLO_ASIGNACION expresion { add_syntax_token("ASIGNACION"); }
;


comparacion: expresion COMPARACION expresion { add_syntax_token("COMPARACION"); }

;

expresion: termino '+'  expresion   {  add_syntax_token("SUMA");}
         | termino '-' expresion {  add_syntax_token("RESTA");}
         | termino
         ;

termino: termino '*' factor  {  add_syntax_token("MULTIPLICAION");}
       | termino '/' factor  {  add_syntax_token("DIVISION");}
       | factor
       ;

factor: NUMERO {  add_syntax_token("NUMERO");}
      | IDENTIFICADOR       {  add_syntax_token("IDENTIFICADOR");}
      | '(' expresion ')'   
      | '-' factor   {  add_syntax_token("NEGATIVO");}
      ;

%%


