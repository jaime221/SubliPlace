<%@page import="java.util.Date"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.Statement, java.sql.ResultSet"%>

<%
    // CONECTANDO A LA BASE DE DATOS:
    Connection con;
    String url = "jdbc:mysql://localhost:3306/subliplace";
    String Driver = "com.mysql.jdbc.Driver";
    String user = "root";
    String clave = "password";
    Class.forName("com.mysql.jdbc.Driver");

    con = DriverManager.getConnection(url, user, clave);
    PreparedStatement ps;
    Statement smt;
    ResultSet rs;
    smt = con.createStatement();

    // Paginación: Obtener el número de página actual y calcular el inicio del conjunto de resultados
    int registrosPorPagina = 5;
    int paginaActual = 1;

    if (request.getParameter("pagina") != null) {
        paginaActual = Integer.parseInt(request.getParameter("pagina"));
    }

    int inicioRegistro = (paginaActual - 1) * registrosPorPagina;

    // Consulta SQL para obtener los registros de la página actual
    String consultaSQL = "SELECT i.*, p.Nombre AS NombreProveedor, pr.Nombre AS NombreProducto FROM Ingresos i INNER JOIN Proveedores p ON i.IdProveedor = p.Id INNER JOIN Productos pr ON i.IdProducto = pr.Id LIMIT ?, ?";
    ps = con.prepareStatement(consultaSQL);
    ps.setInt(1, inicioRegistro);
    ps.setInt(2, registrosPorPagina);

    rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lista de Ingresos</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
            }

            h1 {
                text-align: center;
                background-color: #007bff;
                color: #fff;
                padding: 20px;
                margin: 0;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            th, td {
                padding: 10px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            th {
                background-color: #007bff;
                color: #fff;
            }

            tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            tr:hover {
                background-color: #ddd;
            }

            button {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 5px 10px;
                cursor: pointer;
            }

            button:hover {
                background-color: #0056b3;
            }
            /* Estilos para la paginación */
            .pagination {
                display: flex;
                justify-content: center;
                margin-top: 20px;
            }

            .pagination a {
                color: #007bff;
                text-decoration: none;
                padding: 5px 10px;
                margin: 0 5px;
                border: 1px solid #007bff;
            }

            .pagination a:hover {
                background-color: #007bff;
                color: #fff;
            }

            .pagination .active {
                background-color: #007bff;
                color: #fff;
            }
            /* Estilos para el modal */
            .modal {
                display: none;
                position: fixed;
                z-index: 1;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.7);
                overflow: auto;
            }

            .modal-content {
                background-color: #fff;
                margin: 10% auto;
                padding: 20px;
                border: 1px solid #888;
                width: 80%;
            }

            .close {
                color: #aaa;
                float: right;
                font-size: 28px;
                font-weight: bold;
                cursor: pointer;
            }

            .close:hover,
            .close:focus {
                color: black;
                text-decoration: none;
                cursor: pointer;
            }

        </style>
    </head>
    <body>
        <h1>Lista de Ingresos</h1>
        <table border="1">
            <tr>
                <th>ID</th>
                <th>Proveedor</th>
                <th>Producto</th>
                <th>Fecha de Ingreso</th>
                <th>Cantidad</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            <%
                while (rs.next()) {
                    int id = rs.getInt("Id");
                    String nombreProveedor = rs.getString("NombreProveedor");
                    String nombreProducto = rs.getString("NombreProducto");
                    Date fechaIngreso = rs.getDate("FechaIngreso");
                    int cantidad = rs.getInt("Cantidad");
                    int estado = rs.getInt("Estado");
            %>
            <tr>
                <td><%= id %></td>
                <td><%= nombreProveedor %></td>
                <td><%= nombreProducto %></td>
                <td><%= fechaIngreso %></td>
                <td><%= cantidad %></td>
                <td><%= estado %></td>
                <td>
                    <a href="ObtenerDetalles.jsp?id=<%= id %>">Ver detalles</a>
                </td>

            </tr>
            <%
                }
            %>
        </table>

        <%
            // Calcular el número total de páginas
            String conteoSQL = "SELECT COUNT(*) AS total FROM Ingresos";
            ps = con.prepareStatement(conteoSQL);
            rs = ps.executeQuery();
            rs.next();
            int totalRegistros = rs.getInt("total");
            int totalPaginas = (int) Math.ceil((double) totalRegistros / registrosPorPagina);

            // Generar los enlaces de paginación
        %>
        <div class="pagination">
            <%
                for (int i = 1; i <= totalPaginas; i++) {
                    if (i == paginaActual) {
                        out.println("<a class=\"active\" href=\"?pagina=" + i + "\">" + i + "</a>");
                    } else {
                        out.println("<a href=\"?pagina=" + i + "\">" + i + "</a>");
                    }
                }
            %>
        </div>

        <script>
            // Función para mostrar el modal con los detalles del ingreso
            function verDetalles(id) {
                // Realiza una consulta SQL para obtener los detalles del ingreso con el ID especificado
                var consultaSQL = "SELECT * FROM DetalleDeIngresos WHERE IdIngreso = ?";
                var detalles = obtenerDetallesDelIngreso(consultaSQL, id);

                // Obtén referencias al modal y la tabla de detalles
                var modal = document.getElementById("myModal");
                var tablaDetalle = document.getElementById("detalleTabla");

                // Limpia cualquier contenido previo en la tabla
                tablaDetalle.innerHTML = "";

                // Agrega los detalles a la tabla
                for (var i = 0; i < detalles.length; i++) {
                    var detalle = detalles[i];
                    var row = tablaDetalle.insertRow(i);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = detalle.Precio; // Reemplaza con el nombre del campo
                    cell2.innerHTML = detalle.MontoTotal; // Reemplaza con el nombre del campo
                }

                // Muestra el modal
                modal.style.display = "block";
            }

            // Función para cerrar el modal
            function cerrarModal() {
                var modal = document.getElementById("myModal");
                modal.style.display = "none";
            }

            // Función para obtener los detalles del ingreso desde la base de datos
            function obtenerDetallesDelIngreso(consultaSQL, id) {
                // Realiza una solicitud AJAX para obtener los detalles del ingreso desde el servidor
                var xhr = new XMLHttpRequest();
                xhr.open("POST", "obtenerDetalles.jsp", true); // Reemplaza "obtenerDetalles.jsp" con la URL de tu servicio
                xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                xhr.onreadystatechange = function () {
                    if (xhr.readyState === 4 && xhr.status === 200) {
                        var detalles = JSON.parse(xhr.responseText);
                        // Llama a la función para mostrar los detalles en el modal
                        mostrarDetallesEnModal(detalles);
                    }
                };
                xhr.send("consultaSQL=" + consultaSQL + "&id=" + id);
            }

            // Función para mostrar los detalles en el modal
            function mostrarDetallesEnModal(detalles) {
                // Obtén referencias al modal y la tabla de detalles
                var modal = document.getElementById("myModal");
                var tablaDetalle = document.getElementById("detalleTabla");

                // Limpia cualquier contenido previo en la tabla
                tablaDetalle.innerHTML = "";

                // Agrega los detalles a la tabla
                for (var i = 0; i < detalles.length; i++) {
                    var detalle = detalles[i];
                    var row = tablaDetalle.insertRow(i);
                    var cell1 = row.insertCell(0);
                    var cell2 = row.insertCell(1);
                    cell1.innerHTML = detalle.Precio; // Reemplaza con el nombre del campo
                    cell2.innerHTML = detalle.MontoTotal; // Reemplaza con el nombre del campo
                }

                // Muestra el modal
                modal.style.display = "block";
            }
        </script>

    </body>
</html>

<%
    // Cerramos la conexión y los recursos al final del código:
    rs.close();
    smt.close();
    con.close();
%>
