<%@page import="java.sql.*"%>
<%@page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body>
        
    <%
    Connection con;
    String url = "jdbc:mysql://localhost:3306/subliplace";
    String Driver = "com.mysql.jdbc.Driver";
    String user = "root";
    String clave = "password";
    Class.forName(Driver);
    con = DriverManager.getConnection(url, user, clave);
  
    PreparedStatement ps;
    int id = Integer.parseInt(request.getParameter("id"));
    ps = con.prepareStatement("UPDATE usuarios SET estado = 0 WHERE id = ?");
    ps.setInt(1, id);
    ps.executeUpdate();
    
    response.sendRedirect("Usuarios.jsp");
    %>
</body>
</html>
