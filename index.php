<?php
         $output =["Resulados"];
        if ($_SERVER["REQUEST_METHOD"] == "POST") {
            $texto = $_POST["texto"];
      
            // Compilar el analizador léxico
            exec("flex analizador_lexico.l"); // Asegúrate de que "flex" esté instalado
        
            // Compilar el archivo C generado por Flex
            exec("gcc -o analizador lex.yy.c -lfl"); // Esto crea un ejecutable llamado "analizador"
        
            // Ejecutar el analizador léxico con la cadena de texto proporcionada
            $output = shell_exec('echo ' . $texto. ' | analizador.exe');
        
            // Procesar la salida en un array asociativo
            $output = explode("\n", $output);
            
            
           
        }
       
        ?>

<!DOCTYPE html>
<html>
<head>
    <title>Analizador Léxico</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 20px;
        }

        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 5px;
            margin-top: 20px;
        }

        form {
            display: flex;
            justify-content: center;
            align-items: center;
        }

        input[type="text"] {
            padding: 10px;
            width: 70%;
            border: 1px solid #ccc;
            border-radius: 3px;
            margin-right: 10px;
        }

        button {
            padding: 10px 20px;
            background-color: #333;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #555;
        }

        .output {
            background-color: #f9f9f9;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 3px;
            margin-top: 1rem;
 
       
            border-radius: .5rem;
           
        }
    </style>
</head>
<body>
    <header>
        <h1 style="font-size: 24px;">Analizador Léxico</h1>
    </header>
    <div class="container">
        <form method="POST">
            <input type="text" value="<?php echo isset($_POST["texto"]) ? $_POST["texto"] : ""?>" name="texto" placeholder="Ingrese la cadena de texto" style="padding: 10px; width: 70%; border: 1px solid #ccc; border-radius: 3px; margin-right: 10px;">
            <button type="submit" style="padding: 10px 20px; background-color: #333; color: #fff; border: none; cursor: pointer;">Analizar</button>
        </form>
        <div class="output">
                <?php foreach ($output as $line) : ?>
                    <div><?= $line ?></div>
            <?php endforeach; ?>
        </div>
    </div>
</body>
</html>
