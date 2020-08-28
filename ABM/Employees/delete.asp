<!--#include file="../System/data/configuration.asp"-->


<!DOCTYPE html>

<%

DIM result,id
EmployeeID = request.queryString("EmployeeID")
doAction = request.form("doAction")
Set objRs = GetEmployee(EmployeeID)

If doAction = 1 Then
val = DeleteEmployee(EmployeeID)
If val = 1 Then
response.redirect("http://localhost/employees/Default.asp?result=1")
response.end()
End If
If objRs.EOF Then
response.redirect("http://localhost/employees/Default.asp?result=2")
response.end()
End If
End If

%>

<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="../System/css/System.css">
  <link rel="icon" href="../images/infiniteloop-logo.svg">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Eliminar empleado</title>
  <script type="text/javascript" src="../System/jquery.js">
  </script>
  <script type="text/javascript" src="../Employees/delete.js">
  </script>


  <script type="text/javascript">



  </script>
</head>
<body>
  <div class="logo">
    <a href="http://www.infiniteloop.com.ar/index.html">
      <img src="../images/infiniteloop-logo.svg" alt="Infinite Loop Logo" id="imglogo" height="48" width="270">
    </a>
  </div>
  <div class="topnav">
    <nav>
      <a href="http://www.infiniteloop.com.ar/index.html" >
        <button class="button">
          <span>
            <i class="fa fa-home">
            </i> Inicio
          </span>
        </button>
      </a>
      <a href="Default.asp">
        <button class="button">
          <span>
            <i class="fa fa-users">
            </i> Lista de empleados
          </span>
        </button>
      </a>
      <a href="https://www.facebook.com/infiniteLoopSA/?fref=nf" >
        <button class="button">
          <span>
            <i class="fa fa-at">
            </i>  Nuestro Facebook
          </span>
        </button>
      </a>
    </nav>
  </div>
  <nav class="breadcrumb">
    <a href="default.asp">Lista de empleados>
    </a>
    <a href="edit.asp">Editar empleado>
    </a>
    <a href="delete.asp">Eliminar empleado>
    </a>
  </nav>

  <div class="row">
    <div class="left"></div>
    <div class="middle">
      <br><br><br>
      <h1>Eliminar empleado</h1>
      <br><br><br><br><br>
      <i class="fa fa-user" id="user"></i>
      <br><br><br>

      <label id="nomemp">Nombre:<%=objRs("EmployeeName")%></label>
      <br><br>
      <label id="suremp">Apellido:<%=objRs("EmployeeLastName")%></label>
      <br><br>
      <label id="DNI">DNI:<%=objRs("EmployeeDNI")%></label>

      <br><br><br><br><br><br>

      <input type="checkbox" id="check" name="delete" class="checkbox" value="delete"> ¿Esta seguro de que desea eliminar al empleado?<br>
      <br>
      <div class="checkDiv">

        <form method="POST" action="delete.asp?EmployeeID=<%=objRs("EmployeeID")%>">
          <input type="hidden" name="EmployeeID" value="<%=EmployeeID%>">
          <input type="hidden" name="doAction" value="1">

          <a href="details.asp" class="btn"><i class="fa fa-angle-left">  Volver</i></a>
          <input type="submit" class="botn" placeholder="Eliminar empleado">

        </form>
        <br>
      </div>

    </div>
    <div class="right"></div>
  </div>

</body>
</html>
