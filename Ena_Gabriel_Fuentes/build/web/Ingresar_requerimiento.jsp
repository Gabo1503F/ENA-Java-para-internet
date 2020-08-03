
<%@page import="modelo.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<%
    String formato = (String) request.getAttribute("vacio1");
    Conexion con = new Conexion();
    ResultSet rsGer = con.listarGerencia();
    ResultSet rsAsig = con.listarDepartamento();
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ingresar Requerimiento</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {

                $('#listag').change(function () {

                    $("#listad").empty();

                    recargarlista1();
                });
            });

            var gerentes = [];

            <%try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull", "root", "");

                    String query = "select distinct gerente from gerencia";
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery(query);
                    int i = 0;

                    while (rs.next()) {%>
            gerentes[gerentes.length] = "<%=rs.getString("gerente")%>";
            var departamento<%=i%> = [];

            <%i = i + 1;
                }

                query = "select depgerente, gerente from gerencia";
                rs = st.executeQuery(query);

                while (rs.next()) {

                    for (int e = 0; e < i; e++) {%>

            if (gerentes[<%=e%>] === "<%=rs.getString("gerente")%>") {
                departamento<%=e%>[departamento<%=e%>.length] = "<%=rs.getString("depgerente")%>";

            }
            <%}
                }%>
            function recargarlista1() {
                $("#listad").append("<option value=\"1\" label=\"Todos\"></option>");

            <%for (int e = 0; e < i; e++) {%>

                if (gerentes[<%=e%>] === $("#listag").val()) {

                    for (i = 0; i < departamento<%=e%>.length; i++) {
                        $("#listad").append("<option value='" + departamento<%=e%>[i] + "'>" + departamento<%=e%>[i] + "</option>");
                    }
                    ;
                }
                ;
            <%}%>
            }
            <%} catch (Exception e) {
                }%>

        </script>

        <script>

            $(document).ready(function () {
                $('#listam').change(function () {
                    $("#lista2").empty();
                    recargarlista();
                });
            });
            var departamentom = [];
            <%try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/requerimiento?zeroDateTimeBehavior=convertToNull", "root", "");
                    String query = "select departamento from depa";
                    Statement st = conn.createStatement();
                    ResultSet rs = st.executeQuery(query);
                    int i = 0;
                    while (rs.next()) {%>
            departamentom[departamentom.length] = "<%=rs.getString("departamento")%>";
            var encargados<%=i%> = [];
            <%i = i + 1;
                }
                query = "select departamento,encargado from encargados";
                rs = st.executeQuery(query);
                while (rs.next()) {
                    for (int e = 0; e < i; e++) {%>

            if (departamentom[<%=e%>] === "<%=rs.getString("departamento")%>") {
                encargados<%=e%>[encargados<%=e%>.length] = "<%=rs.getString("encargado")%>";

            }
            <%}
                }%>

            function recargarlista() {
                $("#lista2").append("<option value=\"1\" label=\"Seleccione\"></option>");
            <%for (int e = 0; e < i; e++) {%>
                if (departamentom[<%=e%>] === $("#listam").val()) {
                    for (i = 0; i < encargados<%=e%>.length; i++) {
                        $("#lista2").append("<option value='" + encargados<%=e%>[i] + "'>" + encargados<%=e%>[i] + "</option>");
                    }
                    ;
                }
                ;
            <%}%>
            }
            <%} catch (Exception e) {
                }%>

        </script>
        <style>
            table{
                border:black 2px solid;

                background: whitesmoke}

            body{background: appworkspace;}
        </style>
    </head>
    <body>
        
        <h1>Ingresar Requerimiento</h1>
        <hr>
        <form action="controlIngresa.con" method="POST">

            <table>

                <tr><td><br></td><td></td></tr>
                <tr>
                    <td>Gerencia</td><td><select id="listag" name="gerencia" style="width:200px" >
                            <option value="1" label="Seleccione"></option>
                            <%while (rsGer.next()) {%>
                            <option value="<%=rsGer.getString("gerente")%>" label="<%=rsGer.getString("gerente")%>"></option>
                            <%}%>
                        </select></td>
                </tr>

                <tr><td><br></td><td></td></tr>

                <tr>
                    <td>Departamento</td><td><select id="listad" name="departamentog" style="width:200px" >
                            <option value="1" label="Seleccione"></option>
                        </select></td>
                </tr>

                <tr><td><br></td><td></td></tr>

                <tr>
                    <td>Asignado a</td><td><select id="listam" style="width:200px" name="departamentosm">
                            <option value="1" label="Seleccione"></option>
                            <%while (rsAsig.next()) {%>                
                            <option value="<%=rsAsig.getString("departamento")%>" label="<%=rsAsig.getString("departamento")%>"></option>     
                            <%}%>
                        </select></td>
                </tr>

                <tr><td><br></td><td></td></tr>

                <tr>
                    <td>Encargado</td><td><select id="lista2" style="width:200px;" name="encargados">
                            <option value="1" label="Seleccione"></option>
                        </select></td>
                </tr>

                <tr><td><br></td><td></td></tr>

                <tr>
                    <td>Requerimiento :</td><td><input type='text' name='descripcion' style="width:200px;height:50px"></td>
                </tr>

                <tr><td><br></td><td></td></tr>

                <tr>
                    <td><input type='submit' value="Guardar" name="guardar"></td><td></td>
                </tr>
            </table>

        </form>
        <br>
        <%if (formato != null) {%>
        <p align="center"><%=formato%></p>
        <%}%>
        <br>
        <form action="Menu_principal.jsp">
            <input type='submit' value="Volver al menu principal"  size='12'>
        </form>
    </body>
</html>
