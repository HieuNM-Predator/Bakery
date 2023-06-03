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
        Email = Request.form("email")
        SDT = Request.form("phone")
        DiaChi = Request.form("address")
        GioiTinh = Request.form("gender")
        CCCD = Request.form("CCCD")
        NgaySinh = Request.form("date")
        
            if (NOT isnull(TenNV) and TenNV<>"" and NOT isnull(Email) and Email<>"" and NOT isnull(SDT) and SDT<>"" and NOT isnull(DiaChi) and DiaChi<>"" and NOT isnull(GioiTinh) and GioiTinh<>"" and NOT isnull(CCCD) and CCCD<> "" and NOT isnull(NgaySinh) and NgaySinh<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO NHANVIEN(TenNV,Email,SDT,DiaChi,GioiTinh,CCCD,NgaySinh,Id) VALUES(?,?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,50,TenNV)
                cmdPrep.parameters.Append cmdPrep.createParameter("email",202,1,100,Email)
                cmdPrep.parameters.Append cmdPrep.createParameter("phone",202,1,20,SDT)
                cmdPrep.parameters.Append cmdPrep.createParameter("address",202,1,100,DiaChi)
                cmdPrep.parameters.Append cmdPrep.createParameter("gender",202,1,10,GioiTinh)
                cmdPrep.parameters.Append cmdPrep.createParameter("CCCD",202,1,20,CCCD)
                cmdPrep.parameters.Append cmdPrep.createParameter("date",7,1,10,NgaySinh)
                

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
        
%>
<!-- #include file="layouts/header.asp" -->
    <div class="container">
        <h2>Thêm nhân viên</h2>
            
        <form method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Tên nhân viên</label>
                <input type="text" class="form-control" id="name" name="name" value="<%=TenNV%>">
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" class="form-control" id="email" name="email" value="<%=Email%>">
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">SDT</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%=SDT%>">
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" id="address" name="address" value="<%=DiaChi%>">
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