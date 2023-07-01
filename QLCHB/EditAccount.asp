<!-- #include file="connect.asp" -->
<%
On Error Resume Next
' handle Error
Sub handleError(message)
    Session("Error") = message
    'send an email to the admin
    'Write the error message in an application error log file
End Sub
        ' Yêu cầu đăng nhập để thêm sửa xóa
    ' If (isnull(Session("email")) OR TRIM(Session("email")) = "") Then
    '     Response.redirect("login.asp")
    ' End If
  
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM TAIKHOAN WHERE Id=?"
            ' cmdPrep.parameters.Append cmdPrep.createParameter("Id",3,1, ,id)
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                TenTK = Result("TenTK")
                MatKhau = Result("MatKhau")
                VaiTro = Result("VaiTro")             
            End If

            ' Set Result = Nothing  
                       
        End If
    Else
        id = Request.QueryString("id")
        PostTenTK = Request.form("email")
        PostMatKhau = Request.form("password")   
        PostVaiTro = Request.form("VaiTro")     

            if (NOT isnull(PostTenTK) and PostTenTK<>"" and NOT isnull(PostMatKhau) and PostMatKhau<>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE TAIKHOAN SET TenTK=?,MatKhau=? WHERE Id=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,50,PostTenTK)
                cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,100,PostMatKhau)
                cmdPrep.parameters.Append cmdPrep.createParameter("Id",3,1, ,id)

                cmdPrep.execute
                 
                If PostVaiTro ="KhachHang" Then
                   Set cmdNguoiDung = Server.CreateObject("ADODB.Command")
                   cmdNguoiDung.ActiveConnection = connDB
                   cmdNguoiDung.CommandType = 1
                   cmdNguoiDung.Prepared = True
                   cmdNguoiDung.CommandText = "UPDATE KHACHHANG SET Email=? WHERE Id=?"
                   cmdNguoiDung.parameters.Append cmdNguoiDung.createParameter("email",202,1,50,PostTenTK)  
                   cmdNguoiDung.parameters.Append cmdNguoiDung.createParameter("Id",3,1,,id)
                   cmdNguoiDung.execute
                Else 
                   Set cmdNhanVien = Server.CreateObject("ADODB.Command")  
                   cmdNhanVien.ActiveConnection = connDB
                   cmdNhanVien.CommandType = 1
                   cmdNhanVien.Prepared = True
                   cmdNhanVien.CommandText = "UPDATE NHANVIEN SET Email = ? WHERE Id= ?"
                   cmdNhanVien.parameters.Append cmdNhanVien.createParameter("email",202,1,50,PostTenTK)
                   cmdNhanVien.parameters.Append cmdNhanVien.createParameter("Id",3,1,,id)
                   cmdNhanVien.execute
                End if

                If Err.Number=0 Then
                    Session("Success") = "Tài khoản đã được sửa thông tin!!!"
                    Response.redirect("AccountManagement.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
                Session("Error") = "Các trường dữ liệu không được để trống!!!"
            end if
        end if
    
%>
<!-- #include file="layouts/header.asp" -->
    <div class="container">
        <h2>Sửa thông tin tài khoản</h2>
        
        <form method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" class="form-control" id="email" name="email" value="<%=TenTK%>">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="text" class="form-control" id="password" name="password" value="<%=MatKhau%>">
            </div>  
            <div class="mb-3">
                <label for="vaitro" class="form-label">Vai trò:</label>
                <input readonly type="text" class="form-control" id="VaiTro" name="VaiTro" value="<%=VaiTro%>">           
            </div>          
            <button type="submit" class="btn btn-primary">Cập nhật</button>
            <a href="AccountManagement.asp" class="btn btn-info">Hủy</a>               
        </form>
    </div>
<!-- #include file="layouts/footer.asp" -->