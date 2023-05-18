<!--#include file="connect.asp"-->
<%
    Dim email, password
    email = Request.Form("email")
    password = Request.Form("password")
    If (NOT isnull(email) AND NOT isnull(password) AND Trim(email) <> "" AND Trim(password) <> "") Then
        ' true
        Dim sql
        sql = "Select * From TAIKHOAN Where TenTK=? and MatKhau=?"
        Dim cmdPrep
        set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = true
        cmdPrep.CommandText = sql
        cmdPrep.Parameters(0) = email
        cmdPrep.Parameters(1) = password
        Dim result
        set result = cmdPrep.execute()
        
        ' Kiểm tra kết quả result
        If not result.EOF Then
            ' đăng nhập thành công
            Session("email") = result("TenTK")
            Session("Success") = "Đăng nhập thành công"
            Response.redirect("index.asp")
        Else
            ' đăng nhập không thành công
            Session("Error") = "Sai email hoặc mật khẩu"
        End if
        result.Close()
        connDB.Close()
    Else
        ' false
        Session("Error") = "Vui lòng nhập email và mật khẩu"
    End if
%>

<!--#include file="layouts/header.asp"-->
<div class="container form-login" >
    <form method="post" action="login.asp">
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="text" class="form-control" id="email" name="email" value="<%=TenTK%>" placeholder="Tên đăng nhập/Email">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" placeholder="Mật khẩu">
        </div>
        <div class="mb-3 pt-3"> 
        <button type="submit" class="btn-login">Đăng nhập</button>
        </div>
        <div class="mb-3">
            Bạn chưa có tài khoản?
            <a href="signup.asp" class="link-sign-up"> Đăng ký ngay</a>
        </div>
    </form>
</div>
<!--#include file="layouts/footer.asp"-->