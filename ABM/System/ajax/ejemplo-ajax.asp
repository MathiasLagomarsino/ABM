<%@  language="VBSCRIPT" codepage="65001" %>
<%
doAction        = Request("doAction")
data1           = Request("param1")
data2           = Request("param2")
dataN           = Request("paramN")

response.Status = "200"
Response.ContentType = "application/json"
response.Write "{ ""success"": ""1"", ""data"": {""doAction"": """ & doAction & """, ""data1"": """ & data1 & """, ""data2"": """ & data2 & """, ""dataN"": """ & dataN & """}}"
response.end
%>