<?php




if ($_SERVER["REQUEST_METHOD"] == "POST" && $_POST["texto"] != '') {  
 //if (true) {  

   $texto = $_POST["texto"];
   
   //$texto = str_replace(array("\r", "\n"), '', $texto);
   //$texto = str_replace('%', '"%"', $texto);
   //$texto= str_replace('&', '"&"', $texto); 
   //$texto= str_replace('<', '^<', $texto); 

   //$texto = escapeshellarg($texto);
   //$texto = trim($texto, '"'); // Eliminar las comillas al principio y al final

   $analisis = shell_exec('echo  "---'.$texto.'---"  | .\analizador.exe 2>&1');
  
   // Enviar la respuesta en formato JSON
   header('Content-Type: application/json');
   echo json_encode($analisis);
}










?>
