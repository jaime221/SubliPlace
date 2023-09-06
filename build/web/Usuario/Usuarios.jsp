<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/bootstrap.min.css" rel="stylesheet" type="text/css"/>     
        <title>Usuarios</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script> <!-- Agregamos SweetAlert -->
    </head>
    <body style="margin-top: 30px">      
      
<style>
    /* Estilo para el botón de "Editar" */
.btn-primary {
    background-color: #007bff; /* Color de fondo */
    color: #fff; /* Color del texto */
    border: none; /* Quita el borde */
    padding: 10px 20px; /* Espaciado interno */
    text-align: center; /* Alineación de texto */
    text-decoration: none; /* Quita subrayado */
    display: inline-block;
    font-size: 16px; /* Tamaño de fuente */
    border-radius: 4px; /* Borde redondeado */
}

/* Estilo para el botón de "Eliminar" */
.btn-danger {
    background-color: #dc3545; /* Color de fondo */
    color: #fff; /* Color del texto */
    border: none; /* Quita el borde */
    padding: 10px 20px; /* Espaciado interno */
    text-align: center; /* Alineación de texto */
    text-decoration: none; /* Quita subrayado */
    display: inline-block;
    font-size: 16px; /* Tamaño de fuente */
    border-radius: 4px; /* Borde redondeado */
}

/* Estilo para el botón de "Eliminar" al pasar el mouse sobre él */
.btn-danger:hover {
    background-color: #c82333; /* Cambia el color de fondo al pasar el mouse */
}

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        padding: 10px;
        text-align: center;
        border: 1px solid #ddd;
    }

    th {
        background-color: #f2f2f2;
    }

    tr:nth-child(even) {
        background-color: #f2f2f2;
    }

    tr:hover {
        background-color: #ddd;
    }

    .container {
        margin-top: 30px;
    }

    .container > a.btn-primary {
        margin-right: 10px;
    }

    .container > div {
        padding-left: 800px;
    }

    .container > div > input[type="text"] {
        width: 200px;
    }
</style>

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
          rs = smt.executeQuery("select * from usuarios where estado = 1");
            //Creamo la Tabla:     
        %>
        <jsp:include page="../Layout.jsp" />
        <div class="container">            
            <a href="Agregar.jsp" class="btn btn-primary">Agregar</a>
         
        </div>  

        <br>
        <div class="container">               
            <!--<a  class="btn btn-success" href="Agregar.jsp">Nuevo Registro</a> Esto es Cuando se Crea un nuevo Archivo Agregar.jsp -->         
            <table class="table table-bordered"  id="tablaDatos">
                <thead>
                    <tr>
                        <th class="text-center">Id</th>

                        <th class="text-center">Nombre</th>
                        <th class="text-center">Correo</th>
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
                        
                          <td class="text-center"><%= rs.getString("correo")%></td>

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

