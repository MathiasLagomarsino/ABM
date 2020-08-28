<!--#include file="../System/data/configuration.asp"-->

<!DOCTYPE HTML>
<%
dim doAction
doAction = request.form("doAction")
dim result
result = request.querystring("result")

If doAction = 1 Then
DIM search
search = request.form("search")
EmployeeName = request.form("namEmp")
EmployeeLastName= request.form("surEmp")
EmployeeRoleID= request.form("pos")
EmployeeDNI= request.form("dni")

End If

%>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="../System/css/System.css">
  <link rel="icon" href="../images/infiniteloop-logo.svg">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="../System/autocomplete/jquery.autocomplete.css"/>
  <title>Lista de empleados</title>
  <script type="text/javascript" src="../System/jquery.js"></script>
  <script type="text/javascript" src="Default.js"></script>

  <script type="text/javascript" language="javascript" src="../System/autocomplete/core/jquery.autocomplete.v1.2.js"></script>


</head>
<body>

  <div class="logo">
    <a href="http://www.infiniteloop.com.ar/index.html">
      <img src="../images/infiniteloop-logo.svg" alt="Infinite Loop Logo" id="imglogo" >
    </a>
  </div>
  <div class="topnav">
    <% If result = 1 Then %>
    <div class="msgProcess">
      <h1 class="alert"> El empleado ha sido eliminado satisfactoriamente</h1>
    </div>

    <script language="javascript">

    $(".msgProcess").fadeOut(700);
    $(".msgProcess").fadeIn(100);
    setTimeout(function()
    {
      $(".msgProcess").remove();
    }, 2000);
    </script>
    <% End If %>

    <% If result = 2 Then %>
    <div class="msgProcess">
      <h1 class="warning"><i class="fa fa-exclamation-circle"></i> No se ha encontrado al empleado</h1>
    </div>
    <script language="javascript">

    $(".msgProcess").fadeOut(700);
    $(".msgProcess").fadeIn(100);
    setTimeout(function()
    {
      $(".msgProcess").remove();
    }, 2000);
    </script>
    <% End If %>

    <nav>
      <a href="http://www.infiniteloop.com.ar/index.html">
        <button class="button">
          <span>
            <i class="fa fa-home">
            </i> Inicio
          </span>
        </button>
      </a>
      <a href="https://www.facebook.com/infiniteLoopSA/?fref=nf">
        <button class="button">
          <span>
            <i class="fa fa-at"></i>  Nuestro Facebook
          </span>
        </button>
      </a>
    </nav>
  </div>
  <nav class="breadcrumb">

    <a href="Roles.asp">Roles de los Empleados ></a>
  </nav>

  <div class="row">
    <div class="left" ></div>
    <div class="middle">
      <br>

      <br>
      <h1>Lista de Empleados</h1>

      <br><br><br>
      <% If doAction = 0 Then %>
      <h2> Presione enter en la busqueda para mostrar la lista de empleados </h2>
      <% End If %>
      <br><br><br>
      <div>
        <label class="lbdefault">Buscar empleado/s:</label>
        <br><br>
        <form method="post" action="Roles.asp">
          <input type="hidden" name="doAction" value=1>

          <input type="text" id="search" name="search" placeholder="Buscar Empleado:">
          <input type="submit" class="botn" value="Buscar empleado">

          <a href="add.asp" class="btn">
            <i class="fa fa-user-plus">Agregar Empleado
            </i>
          </a>
          <br><br>
          <a href="Roles.asp" class="repbtn">
            <i class="fa fa-money-check">Reportes de los Empleados
            </i>
          </a>

        </form>
        <br><br>
      </div>
      <br><br><br><br><br>

      <%  If doAction = 1 Then
      Set objRs = SearchRoleReport(search)
      AuxRoleID = 0
      While not objRs.EOF

      If AuxRoleID <> objRs("EmployeeRoleID") Then
      If AuxRoleID <> 0 Then  %>
    </tbody>
  </table>
  <% End IF %>
  <h1><%=objRs("EmployeeRoleName")%></h1>
  <table>

    <tbody>
      <tr>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Cargo</th>
        <th>DNI</th>
        <th>Acciones</th>
      </tr>

      <%AuxRoleID = objRs("EmployeeRoleID")
      End If %>

      <tr>
        <td><%=objRs("EmployeeName")%></td>
        <td><%=objRs("EmployeeLastName")%></td>
        <td><%=objRs("EmployeeRoleName")%></td>
        <td><%=objRs("EmployeeDNI")%></td>
        <td class="buttons">
          <a href="details.asp?EmployeeID=<%=objRs("EmployeeID")%>"><img src="../images/notepad.png" class="tableimg" alt="Detalles del empleado" height="30" width="30"></a>
          <a href="add.asp?EmployeeID=<%=objRs("EmployeeID")%>"><img src="../images/pencil.png" class="tableimg" alt="Modificar empleado" height="30" width="30"> </a>
        </td>
      </tr>

      <%objRs.MoveNext
      Wend
      End If %>

    </div>
    <div class="right">
    </div>
  </div>

</body>
</html>
