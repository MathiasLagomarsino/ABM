<%

Function AddEmployee(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmlpoyeeSalary,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhoneStr,EmployeeID,errorDesc)

Dim objRs,objCmd,objConn

Set objConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.Recordset")
Set objCmd = Server.CreateObject("ADODB.Command")

objConn.Open sSCN_CnxString
objRs.CursorLocation = 3

With objCmd
Set .ActiveConnection = objConn
.CommandText = "SP_ML_Employees_Add"
.CommandType = 4
.CommandTimeout = 0
.Prepared = true

'Input Parameters
.Parameters.Append .CreateParameter("RETURN_VALUE", 3, 4)
.Parameters.Append .CreateParameter("@EmployeeID",3,2,1)
.Parameters.Append .CreateParameter("@EmployeeName", 129, 1, 15, Trim(EmployeeName))
.Parameters.Append .CreateParameter("@EmployeeLastName", 129, 1, 30, Trim(EmployeeLastName))
.Parameters.Append .CreateParameter("@EmployeeDNI", 3, 1, 1,EmployeeDNI)
.Parameters.Append .CreateParameter("@EmployeeRoleID", 3, 1, 1, EmployeeRoleID)
.Parameters.Append .CreateParameter("@EmployeeSalary", 6, 1, 26, EmployeeSalary)
.Parameters.Append .CreateParameter("@EmployeeAddress", 129, 1, 100,Trim(EmployeeAddress))
.Parameters.Append .CreateParameter("@EmployeeBirthDate",129,1,10,Trim(EmployeeBirthDate))
.Parameters.Append .CreateParameter("@EmployeeeMail",129,1,50,Trim(EmployeeeMail))
.Parameters.Append .CreateParameter("@EmployeePhonestr", 129, 1,-1, Trim(EmployeePhoneStr))
.Parameters.Append .CreateParameter("@ErrorDesc",129,2,500)
End With

'debugParamAttribs2(objCmd)
objCmd.Execute
SP_RV = objCmd.Parameters("RETURN_VALUE")
ErrorDesc = objCmd.Parameters("@ErrorDesc")
EmployeeID = objCmd.Parameters("@EmployeeID")
AddEmployee = SP_RV


Set objCmd = Nothing
objConn.Close
Set objConn = Nothing

End Function



Function searchEmployee(search,EmployeeName,EmployeeLastName,EmployeeRoleID,EmployeeDNI)

Dim objRs,objCmd,objConn

Set objConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.Recordset")
Set objCmd = Server.CreateObject("ADODB.Command")

objConn.Open sSCN_CnxString
objRs.CursorLocation = 3

With objCmd
Set .ActiveConnection = objConn
.CommandText = "SP_ML_Employees_Search"
.CommandType = 4
.CommandTimeout = 0
.Prepared = true

'Input Parameters
.Parameters.Append .CreateParameter("RETURN_VALUE", 3, 4)
.Parameters.Append .CreateParameter("@Filter", 129, 1, Len(Trim(Search)) +1, Trim(search))

'.Parameters.Append .CreateParameter("@EmployeeName", 129, 1, 15, EmployeeName)
'.Parameters.Append .CreateParameter("@EmployeeLastName", 129, 1, 30, EmployeeLastName)
'.Parameters.Append .CreateParameter("@EmployeeRoleID",3,1,EmployeeRoleID)
'.Parameters.Append .CreateParameter("@EmployeeDNI", 3, 1,EmployeeDNI)
End With
objRs.Open objCmd, , 3, 1, 4
'int_SP_RV = obj.Cmd.Parameters("RETURN_VALUE")

'debugParamAttribs2(objCmd)
SP_RV = objCmd.Parameters("RETURN_VALUE")

Set searchEmployee = objRs
Set objCmd = Nothing

End Function



Function EditEmployee(EmployeeName,EmployeeLastName,EmployeeDNI,EmployeeRoleID,EmployeeSalary,EmployeeAddress,EmployeeBirthDate,EmployeeeMail,EmployeePhonestr,EmployeeDelete,EmployeeID,errorDesc)

Dim objRs,objCmd,objConn

Set objConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.Recordset")
Set objCmd = Server.CreateObject("ADODB.Command")

objConn.Open sSCN_CnxString
objRs.CursorLocation = 3
response.write(EmployeeSalary)
With objCmd
Set .ActiveConnection = objConn
.CommandText = "SP_ML_Employees_Edit"
.CommandType = 4
.CommandTimeout = 0
.Prepared = true

'Input Parameters
.Parameters.Append .CreateParameter("RETURN_VALUE", 3, 4)
.Parameters.Append .CreateParameter("@EmployeeID",3,1,1,Trim(EmployeeID))
.Parameters.Append .CreateParameter("@EmployeeName", 129, 1, 15, Trim(EmployeeName))
.Parameters.Append .CreateParameter("@EmployeeLastName", 129, 1, 30, Trim(EmployeeLastName))
.Parameters.Append .CreateParameter("@EmployeeDNI", 3, 1, 1, Trim(EmployeeDNI))
.Parameters.Append .CreateParameter("@EmployeeRoleID", 3, 1, 1, Trim(EmployeeRoleID))
.Parameters.Append .CreateParameter("@EmployeeSalary", 6, 1, 26,EmployeeSalary)
.Parameters.Append .CreateParameter("@EmployeeAddress", 129, 1, 100, Trim(EmployeeAddress))
.Parameters.Append .CreateParameter("@EmployeeBirthDate", 129, 1, 10, Trim(EmployeeBirthDate))
.Parameters.Append .CreateParameter("@EmployeeeMail",129,1,50,Trim(EmployeeeMail))
.Parameters.Append .CreateParameter("@EmployeePhonestr", 129, 1,Len(Trim(EmployeePhonestr))+1, Trim(EmployeePhonestr))
.Parameters.Append .CreateParameter("@EmployeeDelete", 11, 1, 1, EmployeeDelete)
.Parameters.Append .CreateParameter("@ErrorDesc",129,2,500)
End With

'debugParamAttribs2(objCmd)
objCmd.Execute
SP_RV = objCmd.Parameters("RETURN_VALUE")
ErrorDesc = objCmd.Parameters("@ErrorDesc")
EditEmployee = SP_RV


Set objCmd = Nothing

objConn.Close
Set objConn = Nothing

End Function



Function GetEmployee(EmployeeID)
Dim strSQL

strSQL = "SELECT * FROM VW_ML_Employees WHERE EmployeeID ="

strSQL = strSQL & EmployeeID

Set GetEmployee = getADORecordSet(strSQL)

End Function



Function DeleteEmployee(EmployeeID)

Dim objRs,objCmd,objConn

Set objConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.Recordset")
Set objCmd = Server.CreateObject("ADODB.Command")

objConn.Open sSCN_CnxString
objRs.CursorLocation = 3

With objCmd
Set .ActiveConnection = objConn
.CommandText = "SP_ML_Employees_Delete"
.CommandType = 4
.CommandTimeout = 0
.Prepared = true

'Input Parameters
.Parameters.Append .CreateParameter("RETURN_VALUE", 3, 4)
.Parameters.Append .CreateParameter("@EmployeeID",3,1,1,EmployeeID)
.Parameters.Append .CreateParameter("@ErrorDesc",129,2,500)
End With

'debugParamAttribs2(objCmd)
objCmd.Execute
SP_RV = Cint(objCmd.Parameters("RETURN_VALUE"))
ErrorDesc = objCmd.Parameters("@ErrorDesc")

DeleteEmployee = SP_RV


Set objCmd = Nothing

objConn.Close
Set objConn = Nothing

End Function



Function SearchRoleReport(search)

Dim objRs,objCmd,objConn

Set objConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.Recordset")
Set objCmd = Server.CreateObject("ADODB.Command")

objConn.Open sSCN_CnxString
objRs.CursorLocation = 3

With objCmd
Set .ActiveConnection = objConn
.CommandText = "SP_ML_Employees_Roles_Reports"
.CommandType = 4
.CommandTimeout = 0
.Prepared = true

'Input Parameters
.Parameters.Append .CreateParameter("RETURN_VALUE", 3, 4)
.Parameters.Append .CreateParameter("@ErrorDesc",129,2,500)
'.Parameters.Append .CreateParameter("@EmployeeName", 129, 1, 15, EmployeeName)
'.Parameters.Append .CreateParameter("@EmployeeLastName", 129, 1, 30, EmployeeLastName)
'.Parameters.Append .CreateParameter("@EmployeeRoleID",3,1,EmployeeRoleID)
'.Parameters.Append .CreateParameter("@EmployeeDNI", 3, 1,EmployeeDNI)
End With
objRs.Open objCmd, , 3, 1, 4
'int_SP_RV = obj.Cmd.Parameters("RETURN_VALUE")

'debugParamAttribs2(objCmd)
SP_RV = objCmd.Parameters("RETURN_VALUE")

Set SearchRoleReport = objRs
Set objCmd = Nothing

End Function



Function GetEmployeePhones(EmployeeID)
Dim strSQL

strSQL = "SELECT * FROM TB_ML_Employee_Phones WHERE EmployeeID="
strSQL = strSQL & EmployeeID

SET GetEmployeePhones = getADORecordSet(strSQL)

End Function



Function GetSalaryReport()

Dim objRs,objCmd,objConn

Set objConn = Server.CreateObject("ADODB.Connection")
Set objRs = Server.CreateObject("ADODB.Recordset")
Set objCmd = Server.CreateObject("ADODB.Command")

objConn.Open sSCN_CnxString
objRs.CursorLocation = 3

With objCmd
Set .ActiveConnection = objConn
.CommandText = "SP_ML_Employees_Salary_Report"
.CommandType = 4
.CommandTimeout = 0
.Prepared = true

'Input Parameters
.Parameters.Append .CreateParameter("RETURN_VALUE", 3, 4)

End With
objRs.Open objCmd, , 3, 1, 4
'int_SP_RV = obj.Cmd.Parameters("RETURN_VALUE")

'debugParamAttribs2(objCmd)
SP_RV = objCmd.Parameters("RETURN_VALUE")

Set GetSalaryReport = objRs
Set objCmd = Nothing
End Function


%>
