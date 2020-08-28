<!--#include file="../../System/autocomplete/core/JSON_2.0.3.asp"-->
<!--#include file="../../System/autocomplete/core/JSON_UTIL_0.1.1.asp"-->
<!--#include file="../../System/data/configuration.asp"-->
<%
textToSearch = request("Q")
doAction = request("doAction")


DIM EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhoneStr
  EmployeeName = request("EmployeeName")
  EmployeeLastName = request("EmployeeLastName")
  EmployeeDNI = request("EmployeeDNI")
  EmployeeRoleID = request("EmployeeRoleID")
  EmployeeSalary = request("EmployeeSalary")
  EmployeeAddress = request("EmployeeAddress")
  EmployeeBirthDate = request("EmployeeBirthDate")
  EmployeeeMail = request("EmployeeeMail")
  EmployeePhonestr = request("EmployeePhonestr")
  EmployeeID = request("EmployeeID")
  EmployeeDelete = request("EmployeeDelete")
  
If doAction = 1 Then 'Busqueda
    strSQLSelect =  "SELECT *"
      
        strSQLSelect = strSQLSelect & " FROM VW_ML_Employees WITH(NOLOCK) " 
        strSQLSelect = strSQLSelect & " WHERE EmployeeName LIKE CONCAT('%' ,'" & textToSearch & "', '%') "
        strSQLSelect = strSQLSelect & " OR EmployeeLastName LIKE CONCAT('%' ,'" & textToSearch & "', '%') "
        strSQLSelect = strSQLSelect & " OR EmployeeRoleName LIKE CONCAT('%' ,'" & textToSearch & "', '%') "
        strSQLSelect = strSQLSelect & " OR EmployeeDNI LIKE CONCAT('%' ,'" & textToSearch & "', '%') "
        
        Response.ContentType = "application/json" 
        'response.Write strSQLSelect
        QueryToJSON(strSQLSelect).Flush
        Response.End()
End If

If doAction = 2 Then ' Edicion

    Response.ContentType = "application/json"
    
    val = EditEmployee(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeSalary,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhonestr,EmployeeDelete,EmployeeID,errorDesc)
    response.write("{""success"" : " & val & ", ""errorDesc"": """& errordesc &""" }")
   
   
End If

If doAction = 3 Then 'Agregar Empleado

    Response.ContentType = "application/json"
    
    val = AddEmployee(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeSalary,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhonestr,EmployeeID,errorDesc)
    response.write("{""success"" : " & val & ", ""errorDesc"": """& errordesc &""" }")
   
End If
%>