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
    Dim statusOptions
    statusOptions = Array("Còn hàng", "Hết hàng")

    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM SANPHAM WHERE MaSP=?"
            ' cmdPrep.parameters.Append cmdPrep.createParameter("MaNV",3,1, ,id)
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                tenSP = Result("TenSP")
                donGia = Result("DonGia")
                loai = Result("Loai")
                moTa = Result("MoTa")
                hinhAnh = Result("HinhAnh")
                tinhTrang = Result("TinhTrang")
                
                If (Result("TinhTrang") = true) Then
                    ' true
                    tinhTrang = "Còn hàng"
                Else
                    ' false
                    tinhTrang = "Hết hàng"
                End if
            End If

            ' Set Result = Nothing
            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        PostTenSP = Request.form("name")
        PostDonGia = Request.form("price")
        PostLoai = Request.form("category")
        PostMoTa = Request.form("description")
        PostHinhAnh = Request.form("image")
        PostTinhTrang = Request.form("statusOption")

        If (PostTinhTrang = "Còn hàng") Then
            ' true
            PostTinhTrang = 1
        Else
            ' false
            PostTinhTrang = 0
        End if

            if (NOT isnull(PostTenSP) and PostTenSP<>"" and NOT isnull(PostDonGia) and PostDonGia<>"" and NOT isnull(PostLoai) and PostLoai<>"" and NOT isnull(PostMoTa) and PostMoTa<>"" and NOT isnull(PostHinhAnh) and PostHinhAnh<>"" and NOT isnull(PostTinhTrang) and PostTinhTrang<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE SANPHAM SET TenSP=?,DonGia=?,Loai=?,MoTa=?,HinhAnh=?,TinhTrang=? WHERE MaSP=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("name",202,1,255,PostTenSP)
                cmdPrep.parameters.Append cmdPrep.createParameter("price",202,1,255,PostDonGia)
                cmdPrep.parameters.Append cmdPrep.createParameter("category",202,1,255,PostLoai)
                cmdPrep.parameters.Append cmdPrep.createParameter("description",202,1,255,PostMoTa)
                cmdPrep.parameters.Append cmdPrep.createParameter("image",202,1,255,PostHinhAnh)
                ' cmdPrep.parameters.Append cmdPrep.createParameter("status",202,1,255,tinhTrang)
                cmdPrep.parameters.Append cmdPrep.createParameter("status",11,1,255,PostTinhTrang)
                cmdPrep.parameters.Append cmdPrep.createParameter("MaSP",3,1, ,id)

                cmdPrep.execute
                If Err.Number=0 Then
                    Session("Success") = "Sản phẩm đã được sửa thông tin!!!"
                    Response.redirect("ProductManagement.asp")
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
        <h2>Sửa thông tin sản phẩm</h2>
        
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
            <div class="mb-3">
                <label for="image" class="form-label">Hình ảnh</label>
                <input type="text" class="form-control" id="image" name="image" value="<%=hinhAnh%>">
            </div>
            <div class="mb-3">
                <label for="status" class="form-label">Tình trạng:</label>
                <div class="uk-form-controls">
                    <% For Each statusOption in statusOptions %>
                        <% If statusOption = tinhTrang Then %>
                        <label><input class="uk-radio" type="radio" name="status" value="<%= statusOption %>" checked> <%= statusOption %></label><br>
                        <% Else %>
                        <label><input class="uk-radio" type="radio" name="status" value="<%= statusOption %>"> <%= statusOption %></label><br>
                        <% End If %>
                    <% Next %>
                </div>
            </div>  
            <button type="submit" class="btn btn-primary">Cập nhật</button>
            <a href="ProductManagement.asp" class="btn btn-info">Hủy</a>   
            <%Response.Write(tinhTrang)
            %>
        </form>
    </div>
<!-- #include file="layouts/footer.asp" -->