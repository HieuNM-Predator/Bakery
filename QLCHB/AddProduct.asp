<!-- #include file="connect.asp" -->
<!--#include file="pure/upload.lib.asp"-->

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
    
        tenSP = Request.form("name")
        donGia = Request.form("price")
        loai = Request.form("category")
        moTa = Request.form("description")
        hinhAnh = "/files/img/"& Request.form("image")
        tinhTrang = Request.form("status")
        If (CStr(tinhTrang) = "InStock") Then
            ' true
            tinhTrang = true
        Else
            ' false
            tinhTrang = false
        End if

            if (NOT isnull(tenSP) and tenSP<>"" and NOT isnull(donGia) and donGia<>"" and NOT isnull(loai) and loai<>"" and NOT isnull(moTa) and moTa<>"" and NOT isnull(hinhAnh) and hinhAnh<>"" and NOT isnull(tinhTrang) and tinhTrang<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO SANPHAM(TenSP,DonGia,Loai,MoTa,HinhAnh,TinhTrang) VALUES(?,?,?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,tenSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("price",202,1,255,donGia)
                cmdPrep.parameters.Append cmdPrep.createParameter("category",202,1,255,loai)
                cmdPrep.parameters.Append cmdPrep.createParameter("description",202,1,255,moTa)
                cmdPrep.parameters.Append cmdPrep.createParameter("image",202,1,255,hinhAnh)
                ' cmdPrep.parameters.Append cmdPrep.createParameter("status",202,1,255,tinhTrang)
                cmdPrep.parameters.Append cmdPrep.createParameter("status",11,1,255,tinhTrang)

                cmdPrep.execute               
                
                If Err.Number = 0 Then 
                'Lấy ra ID tự tăng vừa thêm
                ' Set rs = connDB.execute("SELECT @@IDENTITY AS NewID")
                '     Response.write(rs("NewID"))  
                    Session("Success") = "Thêm mới sản phẩm thành công!!!"                    
                    Response.redirect("ProductManagement.asp")  
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
        <h2>Thêm sản phẩm</h2>
            
        <form method="post">
            <div class="mb-3">
                <label for="name" class="form-label">Tên sản phẩm</label>
                <input type="text" class="form-control" id="name" name="name" value="<%=tenSP%>">
            </div>
            <div class="mb-3">
                <label for="price" class="form-label">Đơn giá</label>
                <input type="text" class="form-control" id="price" name="price" value="<%=donGia%>">
            </div>
            <div class="mb-3">
                <label for="category" class="form-label">Loại</label>
                <input type="text" class="form-control" id="category" name="category" value="<%=loai%>">
            </div>
            <div class="mb-3">
                <label for="description" class="form-label">Mô tả</label>
                <input type="text" class="form-control" id="description" name="description" value="<%=moTa%>">
            </div>
            <div  class="mb-3">
                <form action="./pure/upload.asp" enctype="multipart/form-data" target="iframe_upload">
                    <p>File/Image:</p>
                        <input type="file" name="image" multiple id="image" value="<%=hinhAnh%>" />
                        <input type="submit" value="Upload" />
                    <br />
                    <iframe name="iframe_upload" src="pure/upload.asp" width="100%" height="200px"></iframe>
                </form> 
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Tình trạng:</label>
                <div class="uk-form-controls">
                    <label><input class="uk-radio" type="radio" name="status" value="InStock" checked> Còn hàng</label>
                    <label><input class="uk-radio" type="radio" name="status" value="OutOfStock"> Hết hàng</label>
                </div>
            </div>  
            <button type="submit" class="btn btn-primary">
                Thêm mới
            </button>
            <a href="ProductManagement.asp" class="btn btn-info">Hủy</a>
        </form>
    </div>     

<!-- #include file="layouts/footer.asp" -->
