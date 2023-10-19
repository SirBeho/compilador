# Readme: Analizadores Léxico y Sintáctico en C y PHP

Este Readme proporciona información detallada sobre dos analizadores, `lexico.l` y `sintactico.y`, escritos en C, así como el código PHP y HTML asociado para crear una interfaz web que utilice estos analizadores.

Para [mas informacion](https://youtu.be/pKObh-1xLYg) vea el video de su funcionalidad en YouTube 
  

## Analizador Léxico (`lexico.l`)

### Descripción
- `lexico.l` es un analizador léxico escrito en C utilizando Flex. Su función principal es escanear el código fuente de entrada y reconocer tokens, como identificadores, palabras clave, números y símbolos, para pasarlos al analizador sintáctico.

### Tokens Reconocidos
- Tipo de dato (`int`, `char`, `float`, `double`, `bool`, `void`)
- Palabras reservadas (`if`)
- Identificadores (nombres de variables y funciones)
- Números (enteros y decimales)
- Símbolo de asignación (`=`)
- Operadores de comparación (`==`, `<`, `>`, `<=`, `>=`)
- Símbolos de puntuación (`;`, `{`, `}`, `[`, `]`, `(`, `)`)
- Operadores aritméticos (`+`, `-`, `*`, `/`)

### Funciones Principales
- `yylex`: Esta función escanea el código fuente y devuelve tokens al analizador sintáctico.
- `print_tokens`: Imprime los tokens reconocidos.



## Analizador Sintáctico (`sintactico.y`)

### Descripción
- `sintactico.y` es un analizador sintáctico escrito en C utilizando Bison. Su función es analizar la estructura del código fuente y construir un árbol de sintaxis abstracta. Además, registra los tokens en una estructura `Token` definida y proporciona una función para imprimirlos.

### Tokens Reconocidos
- Tipo de dato (`TIPO_DE_DATO`)
- Identificadores (`IDENTIFICADOR`)
- Números (`NUMERO`)
- Palabras reservadas (`PALABRA_RESERVADA`)
- Símbolo de asignación (`ASIGNACION`)
- Operadores de comparación (`COMPARACION`)
- Símbolos de puntuación (`FIN`)
- Operadores aritméticos (`+`, `-`, `*`, `/`)
- Otros tokens específicos definidos en `lexico.l`

### Producciones y Reglas
- El analizador sintáctico define una gramática que especifica las producciones y reglas de construcción del lenguaje.

### Funciones Principales
- `yyparse`: Inicia el análisis sintáctico y construye el árbol de sintaxis abstracta.
- `add_token`: Agrega un token a la estructura `Token`.
- `print_tokens`: Imprime los tokens reconocidos.



## Interfaz Web (index.php)

### Descripción
- La interfaz web proporciona una forma de interactuar con los analizadores léxico y sintáctico a través de un formulario.
- Permite al usuario ingresar código fuente en un cuadro de texto y seleccionar qué análisis realizar (léxico, sintáctico o ambos).
- Muestra los resultados en dos áreas separadas en la página web.

### Componentes Clave
- Formulario para ingresar el código fuente.
- Casillas de verificación para habilitar/deshabilitar el análisis léxico y sintáctico.
- Botón "Analizar" para iniciar el análisis.
- Resultados de análisis léxico y sintáctico.

### Ejecución
- La página web se inicia en un servidor web que interpreta PHP, como Apache.
- El usuario ingresa el código fuente, selecciona las opciones de análisis y hace clic en "Analizar".
- Los resultados se muestran en la página web.

## Archivo de Procesamiento (analizar.php)

### Descripción
- El archivo PHP `analizar.php` recibe los datos del formulario de la interfaz web y utiliza los analizadores léxico y sintáctico para procesar el código fuente.
- Luego, devuelve los resultados al formato JSON para que la página web los muestre.

### Funciones Principales
- Procesa el código fuente recibido a través de `POST`.
- Ejecuta los analizadores C y obtiene los resultados.
- Devuelve los resultados al cliente en formato JSON.

Este conjunto de archivos permite analizar código fuente desde una interfaz web utilizando un analizador léxico y sintáctico escritos en C, proporcionando una forma interactiva de verificar la estructura y los tokens del código fuente.
