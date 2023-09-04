<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Detalles de Ingreso</title>
    <style>
        /* Estilo de la tabla */
        table {
            width: 100%;
            border-collapse: collapse;
        }

        /* Estilo de las celdas de la tabla */
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }

        /* Estilo de las filas alternas de la tabla */
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }

        /* Estilo de las celdas de encabezado de la tabla */
        th {
            background-color: #4CAF50;
            color: white;
        }
    </style>
</head>
<body>
    <h1>Detalles de Ingreso</h1>

    <%
        // Recuperar el ID del ingreso de la URL
        int idIngreso = Integer.parseInt(request.getParameter("id"));

        // Conexión a la base de datos
        Connection con = null;
        try {
            String url = "jdbc:mysql://localhost:3306/subliplace";
            String user = "root";
            String clave = "password";
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(url, user, clave);

            // Consulta SQL para obtener los detalles de ingresos con el nombre del proveedor
            String consultaSQL = "SELECT d.Id, d.IdIngreso, p.Nombre AS NombreProveedor, d.Precio, d.MontoTotal, d.Estado " +
                                 "FROM DetalleDeIngresos d " +
                                 "INNER JOIN Proveedores p ON d.IdProveedor = p.Id " +
                                 "WHERE d.IdIngreso = ?";
            PreparedStatement ps = con.prepareStatement(consultaSQL);
            ps.setInt(1, idIngreso);
            ResultSet rs = ps.executeQuery();

            // Mostrar los detalles de ingresos en la tabla
            %>
            <table>
                <thead>
                    <tr>
                        <th>ID Detalle</th>
                        <th>ID Ingreso</th>
                        <th>Nombre del Proveedor</th>
                        <th>Precio</th>
                        <th>Monto Total</th>
                        <th>Estado</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        while (rs.next()) {
                            int idDetalle = rs.getInt("Id");
                            int idProveedor = rs.getInt("IdIngreso");
                            String nombreProveedor = rs.getString("NombreProveedor");
                            double precio = rs.getDouble("Precio");
                            double montoTotal = rs.getDouble("MontoTotal");
                            int estado = rs.getInt("Estado");
                    %>
                    <tr>
                        <td><%= idDetalle %></td>
                        <td><%= idIngreso %></td>
                        <td><%= nombreProveedor %></td>
                        <td><%= precio %></td>
                        <td><%= montoTotal %></td>
                        <td><%= estado %></td>
                    </tr>
                    <%
                        }
                        rs.close();
                        ps.close();
                    %>
                </tbody>
            </table>
            <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</body>
</html>
