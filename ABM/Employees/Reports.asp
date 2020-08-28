<!--#include file="../System/data/configuration.asp"-->

<!DOCTYPE HTML>
<%
%>
<html>
<head>
  <meta charset="utf-8">
  <link rel="stylesheet" type="text/css" href="../System/css/System.css">
  <link rel="icon" href="../images/infiniteloop-logo.svg">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
  <link rel="stylesheet" type="text/css" href="../System/autocomplete/jquery.autocomplete.css"/>
  <title>Lista de Reportes</title>
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

    <a href="default.asp">Lista de Empleados ></a>
    <a href="Reports.asp">Reporte de salarios></a>

  </nav>

  <div class="row">
    <div class="left" ></div>
    <div class="middle">
      <br>


      <br>
      <h1>Reporte de salarios</h1>

      <br><br><br>

      <br><br><br>
      <div>
        <br><br>

        <form method="post" action="Reports.asp">

        </form>
        <br><br>
      </div>
      <br><br>

      <%

      Set objRs = GetSalaryReport()
      %>
      <table>
        <tr>
          <th>Rol</th>
          <th>Total</th>
          <th>Promedio</th>
          <th>Maximo</th>
        </tr>

        <tbody>

          <% While not objRs.EOF %>
          <tr>
            <td><%=objRs("EmployeeRoleName")%></td>
            <td><%=objRs("Salary")%></td>
            <td><%=objRs("AvgSalary")%></td>
            <td><%=objRs("MaxSalary")%></td>
          </tr>
          <%objRs.MoveNext%>
          <%wend%>
        </tbody>
      </table>
        
    </div>
    <div class="right">
    </div>
  </div>

</body>
</html>
