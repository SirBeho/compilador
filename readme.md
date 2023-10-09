# Analizador Léxico en Flex y PHP

Este proyecto consiste en un analizador léxico implementado en el lenguaje de programación C utilizando la herramienta Flex. El analizador léxico toma una cadena de texto como entrada y reconoce tokens específicos en la cadena. Cada token reconocido se formatea y se imprime.

## Componentes del Proyecto

El proyecto consta de los siguientes componentes:

1. **Analizador Léxico (Lex/Flex)**:
   - El analizador léxico está implementado en un archivo llamado "analizador_lexico.l".
   - Reconoce y formatea tokens para constantes, números, operadores y palabras clave.
   - Utiliza la función `printf` para imprimir cada token.

2. **PHP Script**:
   - Una script PHP en el "index.php" actúa como la interfaz web para el usuario.
   - Permite al usuario ingresar una cadena de texto.
   - Compila el analizador léxico y ejecuta el analizador con la cadena de texto proporcionada.
   - Formatea la salida del analizador léxico y la muestra en la página web.

3. **Página Web**:
   - Una página web simple con un formulario que permite al usuario ingresar la cadena de texto.
   - Cuando se envía el formulario, muestra la salida del analizador léxico en un formato uniforme y ordenado en la página.

## Uso del Proyecto

1. Ingrese una cadena de texto en el campo de entrada en la página web.
2. Haga clic en el botón "Analizar" para enviar la cadena de texto al servidor.
3. El analizador léxico procesará la cadena de texto y formateará los tokens.
4. Los tokens formateados se mostrarán en la página web con un formato uniforme.

## Requisitos

Para ejecutar este proyecto, se requieren los siguientes componentes:

- Un servidor web con soporte para PHP.
- La herramienta Flex para compilar el analizador léxico.

## Git
 - https://github.com/SirBeho/analizador