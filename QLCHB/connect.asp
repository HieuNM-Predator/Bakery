
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=LAPTOP-E88M33I6\BUITRUNGDQ;Database=QLCHB;User Id=sa;Password=123456"
connDB.ConnectionString = strConnection
%>