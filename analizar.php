<?php

// if ($_SERVER["REQUEST_METHOD"] == "POST" && $_POST["texto"] != '') {
   

if (true) {

    $texto = $_POST["texto"];
   
    $texto = str_replace(array("\r", "\n"), '', $texto);

    $textoAnalizar = escapeshellarg($texto);

    $analisis = shell_exec('echo ' .$texto . '| analizador.exe 2>&1');


  
   /*  $resultado = [
       
        "msj" => $analisis
    ];  */

    // Enviar la respuesta en formato JSON
     header('Content-Type: application/json');
    echo json_encode($analisis);
}










?>
