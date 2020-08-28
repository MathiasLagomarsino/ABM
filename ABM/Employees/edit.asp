<!--#include file="../System/data/configuration.asp"-->


<!DOCTYPE html>

<%
DIM doAction
doAction = request.form("doAction")
EmployeeID = request("EmployeeID")

Set objRs = GetEmployee(EmployeeID)
Set objRsPhones = GetEmployeePhones(EmployeeID)
If doAction = 1 Then 'funciona'

DIM objRs,objRsPhones,EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhoneStr,errorDesc
EmployeeName = request.form("namEmp")
EmployeeLastName= request.form("surEmp")
EmployeeDNI= request.form("dni")
EmployeeRoleID= request.form("pos")
EmployeeAddress= request.form("dir")
EmployeeBirthDate = request.form("bDay")
EmployeeeMail= request.form("mail")
EmployeePhones= request.form("phone")

val = EditEmployee(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhoneStr,EmployeeID,errorDesc)
If objRs.EOF = False Then ' Se guardaron los cambios correctamente'
response.redirect("http://localhost/employees/details.asp?result=1&EmployeeID="&EmployeeID)
response.end()
End If


End If





%>

<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="../System/css/System.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <title>Editar empleado</title>
  <script type="text/javascript" src="../System/jquery.js"></script>
  <script type="text/javascript" src="../System/validate.js?a=1"></script>

  <script type="text/javascript">

  $(document).ready(() =>{


    <% If not objRsPhones.EOF Then %>
    <%While not objRsPhones.EOF
    EmployeePhone = objRsPhones("EmployeePhone")%>

    addPhEdit(<%=EmployeePhone%>);

    <%objRsPhones.MoveNext
    Wend%>
    <% End If %>
  });



  function splitF()
  {
    var doAction = "<%=doAction%>";
    if(doAction == 1)
    {
      var namEmp = "<%=EmployeeName%>";
      var surEmp = "<%=surEmp%>";
      var bDay = "<%=bDay%>";
      var dni = "<%=dni%>";
      var pos = "<%=pos%>";
      var dir = "<%=dir%>";
      var mail = "<%=mail%>";
      var phones="<%=phone%>";

      var phoneSplit= phones.split(", ");
      $("#ph1").val(phoneSplit[0]);
      $("#namEmp").val(namEmp);
      $("#surEmp").val(surEmp);
      $("#bDay").val(bDay);
      $("#dni").val(dni);
      $("#pos").val(pos);
      $("#dir").val(dir);
      $("#mail").val(mail);


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
      <img src="../images/infiniteloop-logo.svg" alt="Infinite Loop Logo" id="imglogo">
    </a>
  </div>
  <div class="topnav">
    <% If doAction = 1 Then %>

    <div class="msgProcess">
      <h1 class="alert"><i class="fa fa-check"></i><%=ErrorDesc%> </h1>
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
      <a href="http://www.infiniteloop.com.ar/index.html" >
        <button class="button">
          <span>
            <i class="fa fa-home"></i> Inicio
          </span>
        </button>
      </a>
      <a href="Default.asp"><button class="button">
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
  <a href="edit.asp">Editar empleado ></a>
</nav>

<div class="row">
  <div class="left"></div>
  <div class="middle">

    <form method="post" action="edit.asp">
      <input type="hidden" name="EmployeeID" value="<%=EmployeeID%>">
      <input type="hidden" name="doAction" value=1>
      <input type="hidden" name="result" value=1>

      <h1>Editar empleado</h1>
      <br><br><br><br><br><br>
      <i class="fa fa-user" id="user"></i>
      <div class="namDiv">
        <label>Nombre:</label>
        <input type="text" id="namEmp" name="namEmp" placeholder="Nombre:" value="<%=objRs("EmployeeName")%>">
      </div>

      <div class="surDiv">
        <label>Apellido:</label>
        <input type="text" id="surEmp" name="surEmp" placeholder="Apellido:" value="<%=objRs("EmployeeLastName")%>">
      </div>
      <div class="bDaydiv">
        <label>Fecha de nacimiento:</label>
        <input type="date" id="bDay" name="bDay"placeholder="Ingrese fecha de nacimiento: DD/MM/AAAA" value="<%=objRs("EmployeeBirthDate")%>">
      </div>
      <div class="dniDiv">
        <label>DNI:</label>
        <input type="text" id="dni" name="dni" placeholder="DNI:" maxlength="8" value="<%=objRs("EmployeeDNI")%>">
      </div>
      <br><br><br>
      <label>Cargo:</label>
      <select id="pos" name="pos" >
        <option value="0" <%If objRs("EmployeeRoleID") = 0 Then%> selected <%End If%> >Seleccione Cargo</option>
        <option value="1" <%If objRs("EmployeeRoleID") = 1 Then%> selected <%End If%> >Pasante</option>
        <option value="2" <%If objRs("EmployeeRoleID") = 2 Then%> selected <%End If%> >Administracion</option>
        <option value="3" <%If objRs("EmployeeRoleID") = 3 Then%> selected <%End If%> >Desarrollador</option>
      </select>
      <div class="posDiv">
      </div>
      <br>
      <div class="phDiv">
        <label>Teléfono/s:</label>

        <br><br><br>
        <button type="button" class="addphone">
          <i class="loading fa fa-plus"></i>
        </button>
        <br><br><br>

      </div>
      <div class="dirDiv">
        <label>Dirección:</label>
        <input type="text" id="dir" name="dir" placeholder="Direccion:" value="<%=objRs("EmployeeAddress")%>">
      </div>
      <div class="mailDiv">
        <label>Mail:</label>
        <input type="text" id="mail" name="mail"placeholder="Mail:" value="<%=objRs("EmployeeeMail")%>">
      </div>
      <br><br><br><br><br><br>

      <a href="Default.asp" class="btn">
        <i class="fa fa-angle-left">  Volver</i>
      </a>
      <input type="submit" class="val" value="Confirmar cambios">
    </form>
    <br><br><br><br>
  </div>
  <div class="right"></div>
</div>
</body>
</html>
