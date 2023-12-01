%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>

int yylex(void);
void add_syntax_token(char* type);

void yyerror(char *s) {
    add_syntax_token("ERROR DE SINTAXIS");
}

//------------------Manejo de errores------------------------
#define MAX_ERRORS 1000
typedef struct {
    char* message;
} Error;

Error error_messages[MAX_ERRORS];
int num_errors = 0;

void add_error_message(char* message) {
    if (num_errors < MAX_ERRORS) {
        error_messages[num_errors].message = strdup(message);
        num_errors++;
    }
}

void print_error_messages() {
    printf(",\"errores\": [");
    for (int i = 0; i < num_errors; i++) {
        printf("\"%s\"", error_messages[i].message);
        if (i < num_errors - 1) {
            printf(", ");
        }
    }
    printf("]");
}



// ---------------Declaración de la estructura Token - analisis lexico--------------------
#define MAX_TOKENS 1000

typedef struct {
    char* tipo;
    char* identificador;
    char* valor;
} EntradaTablaSimbolos;

#define MAX_SIMBOLOS 1000
EntradaTablaSimbolos tabla_simbolos[MAX_SIMBOLOS];
int num_simbolos = 0;


int es_tipo_compatible(char* tipo_dato, char* valor) {
    if (strcmp(tipo_dato, "int") == 0 || strcmp(tipo_dato, "float") == 0) {
        // Verificar si valor es un número

        char* end;
        strtod(valor, &end);
        return end != valor && *end == '\0';
        
    } else if (strcmp(tipo_dato, "char") == 0) {
        // Verificar si valor es una cadena
        int longitud = strlen(valor);
        if (longitud >= 2 && strncmp(valor, "'", 1) == 0 && strncmp(valor + longitud - 1, "'", 1) == 0) {
            return 1;
        } else {
            return 0;
        }
    } else if (strcmp(tipo_dato, "bool") == 0) {
        // Verificar si valor es "verdadero" o "falso"
        return strcmp(valor, "0") == 0 || strcmp(valor, "1") == 0;
    }else {
        // Tipo de dato desconocido
        return 1;
    }
}

int buscar_indice_simbolo(char* identificador) {
    for (int i = 0; i < num_simbolos; i++) {
        if (strcmp(tabla_simbolos[i].identificador, identificador) == 0) {
            return i;
        }
    }
    return -1;
}

void agregar_valor(char *identificador, char* valor) {
    int indice = buscar_indice_simbolo(identificador);
    if (indice == -1) {
        char error_message[256];
        sprintf(error_message, "ERROR: La variable '%s' no ha sido declarada", identificador);
        add_error_message(error_message);
    } else {
         
        if (!es_tipo_compatible(tabla_simbolos[indice].tipo, valor)) {
            char error_message[256];
            sprintf(error_message, "ERROR: Tipo de dato incorrecto para la variable '%s'", identificador);
            add_error_message(error_message);
        } else {   
            if(strcmp(tabla_simbolos[indice].tipo, "int")  ==  0)  {
            double valor_double = strtod(valor, NULL);
            int valor_int = round(valor_double);
            char valor_redondeado[256];
            sprintf(valor_redondeado, "%d", valor_int);
            valor = valor_redondeado;
        }    
            tabla_simbolos[indice].valor = strdup(valor); 
            add_syntax_token("ASIGNACION"); 
        }
    }
}


void agregar_simbolo(char* tipo, char* identificador, char* valor) {
    if (num_simbolos < MAX_SIMBOLOS) {
        int indice = buscar_indice_simbolo(identificador);
        if (indice != -1) {
            char error_message[256];
            sprintf(error_message, "ERROR: variable '%s' ya declarada", identificador);
            add_error_message(error_message);
        } else {
            tabla_simbolos[num_simbolos].tipo = strdup(tipo);
            tabla_simbolos[num_simbolos].identificador = strdup(identificador);
             num_simbolos++;
             
            if (valor != NULL) {
                agregar_valor(identificador, valor);
            } 
            add_syntax_token("DECLARACION");
        }
    }
}






char* buscar_valor(char* identificador) {
    for (int i = 0; i < num_simbolos; i++) {
        if (strcmp(tabla_simbolos[i].identificador, identificador) == 0) {
            return tabla_simbolos[i].valor;
        }
    }
    // Devuelve -1 si el identificador no se encuentra en la tabla de símbolos
    return NULL;
}

void print_tabla_simbolos() {
    printf(",\"tabla_simbolos\": [");
    for (int i = 0; i < num_simbolos; i++) {
        printf("{\"tipo\": \"%s\", \"identificador\": \"%s\", \"valor\": \"%s\"}", tabla_simbolos[i].tipo, tabla_simbolos[i].identificador, tabla_simbolos[i].valor);
        if (i < num_simbolos - 1) {
            printf(", ");
        }
    }
    printf("]");
}





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
        char *escaped_value = malloc(strlen(tokens[i].value) * 2 + 1); // Allocate enough space for the escaped string
        char *p = tokens[i].value;
        char *q = escaped_value;
        while (*p) {
            if (*p == '"') {
                *q++ = '\\';
            }
            *q++ = *p++;
        }
        *q = '\0';
        printf("{\"type\": \"%s\", \"value\": \"%s\"}%s", tokens[i].type, escaped_value, i < num_tokens - 1 ? ", " : "");
        free(escaped_value);
    }
    printf("]");
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
    printf(",\"sintactico\":[");
    for (int i = 0; i < num_syntax_tokens; i++) {
        printf("{\"type\": \"%s\"}", syntax_tokens[i].type);
        if (i < num_syntax_tokens - 1) {
            printf(", ");
        }
    }
    printf("]");
}




char* tipo_dato_global;



%}

%error-verbose

%union {
    double entero;
    char* str; 
}
%token ERROR 
%token <entero> NUMERO 

%token <str> TIPO_DE_DATO  COMPARACION FIN IMPRIMIR_VAR
%token <str>  PALABRA_RESERVADA  
%token  <str> IDENTIFICADOR CONST_CADENA
%token <str> SIMBOLO_ASIGNACION  SIGNO_NEGATIVO INCREMENTO
%left '+' '-'
%left '*' '/'
%right '^'

%right SIGNO_NEGATIVO
%type <str>  asignacion expresion
%type <entero>  termino factor 
/* %type <str> expresion
%type <str> termino
%type <str> factor */


%%

programa: sentencia
       |  programa sentencia 

       ;


sentencia: expresion  FIN
         | declaracion FIN
         | asignacion  FIN
         | instruccion FIN
         | comparacion FIN
         | funcion
         ;

  
funcion:  'if' '(' comparacion ')' bloque { add_syntax_token("FUNCION"); }
        | 'if' '(' comparacion ')' bloque 'else' bloque { add_syntax_token("FUNCION"); }
        | 'while' '(' comparacion ')' bloque { add_syntax_token("FUNCION"); }
        | 'do' bloque 'while' '(' comparacion ')' { add_syntax_token("FUNCION"); }
        | 'for' '(' asignacion FIN comparacion FIN INCREMENTO IDENTIFICADOR')'  bloque   { add_syntax_token("FUNCION"); }
        | TIPO_DE_DATO 'main' '(' ')' bloque { add_syntax_token("MAIN"); }
        ;

instruccion: 'printf' '(' CONST_CADENA ')' { add_syntax_token("INSTRUCCION"); }
             | 'printf' '(' CONST_CADENA ',' imprimir ')' { add_syntax_token("INSTRUCCION"); }
             | 'scanf' '(' CONST_CADENA ',' IMPRIMIR_VAR ')' { add_syntax_token("INSTRUCCION"); }
             ;


imprimir: IDENTIFICADOR | IDENTIFICADOR ',' imprimir  
         ;

bloque: '{' programa '}'  { add_syntax_token("BLOQUE"); }
      ;

comparacion: expresion COMPARACION expresion { add_syntax_token("COMPARACION"); }
;

        
declaracion: TIPO_DE_DATO  { tipo_dato_global = strdup($1); } lista_identificadores
           ;



lista_identificadores: IDENTIFICADOR { agregar_simbolo(tipo_dato_global, $1, NULL); }
                     | IDENTIFICADOR SIMBOLO_ASIGNACION expresion {agregar_simbolo(tipo_dato_global, $1,$3); }
                     | IDENTIFICADOR ',' lista_identificadores { agregar_simbolo(tipo_dato_global, $1, NULL); }
                     | IDENTIFICADOR SIMBOLO_ASIGNACION expresion ',' lista_identificadores { agregar_simbolo(tipo_dato_global, $1,$3); }
                     ;

asignacion: IDENTIFICADOR SIMBOLO_ASIGNACION expresion {   agregar_valor($1,$3);};

expresion: expresion '+' termino { char* str = malloc(30); 
                   sprintf(str, "%f", atof($1) + $3); 
                   $$ = str; 
                   add_syntax_token("SUMA"); }
    | expresion '-' termino { char* str = malloc(30); 
                   sprintf(str, "%f", atof($1) - $3); 
                   $$ = str; 
                   add_syntax_token("RESTA"); }
    | '-' expresion %prec SIGNO_NEGATIVO { char* str = malloc(30); 
                        sprintf(str, "%f", -atof($2)); 
                        $$ = str;  
                        add_syntax_token("NEGATIVO"); }
    | termino { char* str = malloc(12); 
                                   sprintf(str, "%f", $1); 
                                   $$ = str;  }
    | CONST_CADENA {char* str = malloc(strlen($1) + 3); 
            sprintf(str, "'%s'", $1); 
            $$ = str; 
            add_syntax_token("CONST_CADENA");}
    | ERROR { yyerror("Error sintactico: caracter no reconocido"); YYERROR; }
    ;

termino: termino '*' factor { $$ = $1 * $3; add_syntax_token("MULTIPLICACION"); }
        | termino '/' factor { $$ = $1 / $3; add_syntax_token("DIVISION"); }
        | factor { $$ = $1; }        
        ; 
    ;

factor: NUMERO              {$$ = $1; add_syntax_token("NUMERO");}
        | IDENTIFICADOR     {$$ = atof(buscar_valor($1)); add_syntax_token("IDENTIFICADOR");}
        | '(' expresion ')' {$$ = atof($2); add_syntax_token("BLOQUE");}
        ;
%%