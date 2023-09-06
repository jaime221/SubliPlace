<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Formulario y Procesamiento de Ingreso</title>
        <!-- Agrega estos enlaces en la sección head de tu archivo JSP -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

        <style>

            body {
                font-family: Arial, sans-serif;
            }

            form {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                background-color: #f4f4f4;
                border-radius: 5px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }

            label {
                display: block;
                margin-bottom: 10px;
            }

            select, input[type="date"], input[type="text"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }

            input[type="submit"] {
                background-color: #007bff;
                color: #fff;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }

            h1 {
                text-align: center; /* Centrar el texto horizontalmente */
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }
            .boton {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff; /* Color de fondo del botón */
                color: #fff; /* Color del texto del botón */
                text-decoration: none; /* Quitamos el subrayado del enlace */
                border: none; /* Quitamos el borde del botón */
                border-radius: 5px;
                cursor: pointer;
            }

            /* Estilo cuando el ratón está sobre el botón */
            .boton:hover {
                background-color: #0056b3; /* Cambiamos el color de fondo al pasar el ratón por encima */
            }

        </style>
    </head>
    <body>
        <jsp:include page="../Layout.jsp" />
          <br>
        <br>
        
        
        <h1>Formulario de Ingreso</h1>
        <form action="" method="post">
            <label for="IdProveedor">Proveedor:</label>
            <select name="IdProveedor" required>
                <option value="">Seleccione un proveedor</option>
                <% 
                    Connection conn = null;
                    PreparedStatement pstmt = null;
                    ResultSet rs = null;
                    String url = "jdbc:mysql://localhost:3306/subliplace";
                    String usuario = "root";
                    String contraseña = "password";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection(url, usuario, contraseña);
                        String sql = "SELECT Id, Nombre FROM Proveedores";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                    
                        while (rs.next()) {
                            int idProveedor = rs.getInt("Id");
                            String nombreProveedor = rs.getString("Nombre");
                %>
                <option value="<%= idProveedor %>"><%= nombreProveedor %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) { }
                        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
                        try { if (conn != null) conn.close(); } catch (Exception e) { }
                    }
                %>
            </select><br>

            <label for="IdProducto">Producto:</label>
            <select name="IdProducto" required>
                <option value="">Seleccione un producto</option>
                <% 
                    try {
                        conn = DriverManager.getConnection(url, usuario, contraseña);
                        String sql = "SELECT Id, Nombre, Precio FROM Productos";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();
                    
                        while (rs.next()) {
                            int idProducto = rs.getInt("Id");
                            String nombreProducto = rs.getString("Nombre");
                            BigDecimal precioProducto = rs.getBigDecimal("Precio");
                %>
                <option value="<%= idProducto %>" data-precio="<%= precioProducto %>"><%= nombreProducto %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (Exception e) { }
                        try { if (pstmt != null) pstmt.close(); } catch (Exception e) { }
                        try { if (conn != null) conn.close(); } catch (Exception e) { }
                    }
                %>
            </select><br>

            <label for="FechaIngreso">Fecha de Ingreso:</label>
            <input type="date" name="FechaIngreso" required><br>

            <label for="Cantidad">Cantidad:</label>
            <input type="text" name="Cantidad" required onkeyup="calcularMontoTotal()"><br>

            <label for="MontoTotal">Monto Total:</label>
            <input type="text" name="MontoTotal" readonly><br>

            <input type="submit" name="submit" value="Guardar Ingreso">

            <a href="../index.jsp" class="boton">Regresar</a>
        </form>

        <script>
            function calcularMontoTotal() {
                var cantidad = parseInt(document.getElementsByName("Cantidad")[0].value);
                var precio = parseFloat(document.getElementsByName("IdProducto")[0].options[document.getElementsByName("IdProducto")[0].selectedIndex].getAttribute("data-precio"));
                var montoTotal = cantidad * precio;
                if (!isNaN(montoTotal)) {
                    document.getElementsByName("MontoTotal")[0].value = montoTotal.toFixed(2);
                } else {
                    document.getElementsByName("MontoTotal")[0].value = "";
                }
            }
            document.getElementsByName("IdProducto")[0].onchange = calcularMontoTotal;
        </script>

        <%
            if (request.getParameter("submit") != null) {
                String idProveedor = request.getParameter("IdProveedor");
                String idProducto = request.getParameter("IdProducto");
                String fechaIngreso = request.getParameter("FechaIngreso");
                String cantidad = request.getParameter("Cantidad");
                String montoTotal = request.getParameter("MontoTotal");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, usuario, contraseña);

                    // Insertar el ingreso
                    String sqlIngreso = "INSERT INTO Ingresos (IdProveedor, IdProducto, FechaIngreso, Cantidad, Estado) VALUES (?, ?, ?, ?, 1)";
                    PreparedStatement pstmtIngreso = conn.prepareStatement(sqlIngreso, Statement.RETURN_GENERATED_KEYS);
                    pstmtIngreso.setInt(1, Integer.parseInt(idProveedor));
                    pstmtIngreso.setInt(2, Integer.parseInt(idProducto));
                    pstmtIngreso.setDate(3, Date.valueOf(fechaIngreso));
                    pstmtIngreso.setInt(4, Integer.parseInt(cantidad));
                    pstmtIngreso.executeUpdate();

                    // Obtener el ID generado para el ingreso
                    ResultSet generatedKeys = pstmtIngreso.getGeneratedKeys();
                    int idIngreso = -1;
                    if (generatedKeys.next()) {
                        idIngreso = generatedKeys.getInt(1);
                    }

                    // Insertar el detalle de ingreso
              

                   // Insertar el detalle de ingreso
String sqlDetalle = "INSERT INTO DetalleDeIngresos (IdIngreso, IdProveedor, Precio, MontoTotal, Estado) VALUES (?, ?, ?, ?, 1)";
PreparedStatement pstmtDetalle = conn.prepareStatement(sqlDetalle);
pstmtDetalle.setInt(1, idIngreso);
pstmtDetalle.setInt(2, Integer.parseInt(idProveedor));
// Obtén el precio del producto seleccionado en el formulario
BigDecimal precio = new BigDecimal(request.getParameter("IdProducto"));
pstmtDetalle.setBigDecimal(3, precio);
pstmtDetalle.setBigDecimal(4, new BigDecimal(montoTotal));
// Obtén el estado del formulario
pstmtDetalle.executeUpdate();


                    conn.close();
        %>
        <script>
            // Mostrar un toast de éxito con SweetAlert2
            Swal.fire({
                icon: 'success',
                title: 'Éxito',
                text: 'Ingreso y detalle de ingreso guardados exitosamente.'
            }).then(function () {

                window.location.href = "../index.jsp";
            });
        </script>
        <%
            } catch (Exception e) {
        %>
        <script>
            // Mostrar un toast de error con SweetAlert2
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Error al guardar el ingreso: <%= e.getMessage() %>'
            });
        </script>
        <%
            }
        }
        %>
    </body>
</html>
