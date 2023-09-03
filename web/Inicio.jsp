
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bienvenido a Subli Place</title>
    <style>
        body {
            background-image: url('https://i.ytimg.com/vi/jD2Bkta9ErA/maxresdefault.jpg'); /* Reemplaza 'tu-imagen-de-fondo.jpg' con la URL de tu imagen de fondo */
            background-size: cover;
            background-position: center;
            height: 100vh;
            margin: 0;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            font-family: Arial, sans-serif;
        }
        .animated-text {
            font-size: 48px;
            color: #fff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            animation: text-animation 2s ease-in-out infinite;
        }
        @keyframes text-animation {
            0% {
                opacity: 0;
                transform: translateY(-20px);
            }
            50% {
                opacity: 1;
                transform: translateY(0);
            }
            100% {
                opacity: 0;
                transform: translateY(20px);
            }
        }
        .enter-button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 24px;
            background-color: #3498db;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .enter-button:hover {
            background-color: #2980b9;
        }
    </style>
</head>
<body>
    <div class="animated-text">
        Bienvenido a Subli Place
    </div>
    <a href="Productos.jsp"> <!-- Reemplaza 'pagina-de-ingreso.html' con la URL de tu página de ingreso -->
        <button  class="enter-button">Ingresar</button>
    </a>
</body>
</html>
