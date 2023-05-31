<!-- #include file="connect.asp" -->
<%
On Error Resume Next
' handle Error
    id = Request.QueryString("id")
        ' Yêu cầu đăng nhập để thêm sửa xóa
    ' If (isnull(Session("email")) OR TRIM(Session("email")) = "") Then
    '     Response.redirect("login.asp")
    ' End If
    if (isnull(id) OR trim(id)="") then
        Response.redirect("ProductManagement.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM SANPHAM WHERE MaSP=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id)

    cmdPrep.execute
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Xóa sản phẩm thành công!!!"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("ProductManagement.asp")
    On Error Goto 0     
%>