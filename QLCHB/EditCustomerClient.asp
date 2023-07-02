<!-- #include file="connect.asp" -->
<%
On Error Resume Next
' handle Error
Sub handleError(message)
    Session("Error") = message
    'send an email to the admin
    'Write the error message in an application error log file
End Sub
Dim email

If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
    ' idKH = Request.QueryString("idKH")
    email = Session("email")
    'Response.Write(email)

    If (Trim(email)<>"" AND Not isnull(email)) Then
        Set cmdPrep = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdPrep.ActiveConnection = connDB
        cmdPrep.CommandType = 1
        cmdPrep.Prepared = True
        cmdPrep.CommandText = "SELECT * FROM KHACHHANG WHERE Email='"&email&"'"
        
        Set Result = cmdPrep.execute 

        If not Result.EOF then
            tenKH = Result("TenKH")
            diaChi = Split(Result("DiaChi"), ",")
            so_nha = diaChi(0)
            xa = diaChi(1)
            huyen = diaChi(2)
            tinh = diaChi(3)
            ngaySinh = Result("NgaySinh")
            gioiTinh = Result("GioiTinh")
            email = Result("Email")
            sdt = Result("SDT")
        End If
        ' Set Result = Nothing
        Result.Close()
        connDB.Close()
    End If
Else
    email = Session("email")
    PostEmail = Request.form("email")
    PostTenKH = Request.form("name")
    Tinh = Request.Form("Tinh")
    Huyen = Request.Form("Huyen")
    Xa = Request.Form("Xa")
    AddressDetails = Request.Form("AddressDetails")
    PostDiaChi = AddressDetails&","&Xa&","&Huyen&","&Tinh
    PostNgaySinh = Request.form("DoB")
    PostGioiTinh = Request.form("gender")
    PostSDT = Request.form("phone")
    PostPassWord = Request.form("password")
        if (NOT isnull(PostTenKH) and PostTenKH<>"" and NOT isnull(PostDiaChi) and PostDiaChi<>"" and NOT isnull(PostNgaySinh) and PostNgaySinh<>"" and NOT isnull(PostGioiTinh) and PostGioiTinh<>"" and NOT isnull(PostEmail) and PostEmail<>"" and NOT isnull(PostSDT) and PostSDT<>"" AND Not isnull(PostPassWord) AND PostPassWord<>"") then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()                
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.Prepared = True
            cmdPrep.CommandText = "UPDATE KHACHHANG SET TenKH=?,DiaChi=?,NgaySinh=?,GioiTinh=?,SDT=? WHERE Email=?"
            cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,100,PostTenKH)
            cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,100,PostDiaChi)
            cmdPrep.parameters.Append cmdPrep.createParameter("DoB",7,1,10,PostNgaySinh)
            cmdPrep.parameters.Append cmdPrep.createParameter("gender",202,1,10,PostGioiTinh)
            cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,20,PostSDT)
            cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,100,PostEmail)

            cmdPrep.execute
            
            Set cmdTaiKhoan = Server.CreateObject("ADODB.Command")
            cmdTaiKhoan.ActiveConnection = connDB
            cmdTaiKhoan.CommandType = 1
            cmdTaiKhoan.CommandText = "UPDATE TAIKHOAN SET MatKhau=? WHERE TenTK =?"
           ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id)
            cmdTaiKhoan.Parameters(0)=PostPassWord
            cmdTaiKhoan.Parameters(1)=PostEmail
            Set Result = cmdTaiKhoan.execute

            If Err.Number=0 Then
                Session("Success") = "Thông tin khách hàng đã được sửa!!!"
                Response.redirect("index.asp")
            Else
                handleError(Err.Description)
            End If
            On Error Goto 0
        else
            Session("Error") = "Các trường dữ liệu không được để trống!!!"
        end if
    connDB.Close()
    end if

%>
<!-- #include file="layouts/header.asp" -->
<div class="container">
    <h2>Sửa thông tin khách hàng</h2>
    <%
    Dim password
    Set cmdTaiKhoan = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdTaiKhoan.ActiveConnection = connDB
    cmdTaiKhoan.CommandType = 1
    cmdTaiKhoan.CommandText = "SELECT * FROM TAIKHOAN WHERE TenTK =?"
    ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id)
    cmdTaiKhoan.Parameters(0)=email
    Set Result = cmdTaiKhoan.execute

    If Not Result.EOF Then
        ' true
        password = Result("MatKhau")
        Result.Close()
    End if
    %>
    <form method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Họ và tên</label>
            <input type="text" class="form-control" id="name" name="name" value="<%=tenKH%>">
        </div>
        <!--<div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="address" name="address" value="<%=diaChi%>">
        </div>-->
         <div class="mb-3">
          <label for="address">Tỉnh/Thành phố</label>
          <input type="text" class="form-control" id="Tinh" name="Tinh" placeholder="Nhập tên tỉnh/thành phố!" value="<%=tinh%>" required>
          <div class="invalid-feedback">
            Please enter your shipping address.
          </div>
        </div>

        <div class="row">
          <div class="col-md-5 mb-3">
            <label for="country">Quận/Huyện</label>
            <input type="text" class="form-control" id="Quan" name="Huyen" placeholder="Nhập tên quận/huyện" value="<%=huyen%>" required>
            <div class="invalid-feedback">
              Please select a valid country.
            </div>
          </div>
          <div class="col-md-4 mb-3">
            <label for="state">Phường/Xã</label>
            <input type="text" class="form-control" id="Phuong" name="Xa" placeholder="Nhập tên phường/xã" value="<%=xa%>" required>
            <div class="invalid-feedback">
              Please provide a valid state.
            </div>
          </div>
          <div class="col-md-3 mb-3">
            <label for="zip">Số nhà</label>
            <input type="text" class="form-control" id="AddressDetails" name="AddressDetails" placeholder="Số nhà" value="<%=so_nha%>" required>
            <div class="invalid-feedback">
              Zip code required.
            </div>
          </div>
        </div>

        <div class="mb-3">
            <label for="DoB" class="form-label">Ngày sinh</label>
            <input type="date" class="form-control" id="DoB" name="DoB" value="<%=ngaySinh%>">
        </div>
        <div class="mb-3">
            <label for="gender" class="form-label">Giới tính</label>
            <select class="form-control" name="gender" id="gender">
                <%
                    If (gioiTinh = "Nam") Then
                %>
                    <option value="<%=gioiTinh%>">Nam</option>
                    <option value="Nữ">Nữ</option>
                <%
                    Else
                %>
                    <option value="<%= gioiTinh%>">Nữ</option>
                    <option value="Nam">Nam</option>
                <%
                     End if
                %>
            </select>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input readonly type="text" class="form-control" id="email" name="email" value="<%=email%>">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="text" class="form-control" id="password" name="password" value="<%=password%>">
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone" value="<%=sdt%>">
        </div>  
        <button type="submit" class="btn btn-primary">Cập nhật</button>
        <a href="Index.asp" class="btn btn-info">Hủy</a>
    </form>
</div>
<!-- #include file="layouts/footer.asp" -->