<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>     
        <title>JSP Page</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> <!-- Agregamos SweetAlert -->
    </head>
    <body style="margin-top: 30px">      
        <jsp:include page="Layout.jsp" />
        <%
            //CONECTANOD A LA BASE DE DATOS:
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
          rs = smt.executeQuery("select * from roles where estado = 1");
            //Creamo la Tabla:     
        %>
        <div class="container">            
            <a href="Agregar.jsp" class="btn btn-primary">Agregar</a>
            <div style="padding-left: 800px">                  
                <input type="text" class="form-control" value="Buscar"/>                            
            </div>
        </div>  

        <br>
        <div class="container">               
            <!--<a  class="btn btn-success" href="Agregar.jsp">Nuevo Registro</a> Esto es Cuando se Crea un nuevo Archivo Agregar.jsp -->         
            <table class="table table-bordered"  id="tablaDatos">
                <thead>
                    <tr>
                        <th class="text-center">Id</th>

                        <th class="text-center">Nombre</th>
                        <th class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody id="tbodys">
                    <%
                        while (rs.next()) {
                    %>
                    <tr>
                        <td class="text-center"><%= rs.getInt("id")%></td>

                        <td class="text-center"><%= rs.getString("nombre")%></td>

                        <td class="text-center">

                            <!-- <input type="hidden" value="<//%= rs.getInt("Id_Usuario")%>" id="Editar"/>
                            <input type="submit" class="btn btn-warning" data-toggle="modal" data-target="#myModal1" value="Editar"/>  -->
                            <a href="Editar.jsp?id=<%= rs.getInt("id")%>" class="btn btn-primary">Editar</a>
                            <a href="#" class="btn btn-danger" onclick="confirmDelete(<%= rs.getInt("id")%>)">Eliminar</a>
                        </td>
                    </tr>
                    <%}%>
            </table>
        </div>        


    </div>        
    <script>
        function confirmDelete(id) {
            Swal.fire({
                title: '¿Estás seguro?',
                text: 'Esta acción eliminará el registro.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#3085d6',
                cancelButtonColor: '#d33',
                confirmButtonText: 'Sí, eliminarlo',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    // Si el usuario confirma, redirigir a la página que realiza la eliminación
                    window.location.href = 'Delete.jsp?id=' + id;
                }
            });
        }
    </script>
    <script src="js/jquery.js" type="text/javascript"></script>             
    <script src="js/bootstrap.min.js" type="text/javascript"></script>        
</body>
</html>

