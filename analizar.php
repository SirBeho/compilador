<?php

if ($_SERVER["REQUEST_METHOD"] == "POST" && $_POST["texto"] != '') {

   
    $texto = $_POST["texto"];
    $texto = str_replace(array("\r", "\n"), '', $texto);

    $textoAnalizar = escapeshellarg($texto);
    $tokens = shell_exec('echo ' .$texto . '| analizador_lexico.exe 2>&1');
    $analisis = shell_exec('echo ' .$texto . '| analizador.exe 2>&1');


  
    $resultado = [
        "tokens" => $tokens,
        "msj" => $analisis
    ]; 

    // Enviar la respuesta en formato JSON
     header('Content-Type: application/json');
    echo json_encode($resultado);
}










?>
