
<%@page import="java.util.concurrent.ExecutionException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%
    String formato = (String) request.getAttribute("mensaje");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AUTENTICACIÓN</title>
        <style>
            table{width:300px;
                  border:black 2px solid;
                  margin-left: auto;
                  margin-right: auto;
                  background: whitesmoke;}

            body{background: gainsboro;}

            h1,h2{text-align: center;}

        </style>
    </head>
    <body>
        <h1>Ingreso</h1>
        <hr>
    <form action="autenticacion.con" method="POST">
        <table>
            <tr><td><br></td><td></td></tr>

            <tr><td>Usuario  :</td><td><input type='text' name="txtUsuario"  size='12'></td></tr>

            <tr><td><br></td><td></td></tr>

            <tr><td>Password :</td><td><input type='password' name='txtPass'  size='12'></td></tr>

            <tr><td><br></td><td></td></tr>

            <tr><td><input align="center" type="checkbox" name="recordar" value="ON" /><label>recordar</label></td><td></td></tr>

            <tr><td><br></td><td></td></tr>

            <tr><td><input align="center" type="submit" value="Ingresar" name="ingresar"/></td><td></td></tr>

        </table>

        <br><br>
    </form>

    <%if (formato != null) {%>
    <h2><%=formato%></h2>
    <%}%>
    
</body>
</html>

