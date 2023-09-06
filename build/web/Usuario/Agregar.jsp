<%@ page import="java.sql.*" %>
<%@ page import="javax.swing.JOptionPane" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
        <title>Agregar Usuario</title>
        <style>
            /* Estilos para el formulario */
            .container {
                max-width: 400px;
                margin: 0 auto;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 5px;
                background-color: #f9f9f9;
            }

            h1 {
                text-align: center;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                font-weight: bold;
            }

            input[type="text"],
            input[type="password"],
            input[type="number"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 3px;
            }

            input[type="submit"],
            .btn-secondary {
                display: inline-block;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                border: none;
                border-radius: 3px;
                cursor: pointer;
                text-decoration: none;
            }

            input[type="submit"]:hover,
            .btn-secondary:hover {
                background-color: #0056b3;
            }

            /* Estilos para los mensajes de error/success */
            .alert-message {
                text-align: center;
                margin-top: 10px;
                padding: 10px;
                border-radius: 3px;
            }

            .alert-success {
                background-color: #4CAF50;
                color: white;
            }

            .alert-error {
                background-color: #f44336;
                color: white;
            }
        </style>

    </head>
    <body>
        <jsp:include page="../Layout.jsp" />
        <br>
        <br>
        <div class="container">
            <h1>Agregar Usuario</h1>
            <hr>
            <form action="" method="post">
                <div class="form-group">
                    <label for="txtNom">Nombre de Usuario:</label>
                    <input type="text" name="txtNom" class="form-control" id="txtNom" required />
                </div>
                <div class="form-group">
                    <label for="txtCorreo">Correo:</label>
                    <input type="text" name="txtCorreo" class="form-control" id="txtCorreo" required />
                </div>
                <div class="form-group">
                    <label for="passClave">Clave:</label>
                    <input type="password" name="passClave" class="form-control" id="passClave" required />
                </div>
                <div class="form-group">
                    <label for="IdRol">Rol:</label>
                    <select name="IdRol" class="form-control" id="IdRol">
                        <%-- Aquí cargarás los roles desde la base de datos --%>
                        <%
                            Connection con = null;
                            try {
                                String url = "jdbc:mysql://localhost:3306/subliplace";
                                String Driver = "com.mysql.jdbc.Driver";
                                String user = "root";
                                String password = "password";

                                Class.forName(Driver);
                                con = DriverManager.getConnection(url, user, password);

                                PreparedStatement ps = con.prepareStatement("SELECT id, nombre FROM roles");
                                ResultSet rs = ps.executeQuery();

                                while (rs.next()) {
                                    int roleId = rs.getInt("id");
                                    String roleName = rs.getString("nombre");
                        %>
                        <option value="<%= roleId %>"><%= roleName %></option>
                        <%
                                }
                                rs.close();
                                ps.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                try {
                                    if (con != null) {
                                        con.close();
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="form-group text-center">
                    <input type="submit" value="Guardar" class="btn btn-primary btn-lg" />
                    <a href="Usuarios.jsp" class="btn btn-secondary btn-lg">Regresar</a>
                </div>
            </form>

            <%
            String alertMessage = null;

            try {
                String url = "jdbc:mysql://localhost:3306/subliplace";
                String Driver = "com.mysql.jdbc.Driver";
                String user = "root";
                String password = "password";

                Class.forName(Driver);
                con = DriverManager.getConnection(url, user, password);

                PreparedStatement ps;
                String nombre;
                String correo;
                String clave;
                int idrol;
            

                nombre = request.getParameter("txtNom");
                correo = request.getParameter("txtCorreo");
                clave = request.getParameter("passClave");
                idrol = Integer.parseInt(request.getParameter("IdRol"));


                if (nombre != null) {
                    ps = con.prepareStatement("insert into usuarios(nombre,correo,clave,estado,IdRol) values (?,?,?, 1,?)");
                    ps.setString(1, nombre);
                    ps.setString(2, correo);
                    ps.setString(3, clave);
                    ps.setInt(4, idrol);
                    int rowsAffected = ps.executeUpdate();
                    if (rowsAffected > 0) {
                        alertMessage = "Se agregó correctamente el usuario";
            %>
            <script>
                Swal.fire({
                    icon: 'success',
                    title: 'Éxito',
                    text: '<%= alertMessage %>',
                    timer: 2000 // La alerta se cierra automáticamente después de 2 segundos
                }).then(function () {
                    window.location.href = 'Usuarios.jsp'; // Redirige a la página principal
                });
            </script>
            <%
        } else {
            alertMessage = "Error al agregar el usuario";
            %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: '<%= alertMessage %>'
                });
            </script>
            <%
        }
    }
} catch (Exception e) {
    e.printStackTrace();
    alertMessage = "Error inesperado";
            %>
            <script>
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: '<%= alertMessage %>'
                });
            </script>
            <%
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
            %>
        </div>
    </body>
</html>
