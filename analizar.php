<?php


if ($_SERVER["REQUEST_METHOD"] == "POST" && $_POST["texto"] != '') {
    $texto = $_POST["texto"];
    // Ejecutar el analizador léxico para obtener tokens
    $tokens = shell_exec('echo ' . $texto. ' | analizador.exe');
    $lineas = explode("\n", $tokens);
    var_dump(analizador_sintactico($lineas)) ;

    return [$tokens,analizador_sintactico($lineas)];

}

function analizador_sintactico($tokens) {
    $pila = array(); // Pila para seguimiento del análisis
    $indice = 0;     // Índice para recorrer la matriz de tokens

    while ($indice < count($tokens)) {
        $token = $tokens[$indice];
        
        // Comprobamos las reglas gramaticales
        if ($token == 'int' || $token == 'float') {
            // Regla: tipo -> 'int' | 'float'
            array_push($pila, $token); // Apilamos el tipo
        } elseif (preg_match('/^[a-zA-Z][a-zA-Z0-9]*$/', $token)) {
            // Regla: ID
            if (end($pila) == 'int' || end($pila) == 'float') {
                // Coincide con la regla: declaracion -> tipo ID ';'
                array_pop($pila); // Sacamos el tipo
                array_push($pila, 'declaracion'); // Apilamos la declaración
            } else {
                // Error: identificador sin tipo
                return "Error: Identificador sin tipo";
            }
        } elseif ($token == ';') {
            // Regla: ';'
            if (end($pila) == 'declaracion') {
                // Coincide con la regla: declaracion -> tipo ID ';'
                array_pop($pila); // Sacamos la declaración
            } else {
                // Error: punto y coma sin declaración
                return "Error: Punto y coma sin declaración";
            }
        } else {
            // Token no reconocido
            return "Error: Token no reconocido - '$token'";
        }
        
        $indice++; // Pasamos al siguiente token
    }

   
    if (count($pila) == 0) {
        return "Análisis sintáctico exitoso";
    } else {
        return "Error: Estructura incorrecta en la entrada";
    }
}








?>
