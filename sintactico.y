%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int yylex(void);
int yyerror(const char *msg) {
    fprintf(stderr, "Error sintáctico: %s\n", msg);
    return 1;
}

// Declaración de la estructura Token
typedef struct {
    char* token_type;
} Token;

Token* tokens = NULL;
int num_tokens = 0;

void print_tokens() {
    for (int i = 0; i < num_tokens; i++) {
        printf("Token Type: %s\n", tokens[i].token_type);
    }
}

void add_token(const char* type) {
    num_tokens++;
    tokens = (Token*)realloc(tokens, num_tokens * sizeof(Token));
    tokens[num_tokens - 1].token_type = strdup(type);
}

void remove_last_token() {
    if (num_tokens > 0) {
        num_tokens--;
        tokens = (Token*)realloc(tokens, num_tokens * sizeof(Token));
    }
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

instruccion: PALABRA_RESERVADA '(' comparacion ')' '{' programa '}'  { add_token("INTRUCCION"); }  
        | PALABRA_RESERVADA '(' expresion ')' '{' programa '}' { add_token("INTRUCCION"); }  
 ;

funcion: IDENTIFICADOR '(' ')' { add_token("FUNCION"); }
    |  IDENTIFICADOR '(' ')' '{' programa '}' { add_token("FUNCION"); }
 ;
        
declaracion: TIPO_DE_DATO IDENTIFICADOR { add_token("DECLARACION"); }
        | TIPO_DE_DATO asignacion {  add_token("DECLARACION"); }
        | TIPO_DE_DATO funcion {  add_token("DECLARACION"); }
;

asignacion: IDENTIFICADOR SIMBOLO_ASIGNACION expresion { add_token("ASIGNACION"); }
;


comparacion: expresion COMPARACION expresion { add_token("COMPARACION"); }

;

expresion: termino '+'  expresion   {  add_token("SUMA");}
         | termino '-' expresion {  add_token("RESTA");}
         | termino
         ;

termino: termino '*' factor  {  add_token("MULTIPLICAION");}
       | termino '/' factor  {  add_token("DIVISION");}
       | factor
       ;

factor: NUMERO {  add_token("NUMERO");}
      | IDENTIFICADOR       {  add_token("IDENTIFICADOR");}
      | '(' expresion ')'   
      | '-' factor   {  add_token("NEGATIVO");}
      ;

%%


