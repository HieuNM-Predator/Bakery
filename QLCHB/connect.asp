<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=DESKTOP-1BD6E39\DUC;Database=QLCHB;User Id=sa;Password=haimecon0102"
connDB.ConnectionString = strConnection
%>