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
       
        TenTK = Request.form("email")
        MatKhau = Request.form("password")
        VaiTro = Request.form("VaiTro")
        
            if (NOT isnull(TenTK) and TenTK<>"" and NOT isnull(MatKhau) and MatKhau<>"" ) then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO TAIKHOAN(TenTK,MatKhau,VaiTro) VALUES(?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,50,TenTK)
                cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,100,MatKhau)
                cmdPrep.parameters.Append cmdPrep.createParameter("VaiTro",202,1,100,VaiTro)
                
                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                'Lấy ra ID tự tăng vừa thêm
                ' Set rs = connDB.execute("SELECT @@IDENTITY AS NewID")
                '     Response.write(rs("NewID"))  
                    Session("Success") = "Thêm mới tài khoản thành công!!!"                    
                    Response.redirect("AccountManagement.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "Các trường dữ liệu không được để trống!!!"                
            end if
        
%>
<!-- #include file="layouts/header.asp" -->
    <div class="container">
        <h2>Thêm tài khoản</h2>
            
        <form method="post">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" class="form-control" id="email" name="email" value="<%=TenTK%>">
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" id="password" name="password" value="<%=MatKhau%>">
            </div>
            <div class="mb-3">
                <label for="VaiTro" class="form-label">Vai trò:</label>
                <div class="uk-form-controls">
                    <label><input class="uk-radio" type="radio" name="VaiTro" value="KhachHang" checked> Khách hàng</label>
                    <label><input class="uk-radio" type="radio" name="VaiTro" value="Admin"> Admin</label>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">
                Thêm mới
            </button>
            <a href="AccountManagement.asp" class="btn btn-info">Hủy</a>
        </form>
    </div>
<!-- #include file="layouts/footer.asp" -->