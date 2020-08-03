
<%@page import="modelo.Conexion"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String query1 = (String) request.getAttribute("mensaje");
    Conexion con = new Conexion();
    ResultSet rsGer = con.listarGerencia();
    ResultSet rsAsig = con.listarDepartamento();
    ResultSet rsReq = con.consultaRequerimiento(query1);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Consultar Requerimiento</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>
            $(document).ready(function () {

                $('#listag').change(function () {

                    $("#listad").empty();

                    recargarlista();
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
            function recargarlista() {
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
        <style>
            .ancho th {width:150px;}
            .ancho td {width:150px;height:100px}
            table{
                border:black 2px solid;

                background: whitesmoke;
            
            }

            body{background: appworkspace;}
            
            #div1 {
                overflow: scroll;
                height: 200px;
                width: 1000px
            }
            
            #div1 table {
                
                width: 950px
            }
            .sticky {
                position: fixed;
                background: #ffffff
            }
            
        </style>
    </head>
    <body>
        <h1>Consultar Requerimientos</h1>
        <hr>

        <form action="controlConsulta.con" method="post">
            
            
                <table>
                <tr>
                    <td>Gerencia</td><td><select id="listag" name="gerencia" style="width:200px" >
                            <option value="1" label="Todos"></option>
                            <%while (rsGer.next()) {%>
                            <option value="<%=rsGer.getString("gerente")%>" label="<%=rsGer.getString("gerente")%>"></option>
                            <%}%>
                        </select></td>
                </tr>

                <tr>
                    <td><br></td><td></td>
                </tr>

                <tr>
                    <td>Departamento</td><td><select id="listad" name="departamentog" style="width:200px" >
                            <option value="1" label="Todos"></option>
                        </select></td>
                </tr>

                <tr>
                    <td><br></td><td></td>
                </tr>

                <tr>
                    <td>Asignado a</td><td><select style="width:200px" name="departamentosm">
                            <option value="1" label="Todos"></option>
                            <%while (rsAsig.next()) {%>                
                            <option value="<%=rsAsig.getString("departamento")%>" label="<%=rsAsig.getString("departamento")%>"></option>     
                            <%}%>
                        </select></td>
                </tr> 

                <tr>
                    <td><br></td><td></td>
                </tr>
                <tr><td><input type='submit' value="Buscar" name="Buscar"></td><td></td></tr>
                <tr><td><input type='hidden' name="acto" value="3"></td><td></td>
                </tr>

            </table>
            <br><br><br>
            <div id="div1">
            <table border="4" class="ancho">
                <tr class="sticky">
                    <th>Gerencia</th>
                    <th>Departamento</th>
                    <th>Asignado a</th>
                    <th>Encargado</th>
                    <th>Requerimiento</th>
                    <th>Estado</th>
                </tr>

                <%while (rsReq.next()) {%>

                <tr>
                    <td><%=rsReq.getString("gerencia")%></td>
                    <td><%=rsReq.getString("departamento")%></td>
                    <td><%=rsReq.getString("departamentom")%></td>
                    <td><%=rsReq.getString("encargado")%></td>
                    <td><%=rsReq.getString("requerimiento")%></td>
                    <td><%=rsReq.getString("estado")%></td>
                </tr>

                <%}%>

            </table>
            </div>

               
        </form>
        <br><br><br>
        <form action="Menu_principal.jsp">
            <input type='submit' value="Volver al menu principal"  size='12'>
        </form>
    </body>
</html>
