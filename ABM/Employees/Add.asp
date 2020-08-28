<!--#include file="../System/data/configuration.asp"-->
<!DOCTYPE html>

<%

DIM doAction
doAction = request.form("doAction")
EmployeeID = CInt(replaceNullValues(request("EmployeeID")))

If doAction = 1 Then
DIM EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeSalary,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhoneStr
EmployeeName = request.form("EmployeeName")
EmployeeLastName = request.form("EmployeeLastName")
EmployeeDNI = request.form("EmployeeDNI")
EmployeeRoleID = request.form("EmployeeRoleID")
EmployeeSalary = request.form("EmployeeSalary")
EmployeeAddress = request.form("EmployeeAddress")
EmployeeBirthDate = request.form("EmployeeBirthDay")
EmployeeeMail = request.form("EmployeeeMail")
EmployeePhonestr = request.form("phone")

If EmployeeID > 0 Then

If val = 1 Then ' Se guardaron los cambios correctamente'

response.redirect("http://localhost/employees/details.asp?result=1&EmployeeID="&EmployeeID)
response.end()

End If

Else

If val = 1 Then

response.redirect("http://localhost/employees/details.asp?result=2&EmployeeID="&EmployeeID)
response.end()

End If
End If
End If

If EmployeeID > 0 Then
Set objRs = GetEmployee(EmployeeID)
Set objRsPhones = GetEmployeePhones(EmployeeID)
doAction = 2

EmployeeName = Trim(objRs("EmployeeName"))
EmployeeLastName= Trim(objRs("EmployeeLastName"))
EmployeeDNI= replaceNullValues(objRs("EmployeeDNI"))
EmployeeRoleID= replaceNullValues(objRs("EmployeeRoleID"))
EmployeeSalary= Trim(objRs("EmployeeSalary"))
EmployeeAddress= Trim(objRs("EmployeeAddress"))
EmployeeBirthDate = objRs("EmployeeBirthDate")
EmployeeeMail= Trim(objRs("EmployeeeMail"))

objRs.Close()
Set ObjRs = Nothing

Else

EmployeeName = ""
EmployeeLastName = ""
EmployeeDNI = ""
EmployeeRoleID = "0"
EmployeeSalary = ""
EmployeeAddress= ""
EmployeeBirthDate = ""
EmployeeeMail= ""
EmployeePhoneStr= ""

End If

%>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="../System/css/System.css">
  <link rel="icon" rel="../images/infiniteloop-logo.svg">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Agregar empleado</title>
  <script type="text/javascript" src="../System/jquery.js"></script>
  <script type="text/javascript" src="../System/validate.js?a=4"></script>
  <script type="text/javascript" src="Add.js"></script>

  <script type="text/javascript">

  $(document).ready(() =>{

    <% If EmployeeID = 0 Then %>
    splitF();
    <% Else%>
    $(".tel:last").val(<%=objRsPhones("EmployeePhone")%>)
    <%objRsPhones.MoveNext%>
    <% If not objRsPhones.EOF Then%>
    <%While not objRsPhones.EOF
    %>

    addPhEdit(<%=objRsPhones("EmployeePhone")%>);

    <%objRsPhones.MoveNext
    Wend
    objRsPhones.Close
    Set objRsPhones = Nothing
    End If
    End If%>

  });

  function splitF()
  {

    var doAction = "<%=doAction%>";
    if(doAction == 1)
    {

      for(quant in phoneSplit)
      {
        if (quant > 0)
        addPh(phoneSplit[quant]);
        console.log(phoneSplit);
      }
    }
  }
  </script>
</head>
<body>
  <div class="logo">
    <a href="http://www.infiniteloop.com.ar/index.html">
      <img src="../Images/infiniteloop-logo.svg" alt="Infinite Loop Logo" id="imglogo">
    </a>
  </div>
  <div class="topnav">

    <% If val = 2 Then %>

    <div class="msgProcess">
      <h1 class="error"><i class="fa fa-times "></i>Hubo un error en la base de datos</h1>
    </div>

    <script language="javascript">

    $(".error").fadeOut(700);
    $(".error").fadeIn(100);

    setTimeout(function(){
      $(".msgProcess").remove();
    }, 3000);

    </script>
    <%End If%>
    <% If doAction = 1 Then %>

    <div class="msgProcess">
      <h1 class="error" id="error"><i class="fa fa-times "></i><%=ErrorDesc%></h1>
    </div>

    <script language="javascript">

    $(".error").fadeOut(700);
    $(".error").fadeIn(100);

    setTimeout(function(){
      $(".msgProcess").remove();
    }, 3000);

    </script>
    <%End If%>
    <nav>
      <a href="http://www.infiniteloop.com.ar/index.html">
        <button class="button">
          <span>
            <i class="fa fa-home"></i> Inicio
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
      <a href="https://www.facebook.com/infiniteLoopSA/?fref=nf">
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
    <a href="default.asp">Lista de empleados></a>
    <% If EmployeeID > 0 Then %>
    <a href="edit.asp?EmployeeID=<%=EmployeeID%>">Editar empleado</a>
    <% End If %>

    <% If EmployeeID = 0 Then %>
    <a href="edit.asp?EmployeeID=<%=EmployeeID%>">Agregar empleado</a>
    <% End If %>

  </nav>

  <div class="row">
    <div class="left"></div>
    <div class="middle">

      <form method="post" action="Add.asp?EmployeeID=<%=EmployeeID%>">

        <% If EmployeeID=0 Then 'AddEmployee %>
        <input type="hidden"id="doAction" name="doAction" value=3>
        <% End If %>

        <% If EmployeeID > 0 Then 'EditEmployee %>
        <input type="hidden"id="doAction" name="doAction" value=2>
        <% End If %>

        <input type="hidden" name="result" value="<%=result%>">
        <input type="hidden" id="EmployeeID" name="EmployeeID" value="<%=EmployeeID%>">

        <br><br><br>
        <% If EmployeeID > 0 Then %>
        <h1>Editar empleado</h1>
        <% End If %>

        <% If EmployeeID = 0 Then %>
        <h1>Agregar empleado</h1>
        <% End IF %>
        <br><br><br><br><br><br><br><br>
        <div>
          <label>Nombre:</label>
          <div class="namDiv">
            <input type="text" id="EmployeeName" name="EmployeeName" value="<%=EmployeeName%>"  placeholder="Ingrese nombre" maxlength=20>
          </div>

          <label>Apellido:</label>
          <div class="surDiv">
            <input type="text" id="EmployeeLastName" name="EmployeeLastName" value="<%=EmployeeLastName%>" placeholder="Ingrese apellido" maxlength=20>
          </div>
          <br><br><br>
          <label>Fecha de nacimiento:</label>
          <div class="bDaydiv">
            <input type="date" id="EmployeeBirthDate" name="EmployeeBirthDay" value="<%=EmployeeBirthDate%>" placeholder="Ingrese fecha de nacimiento: DD/MM/AAAA">
          </div>
          <br><br><br>
          <label>DNI:</label>
          <div class="dniDiv">
            <input type="text" id="EmployeeDNI" name="EmployeeDNI" value="<%=EmployeeDNI%>" placeholder="Ingrese DNI" maxlength=8>
          </div>
          <br><br><br>
          <label>Cargo:</label>
          <select id="EmployeeRoleID" name="EmployeeRoleID" >
            <option value="0" <%If EmployeeRoleID = 0 Then%> selected <%End If%> >Seleccione Cargo</option>
            <option value="1" <%If EmployeeRoleID = 1 Then%> selected <%End If%> >Pasante</option>
            <option value="2" <%If EmployeeRoleID = 2 Then%> selected <%End If%> >Administracion</option>
            <option value="3" <%If EmployeeRoleID = 3 Then%> selected <%End If%> >Desarrollador</option>
          </select>
          <div class="posDiv">
          </div>
          <br><br><br>
          <div class="salaryDiv">
            <label> Salario</label>
            <input type="text" id="EmployeeSalary" name="EmployeeSalary"  value="<%=EmployeeSalary%>" placeholder="Ingrese Salario del empleado" maxlength=25>
          </div>
          <br><br><br>
          <label>Telefono/s</label>
          <div class="phDiv">
            <button type="button" class="addphone">
              <i class="loading fa fa-plus"></i>
            </button>

            <br><br>
            <input type="text" id="ph1" name="phone" telid="01" class="tel" value="<%=EmployeePhoneStr%>" placeholder="Ingrese telefono" maxlength=15>

          </div>
          <br><br><br><br>
          <label>Direccion:</label>
          <div class="dirDiv">
            <input type="text" id="EmployeeAddress" name="EmployeeAddress" value="<%=EmployeeAddress%>" placeholder="Ingrese direccion Aa 000, Aa">
          </div>
          <br><br>
          <label>Mail:</label>
          <div class="mailDiv">
            <input type="text" id="EmployeeeMail" name="EmployeeeMail"  value="<%=EmployeeeMail%>" placeholder="Ingrese mail" maxlength=30>
          </div>

          <% If EmployeeID > 0 Then %>
          <br><br><br>
          <input type="checkbox" name="EmployeeDelete" id="EmployeeDelete" class="delCh">Eliminar Empleado
          <% End If %>
          <br><br><br><br>

          <a href="Default.asp" class="btn">
            <i class="fa fa-angle-left">  Volver</i>
          </a>

          <input type="submit" class="val" value="Confirmar cambios">
        </form>


        <br><br><br><br>
      </div>
    </div>
    <div class="right">
    </div>
  </div>
</body>
</html>
