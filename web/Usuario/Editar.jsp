<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Modificar Usuario</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 400px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h1 {
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        input[type="submit"],
        a.btn-back {
            display: inline-block;
            padding: 10px 20px;
            margin-right: 10px;
            background-color: #007BFF;
            color: #fff;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }

        a.btn-back {
            background-color: #6c757d;
        }
    </style>
</head>
<body>
<%
    //CONECTANDO A LA BASE DE DATOS
    Connection con;
    String url="jdbc:mysql://localhost:3306/subliplace";
    String Driver="com.mysql.jdbc.Driver";
    String user="root";
    String clave="password";
    Class.forName(Driver);
    con=DriverManager.getConnection(url,user,clave);

    //Obteniendo datos del usuario
    PreparedStatement ps;
    ResultSet rs;
    int id=Integer.parseInt(request.getParameter("id"));
    ps=con.prepareStatement("select * from usuarios where id="+id);
    rs=ps.executeQuery();
    while(rs.next()){
%>
<div class="container">
    <h1>Modificar Usuario</h1>
    <hr>
    <form action="" method="post">
        <div class="form-group">
            <label for="txtNom">Nombre de Usuario:</label>
            <input type="text" id="txtNom" name="txtNom" class="form-control" value="<%= rs.getString("nombre")%>"/>
        </div>
        <div class="form-group">
            <label for="txtCorreo">Correo:</label>
            <input type="text" id="txtCorreo" name="txtCorreo" class="form-control" value="<%= rs.getString("correo")%>"/>
        </div>
        <input type="submit" value="Guardar" class="btn btn-primary btn-lg btn-save"/>
        <a href="Usuarios.jsp" class="btn btn-secondary btn-back">Regresar</a>
    </form>
    <%
    }
    %>
</div>
<%
    // Procesamiento del formulario para actualizar la base de datos
    String nombre;
    String correo;
    nombre = request.getParameter("txtNom");
    correo = request.getParameter("txtCorreo");
    if (nombre != null && correo != null) {
        ps = con.prepareStatement("update usuarios set nombre='" + nombre + "', correo='" + correo + "' where id=" + id);
        ps.executeUpdate();
        response.sendRedirect("Usuarios.jsp");
    }
%>
</body>
</html>
