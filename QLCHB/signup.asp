<!--#include file="connect.asp"-->
<!--#include file="layouts/header.asp"-->
<%
If (Request.ServerVariables("REQUEST_METHOD") = "POST") THEN
     Dim email, password, user_name, address, date, gender, phone
     email = Request.Form("email")
     password = Request.Form("password")
     user_name = Request.Form("user_name")
     address = Request.Form("address")
     date = Request.Form("date")
     gender = Request.Form("gender")
     phone = Request.Form("phone")
     ' code here to retrive the data from taikhoan table
     Dim sqlString, rs
     Set cmdTaiKhoantua = Server.CreateObject("ADODB.Command")
     connDB.Open()
     cmdTaiKhoantua.ActiveConnection = connDB
     cmdTaiKhoantua.CommandType = 1
     cmdTaiKhoantua.Prepared = True
     cmdTaiKhoantua.CommandText = "SELECT TenTK FROM TAIKHOAN WHERE TenTK = ?"
     cmdTaiKhoantua.parameters.Append cmdTaiKhoantua.createParameter("TenTK",202,1,100,email)
     set rs = cmdTaiKhoantua.execute
    If NOT rs.EOF Then      
         If (NOT isnull(email) AND NOT isnull(password) AND TRIM(email)<>"" AND TRIM(password)<>"" AND NOT isnull(user_name) AND NOT isnull(address) AND NOT isnull(date) AND NOT isnull(gender) AND NOT isnull(phone) AND TRIM(user_name)<>"" AND TRIM(address)<>"" AND TRIM(date)<>"" AND TRIM(gender)<>"" AND TRIM(phone)<>"") Then
           ' true
           ' Dim sql
           ' sql = "INSERT INTO TAIKHOAN(email,password) VALUES(?,?)"
           ' Dim cmdPrep
           ' set cmdPrep = Server.CreateObject("ADODB.Command")
           ' connDB.Open()
           ' cmdPrep.ActiveConnection = connDB
           ' cmdPrep.CommandType=1
           ' cmdPrep.Prepared=true
           ' cmdPrep.CommandText = sql
           ' cmdPrep.Parameters.Append cmdPrep.createParameter("email",202,1,255,email)
           ' cmdPrep.parameters.Append cmdPrep.createParameter("password",202,1,255,password)
           ' Dim result
           ' set result = cmdPrep.execute()
            if (NOT isnull(email) and email<>"" and NOT isnull(password) and password<>"" and NOT isnull(user_name) and user_name<>"" and NOT isnull(address) and address<>"" and NOT isnull(date) and date<>"" and NOT isnull(gerder) and gerder<>"" and NOT isnull(phone) and phone<>"") then
                Dim cmdTaiKhoan
                Set cmdTaiKhoan = Server.CreateObject("ADODB.Command")
                cmdTaiKhoan.ActiveConnection = connDB
                cmdTaikHoan.CommandType = 1
                cmdTaiKhoan.Prepared = True
                cmdTaiKhoan.CommandText = "INSERT INTO TAIKHOAN(TenTK,MatKhau,VaiTro) VALUES(?,?,?)"
                cmdTaiKhoan.parameters.Append cmdTaiKhoan.createParameter("email",202,1,100,email)
                cmdTaiKhoan.parameters.Append cmdTaiKhoan.createParameter("password",202,1,100,password)
                cmdTaiKhoan.parameters.Append cmdPrep.createParameter("VaiTro",202,1,100,null)
                Dim result
                Set result = cmdTaiKhoan.execute
                Set id = connDB.execute("SELECT @@IDENTITY AS NewID")                
                
                Dim cmdKhachHang
                Set cmdKhachHang = Server.CreateObject("ADODB.Command")
                cmdKhachHang.ActiveConnection = connDB
                cmdHangKhach.CommandType = 1
                cmdHangKhach.CommandText = "INSERT INTO KHACHHANG(TenKH,DiaChi,NgaySinh,GioiTinh,Email, SDT, Id) VALUES(?,?,?,?,?,?,?)"
                cmdHangKhach.parameters.Append cmdPrep.createParameter("user_name",202,1,100,user_name)
                cmdKhachHang.parameters.Append cmdPrep.createParameter("address",202,1,100,address)
                cmdKhachHang.parameters.Append cmdPrep.createParameter("date",7,1,10,date)
                cmdPrep.parameters.Append cmdPrep.createParameter("gerder",202,1,10,gender)
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,100,email)
                cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,20,phone)
                cmdPrep.parameters.Append cmdPrep.createParameter("Id",3,1,,id)
                cmdPrep.execute

                Session("Success") = "New account added!"
                Response.redirect("login.asp")
            else
                Session("Error") = "You have to input enough info"                
            end if
            'kiem tra ket qua result o day
            If not result.EOF Then
               ' dang ki tai khoan thanh cong
                  Session("email")=result("email")                  
                  Session("Success")="Sign up Successfully"
                  Response.redirect("login.asp")
             Else
                ' dang nhap ko thanh cong
                  Session("Error") = "Wrong email or password"
            End if
            result.Close()
            connDB.Close()
        Else
             ' false
             Session("Error")="Please input email and password."
        End if
    Else       
       Session("Error")="Email đã có rồi"
    End if
          Session("Error")="Lỗi"
    End If  
%>
<div class="container form-signup">
    <form method="post">
        <div class="mb-3">
            <label for="user-name" class="form-label">Tên khách hàng</label>
            <input type="text" class="form-control" id="user_name" name="user_name">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="text" class="form-control" id="email" name="email">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password">
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="address" name="address">
        </div>
        <div class="mb-3">
            <label for="DoB" class="form-label">Ngày sinh</label>
            <input type="date" class="form-control" id="date" name="date">
        </div>
        <div class="mb-3">
            <!-- <label for="gender" class="form-label">Giới tính</label>
            <div class="gender-chosen">
                <span class="gender">
                    <label class="gender">Nam</label>
                    <input type="radio" id="male" name="gender">
                </span>
                <span class="gender female">
                    <label class="gender female">Nữ</label>
                    <input type="radio" id="female" name="gender">
                </span>
            </div> -->
            <label for="gender" class="form-label">Giới tính:</label>
            <label class="radio-inline gender">
                <input type="radio" id="male" name="gender" value="Nam">Nam
            </label>
            <label class="radio-inline gender">
                <input type="radio" id="female" name="gender" value="Nữ">Nữ
            </label>
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone">
        </div>
        <div class="mb-3 pt-3"> 
        <button type="submit" class="btn-signup">Đăng ký</button>
        </div>
    </form>
</div>
<!--#include file="layouts/footer.asp"-->