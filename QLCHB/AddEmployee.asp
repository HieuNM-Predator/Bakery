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

        TenNV = Request.form("name")
        PostEmail = Request.form("email")
        SDT = Request.form("phone")
        tinh = Request.Form("Tinh")
        huyen = Request.Form("Huyen")
        xa = Request.Form("Xa")
        so_nha = Request.Form("AddressDetails")
        DiaChi = so_nha&","&xa&","&huyen&","&tinh
        GioiTinh = Request.form("gender")
        CCCD = Request.form("CCCD")
        NgaySinh = Request.form("date")
          
        if not rs.EOF then   
            if (NOT isnull(TenNV) and TenNV<>"" and NOT isnull(PostEmail) and PostEmail<>"" and NOT isnull(SDT) and SDT<>"" and NOT isnull(DiaChi) and DiaChi<>"" and NOT isnull(GioiTinh) and GioiTinh<>"" and NOT isnull(CCCD) and CCCD<> "" and NOT isnull(NgaySinh) and NgaySinh<>"") then
                Set cmdID = Server.CreateObject("ADODB.Command")    
                'Phai dat connDB.Open truoc khi cmdID.ACtiveConnection = connDB'
                connDB.Open()   
                cmdID.ActiveConnection = connDB
                cmdID.CommandType = 1
                cmdID.Prepared = True
                cmdID.CommandText = "SELECT * FROM TAIKHOAN WHERE TenTK=?"
                ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id)
                cmdID.Parameters(0) = PostEmail
                Set rs = cmdID.execute
                Id = rs("Id")


                Set cmdPrep = Server.CreateObject("ADODB.Command")                               
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO NHANVIEN(TenNV,Email,SDT,DiaChi,GioiTinh,CCCD,NgaySinh,Id) VALUES(?,?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,50,TenNV)
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,100,PostEmail)
                cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,20,SDT)
                cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,100,DiaChi)
                cmdPrep.parameters.Append cmdPrep.createParameter("gender",202,1,10,GioiTinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("CCCD",202,1,20,CCCD)
                cmdPrep.parameters.Append cmdPrep.createParameter("date",7,1,10,NgaySinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("Id",3,1,,Id)
                
                cmdPrep.execute 
                
                
                If Err.Number = 0 Then 
                'Lấy ra ID tự tăng vừa thêm
                ' Set rs = connDB.execute("SELECT @@IDENTITY AS NewID")
                '     Response.write(rs("NewID"))  
                    Session("Success") = "Thêm mới nhân viên thành công!!!"                    
                    Response.redirect("EmployeeManagement.asp") 
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "Các trường dữ liệu không được để trống!!!"                
            end if   
        Else
           Session("Error")  = "Lỗi ID"    
        End if  
%>
<!-- #include file="layouts/header.asp" -->
    <div class="container">
        <h2>Thêm nhân viên</h2>   
        <%
        Dim sqlstring
        sqlstring = "Admin" 'Dat ten bien sqlstring co gia tri la Admin'
        Set cmdTaiKhoan = Server.CreateObject("ADODB.Command")
        connDB.Open()
        cmdTaiKhoan.ActiveConnection = connDB
        cmdTaiKhoan.CommandType = 1
        cmdTaiKhoan.CommandText = "SELECT * FROM TAIKHOAN WHERE VaiTro = ? AND Id NOT IN (SELECT Id FROM NHANVIEN)" 
        ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id) 
        cmdTaiKhoan.Parameters(0)=sqlString 'Gan sqlstring cho VaiTro=? ben tren'
        Set Result = cmdTaiKhoan.execute    'Hien thi ra toan bo ket qua : Id, TenTK, MatKhau, VaiTro trong bang tai khoan dua no vao trong bien Result'
        Set Email = Result("TenTK")  'Dat mot bien ten la Email gan no bang ket qua TenTK vua hien thi ra trong bien Result (Tuc la lay ra email co vai tro la nhan vien)'
        %>
        <form method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Tên nhân viên</label>
                <input type="text" class="form-control" id="name" name="name" value="<%=TenNV%>">
            </div>                         
            <div class="mb-3">                
                <label for="email" class="form-label">Email</label>               
                     <select name="email" id="email" class="form-control">
                      <% do while Not Result.EOF %>
                         <option value="<%=Result%>"><%=Email%></option> 
                      <%
                         Result.MoveNext
                         loop
                      %>               
                    </select> 
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">SDT</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%=SDT%>">
            </div>
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
                <label for="gender" class="form-label">Giới tính:</label>
                <div class="uk-form-controls">
                    <label><input class="uk-radio" type="radio" name="gender" value="Nam" checked> Nam</label>
                    <label><input class="uk-radio" type="radio" name="gender" value="Nữ"> Nữ</label>
                </div>
            </div>
             <div class="mb-3">
                <label for="CCCD" class="form-label">CCCD</label>
                <input type="text" class="form-control" id="CCCD" name="CCCD" value="<%=CCCD%>">
            </div>
            <div class="mb-3">
                <label for="date" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" id="date" name="date" value="<%=NgaySinh%>">
            </div>
            <button type="submit" class="btn btn-primary">
                Thêm mới
            </button>
            <a href="EmployeeManagement.asp" class="btn btn-info">Hủy</a>
        </form>
    </div>
<!-- #include file="layouts/footer.asp" -->