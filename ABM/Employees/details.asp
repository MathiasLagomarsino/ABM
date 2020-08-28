<!--#include file="../System/data/configuration.asp"-->


<!DOCTYPE html>

<%

DIM EmployeeID,result,objRs,objRsPhones
EmployeeID = Request.QueryString("EmployeeID")
result=request.querystring("result")

If IsNumeric(EmployeeID) = true Then
Set objRs = GetEmployee(EmployeeID)
Set objRsPhones = GetEmployeePhones(EmployeeID)
If objRs.EOF Then
response.redirect("http://localhost/employees/Default.asp?result=2")
End If

End If


%>

<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="../System/css/System.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Detalles del empleado</title>
  <script type="text/javascript" src="../System/jquery.js"></script>


</head>
<body>
  <div class="logo">
    <a href="http://www.infiniteloop.com.ar/index.asp">
      <img src="../images/infiniteloop-logo.svg" alt="Infinite Loop Logo" id="imglogo">
    </a>
  </div>

  <div class="topnav">
    <% If result > 0 Then %>
    <% Select Case result

    Case 1

    message = "Se han guardado los cambios satisfactoriamente"

    Case 2

    message = "Se ha agreado al empleado correctamente "

    End Select %>

    <div class="msgProcess">
      <h1 class="alert"><i class="fa fa-check"></i><%=message%> </h1>
    </div>

    <script language="javascript">

    $(".msgProcess").fadeOut(700);
    $(".msgProcess").fadeIn(100);
    setTimeout(function(){
      $(".msgProcess").remove();
    }, 3000);

    </script>
    <%End If%>

    <nav>
      <a href="http://www.infiniteloop.com.ar/index.asp" >
        <button class="button">
          <span>
            <i class="fa fa-home"></i> Inicio
          </span>
        </button>
      </a>
      <a href="Default.asp">
        <button class="button">
          <span>
            <i class="fa fa-users"></i> Lista de empleados
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
    <a href="default.asp">Lista de empleados ></a>
    <a href="details.asp">Detalles del empleado ></a>
  </nav>

  <div class="row">
    <div class="left"></div>
    <div class="middle">
      <br><br><br>
      <h1>Detalles del empleado</h1>

      <br><br><br><br><br>
      <form method="get" action="details.asp">
        <input type="hidden" name="EmployeeID" value="<%=EmployeeID%>">


        <i class="fa fa-user" id="user"></i>
        <br><br><br>

        <label id="EmployeeName" name="EmployeeName">Nombre: <%=objRs("EmployeeName")%></label>
        <br><br><br>
        <label id="EmployeeSurname" name="EmployeeSurname">Apellido:<%=objRs("EmployeeLastName")%></label>
        <br><br><br>
        <label id="bDay" name="bDay">Fecha de nacimiento:<%=objRs("EmployeeBirthDate")%></label>
        <br><br><br>
        <label id="EmployeeDni" name="EmployeeDni">DNI:<%=objRs("EmployeeDNI")%></label>
        <br><br><br>
        <label id="EmployeeRoleName" name="EmployeeRoleName">Cargo:<%=objRs("EmployeeRoleName")%></label>
        <br><br><br>
        <label id="EmployeeSalary" name="EmployeeSalary">Cargo:<%=objRs("EmployeeSalary")%></label>
        <br><br><br>
        <label  name="pos">Telefonos:</label>

        <%While not objRsPhones.EOF %>

        <label class="PhoneDetails" name="phone"><%=objRsPhones("EmployeePhone")%></label>

        <%objRsPhones.MoveNext%>

        <%Wend%>
        <br><br><br>
        <label id="dir" name="dir">Direccion:<%=objRs("EmployeeAddress")%></label>
        <br><br><br>
        <label id="mail" name="mail">Mail:<%=objRs("EmployeeeMail")%></label>
        <br><br><br>
      </form>
      <br><br><br><br><br><br>
      <a href="default.asp" class="btn">
        <i class="fa fa-angle-left">  Volver</i>
      </a>

      <a href="delete.asp?EmployeeID=<%=EmployeeID%>">
        <button class="btn">
          <i class="fa fa-trash" aria-hidden="true"></i>  Eliminar empleado
        </button>
      </a>
      <a href="add.asp?EmployeeID=<%=EmployeeID%>">
        <button class="btn">
          <i class="fas fa-user-edit"></i>Editar empleado
        </button>
      </a>


    </div>
    <div class="right"></div>
  </div>

</body>
</html>
