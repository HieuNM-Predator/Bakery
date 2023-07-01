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
        Response.redirect("AccountManagement.asp")
        Response.End
    end if

    Set cmdKhachHang = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdKhachHang.ActiveConnection = connDB    
    cmdKhachHang.CommandType = 1
    cmdKhachHang.CommandText = "DELETE FROM KHACHHANG WHERE Id=?"
    cmdKhachHang.parameters.Append cmdKhachHang.createParameter("Id",3,1,,id)

    cmdKhachHang.execute

    Set cmdNhanVien = Server.CreateObject("ADODB.Command")
    cmdNhanVien.ActiveConnection = connDB
    cmdNhanVien.CommandType = 1
    cmdNhanVien.CommandText = "DELETE FROM NHANVIEN WHERE Id=?"
    cmdNhanVien.parameters.Append cmdNhanVien.createParameter("Id",3,1,,id)

    cmdNhanVien.execute

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM TAIKHOAN WHERE Id=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("Id",3,1, ,id)

    cmdPrep.execute

    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Xóa nhân viên tài khoản!!!"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("AccountManagement.asp")
    On Error Goto 0     
%>