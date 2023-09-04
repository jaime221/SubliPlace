<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <style>
        /* Estilo para el encabezado */
        .header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px;
        }

        /* Estilo para los elementos de la barra de navegación */
        .navbar {
            background-color: #444;
            padding: 10px;
            text-align: center;
            margin-top: -30px; /* Agrega un margen superior negativo para mover hacia arriba */
        }

        .navbar a {
            color: #fff;
            text-decoration: none;
            margin: 10px;
        }

        /* Estilo para resaltar el elemento activo */
        .navbar a.active {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="navbar">
        <a href="Inicio.jsp" class="active">Inicio</a>
        <a href="Ingresos/Ingreso.jsp">Crear Ingreso</a>
         <a href="Ingresos/DetallesDeIngresos.jsp">Ingresos</a>
        <a href="index.jsp">Roles</a>
        <a href="Ventas.jsp">Ventas</a>
        <a href="Productos.jsp">Productos</a>
    </div>
</body>
</html>
