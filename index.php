<?php
 exec("flex analizador_lexico.l");       
 exec("gcc -o analizador lex.yy.c -lfl"); 
?>

<!DOCTYPE html>
<html>
<head>
    <title>Analizador Léxico</title>
    <style>
          *{
            font-family: "Consolas";
        }
        
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
            <input type="text" id="texto" name="texto" placeholder="Ingrese la cadena de texto" style="padding: 10px; width: 70%; border: 1px solid #ccc; border-radius: 3px; margin-right: 10px;">
            <button type="button" id="analizar" style="padding: 10px 20px; background-color: #333; color: #fff; border: none; cursor: pointer;">Analizar</button>
        </form>
        <div class="output" id="resultado">
            Resultados
        </div>
    </div>

    <script>
        const textoInput = document.getElementById('texto');
        const analizarButton = document.getElementById('analizar');
        const resultadoDiv = document.getElementById('resultado');

        analizarButton.addEventListener('click', () => {
            const texto = textoInput.value;
            actualizarResultado(texto);
        });

        textoInput.addEventListener('input', () => {
            const texto = textoInput.value;
            actualizarResultado(texto);
        });

        function actualizarResultado(texto) {
            // Realizar una solicitud AJAX al servidor PHP para enviar la cadena de texto
            // y recibir los resultados del análisis léxico.
            fetch('analizar.php', {
                method: 'POST',
                body: new URLSearchParams({ texto }),
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
            })
            .then(response => response.text())
            .then(resultados => {

                resultadoDiv.innerHTML  = resultados.replace(/ /g, '&nbsp;').replace(/\n/g, '<br>');
            })
            .catch(error => {
                console.error('Error en la solicitud AJAX:', error);
            });
        }
    </script>
</body>
</html>
