<?php

exec("flex lexico.l");
exec("bison -d sintactico.y");
exec("gcc -o analizador lex.yy.c sintactico.tab.c -lfl");

?>

<!DOCTYPE html>
<html>

<head>
    <title>Analizador Léxico y sintactico</title>
    <style>
        * {
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
        <h1 style="font-size: 24px;">Analizador</h1>
    </header>
    <div class="container">
        <form method="POST">
            <textarea name="texto" id="texto" cols="30" rows="5" placeholder="Ingrese el codigo" style="padding: 10px; width: 70%; border: 1px solid #ccc; border-radius: 3px; margin-right: 10px;"></textarea>

            <div style="display: flex; flex-direction: column;">
                <button type="button" id="analizar" style="padding: 10px 20px; background-color: #333; color: #fff; border: none; cursor: pointer;">Analizar</button>

                <label>Lexico<input checked type="checkbox" id="lex"></label>
                <label>Sintactico<input checked type="checkbox" id="sin"></label>
            </div>

        </form>




        <div class="output" id="resultado">
            Analisis Lexico
        </div>
        <div class="output" id="msj">
            Analisis Sintactico
        </div>
    </div>

    <script>
        const textoInput = document.getElementById('texto');
        const analizarButton = document.getElementById('analizar');
        const resultadoDiv = document.getElementById('resultado');
        const msj = document.getElementById('msj');

        const lexCheckbox = document.getElementById('lex');
        const sinCheckbox = document.getElementById('sin');

        analizarButton.addEventListener('click', () => {
            const texto = textoInput.value.replace(/\n/g, ' ');
            actualizarResultado(texto);
        });

        textoInput.addEventListener('input', () => {
            const texto = textoInput.value.replace(/\n/g, ' ');
            actualizarResultado(texto);
        });

        function actualizarResultado(texto) {
            // Realizar una solicitud AJAX al servidor PHP para enviar la cadena de texto
            // y recibir los resultados del análisis léxico.
            fetch('analizar.php', {
                    method: 'POST',
                    body: new URLSearchParams({
                        texto
                    }),
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                })
                .then(response => response.text())
                .then(resultados => {
                    console.log('Respuesta:', resultados);

                    try {
                        let resultado = JSON.parse(JSON.parse(resultados));
                        console.log('Resultado:', resultado);

                        if (lexCheckbox.checked) {
                            resultadoDiv.innerHTML = 'Valor&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Token <br>';
                            resultado.lexico.forEach(token => {
                                resultadoDiv.innerHTML += `${token.value}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${token.type}<br>`;
                            });
                        }

                        if (sinCheckbox.checked) {
                            resultado.sintactico.forEach(token => {
                                msj.innerHTML += `${token.type}<br>`;
                            });

                            if (msj.innerHTML.includes("syntax error")) {
                                msj.style.color = 'red';
                            } else {
                                msj.style.color = '';
                            }
                        }

                    } catch (error) {
                        console.error('Error al convertir la respuesta en un objeto:', error);
                    }
                }).catch(error => {
                    console.error('Error en la solicitud AJAX:', error);
                });
        }
    </script>
</body>

</html>