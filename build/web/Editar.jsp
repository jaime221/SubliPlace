
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <title>JSP Page</title>
    </head>
    <body>
         
        <%
       //CONECTANOD A LA BASE DE DATOS:
       Connection con;
       String url="jdbc:mysql://localhost:3306/subliplace";
       String Driver="com.mysql.jdbc.Driver";
       String user="root";
       String clave="password";
       Class.forName(Driver);
       con=DriverManager.getConnection(url,user,clave);
       //Emnpezamos Listando los Datos de la Tabla Usuario pero de la fila seleccionada
       PreparedStatement ps;
       ResultSet rs;
       int id=Integer.parseInt(request.getParameter("id"));
       ps=con.prepareStatement("select * from roles where id="+id);
       rs=ps.executeQuery();
       while(rs.next()){
        %>
        <div class="container">
            <h1>Modificar Rol</h1>
            <hr>
            <form action="" method="post">
                <div class="form-group">
                    <label for="txtNom">Nombre de el Rol :</label>
                    <input type="text" id="txtNom" name="txtNom" class="form-control" value="<%= rs.getString("nombre")%>"/>
                </div>
               
                <input type="submit" value="Guardar" class="btn btn-primary btn-lg"/>
                <a href="index.jsp">Regresar</a>
            </form>
            <%}%>
        </div>
        <style>
            body {
                background-color: #f4f4f4;
                font-family: Arial, sans-serif;
            }

            .container {
                margin-top: 20px;
                background-color: #fff;
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                max-width: 500px;
            }

            h1 {
                text-align: center;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                font-weight: bold;
            }

            input[type="text"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }

            .btn-primary {
                background-color: #007bff;
                color: #fff;
            }

            .btn-primary:hover {
                background-color: #0056b3;
            }

            a {
                display: block;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </body>
</html>
<%
    String  nombre;
    
       nombre=request.getParameter("txtNom");
       if(nombre!=null){
           ps=con.prepareStatement("update roles set  nombre='"+nombre+"'where id="+id);
           ps.executeUpdate();
           response.sendRedirect("index.jsp");
       }
       
       
%>