<%@page import="java.sql.*"%>
<%@page import="javax.swing.JOptionPane"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> <!-- Agregamos SweetAlert -->
    <title>JSP Page</title>
</head>
<body>  
   
    <div class="container">
        <h1>Agregar Usuario</h1>
        <hr>
        <form action="" method="post" class="form-control" style="width: 500px; height: 400px">
           Nombre de el Usuario : 
            <input type="text" name="txtNom" class="form-control"/><br>
            <br>
            Correo :
            <input type="text" name="txtCorreo" class="form-control"/><br>
            <br>
            <input type="submit" value="Guardar" class="btn btn-primary btn-lg"/>
            <a href="Usuarios.jsp">Regresar</a>
        </form>
    </div>
    
    <%
    Connection con = null;
    String alertMessage = null; 
    
    try {
        String url = "jdbc:mysql://localhost:3306/subliplace";
        String Driver = "com.mysql.jdbc.Driver";
        String user = "root";
        String clave = "password";
        
        Class.forName(Driver);
        con = DriverManager.getConnection(url, user, clave);
        
        PreparedStatement ps;
        String nombre;
        String correo;
        String clave;
        
        nombre = request.getParameter("txtNom");
        correo = request.getParameter("txtCorreo");
        clave = request.getParameter("passClave");
    
        
        if (nombre != null) {
            ps = con.prepareStatement("insert into usuario(nombre,correo,clave,estado) values (?,?,?, 1)");
            ps.setString(1, nombre);
          
            
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
                    }).then(function() {
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
    
  
</body>
</html>

