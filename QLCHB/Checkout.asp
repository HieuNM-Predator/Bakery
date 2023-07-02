<!-- #include file="connect.asp" -->
<!--#include file="layouts/header.asp"-->
<%
    If (isnull(Session("email")) OR TRIM(Session("email")) = "") Then
        Response.redirect("login.asp")
    End If

    ''1 Lấy id của khách khàng nếu là khách vãng lãi ->id=0

    Dim mycarts, totalProduct

    Dim id_cus, sql, fullname, email, address, tinh, huyen, xa, so_nha, sdt, totalAmount, ShippingFree, ShippingFreeID, cart_key, OrderID
    totalAmount = Request.QueryString("Totals")
    totalProduct = Request.QueryString("totalProduct")

    If not IsEmpty(session("email")) Then  
        connDB.Open()
        set rs = connDB.execute("SELECT * FROM TAIKHOAN INNER JOIN KHACHHANG ON TAIKHOAN.Id = KHACHHANG.Id WHERE Email='"&Session("email")&"'")
        If not rs.EOF Then
            id_cus = rs("MaKH")
        End if
        rs.Close()

        set rs = nothing
        connDB.Close()

    ' Else

    '     id_cus = 0

    End if
   
    '2 Nếu khách hàng đã đăng nhập -> xuất ra thông tin khách hàng vào form checkout info

    If id_cus <> 0 Then
        connDB.Open()
        sql = "SELECT * FROM KHACHHANG where MaKH = '"&id_cus&"'"
        set rs =connDB.execute(sql)
        If not rs.EOF Then
            fullname = rs("TenKH")
            ' address = rs("DiaChi")
            address = Split(rs("DiaChi"), ",")
            so_nha = address(0)
            xa = address(1)
            huyen = address(2)
            tinh = address(3)
            email = rs("Email")
            sdt = rs("SDT")
        End if

        rs.Close()
        set rs = nothing
        connDB.Close()
    Else
        fullname = ""
        xa = ""
        huyen = ""
        tinh = ""
        email = ""
        sdt = ""
    End if

    'Nếu người dùng ấn nút Xác nhận thì lưu dữ liệu vào sơ sở dữ liệu

    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        totalAmount = Request.Form("totalAmount")
        ' ShippingFree = Request.Form("ShippingFree")
        fullname = Request.Form("FullName")
        ' address = Request.Form("FullName")
        tinh = Request.Form("Tinh")
        huyen = Request.Form("Huyen")
        xa = Request.Form("Xa")
        so_nha = Request.Form("AddressDetails")
        address = so_nha&","&xa&","&huyen&","&tinh
        email = Request.Form("FullName")
        sdt = Request.Form("FullName")

        connDB.Open()
        sql = "INSERT INTO HOADON(MaKH, Tong)"
        sql = sql & "VALUES('"&id_cus&"','"&totalAmount&"')"
        Response.Write sql
        connDB.execute(sql)
        ''Lấy MÃ hóa đơn vừa tạo

        sql = "SELECT @@IDENTITY"

        OrderID = connDB.execute(sql).Fields(0).Value

        'Lưu thông tin vào bảng chi tiết đơn hàng

        If not IsEmpty(session("mycarts")) Then
            set mycarts = session("mycarts")
            for each cart_key in mycarts.keys
                sql = "INSERT INTO CTHD(MaHD, MaSP, SoLuong)"
                sql = sql & "values('"&OrderID&"', '"&cart_key&"', '"&mycarts(cart_key)&"')"
                connDB.execute(sql)
            next
        'connDB.Open()
        End if

        '' xóa dữ liệu giỏ hàng

        session.contents.remove("mycarts")

        Session("success") = "Thanh toán thành công!!!"

        Response.redirect("product.asp")

        connDB.Close()
    Else
    End if

%>

<div class="container">
    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
          <h4 class="d-flex justify-content-between align-items-center mb-3">
            <span class="text-muted">Tổng giá trị hóa đơn</span>
          </h4>
          <ul class="list-group mb-3">
             <%
                If not IsEmpty(session("mycarts")) Then
                set mycarts = session("mycarts")
                ' totalProduct=mycarts.Count
                connDB.Open()

                for each cart_key in mycarts.keys
                    set rs = connDB.execute("Select * from SANPHAM where MaSP =  "&cart_key&"")
                    If not rs.EOF Then

             %>

                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0"><%=rs("TenSP")%></h6>
                        <small class="text-muted"><%=mycarts(cart_key)%></small>
                    </div>
                    <span class="text-muted"><%=rs("DonGia")%></span>
                </li>

            <%                                            

                    End if
                    rs.Close()
                    set rs = nothing
                    next
                Else
                  totalProduct=0
                End if

            %>


            <li class="list-group-item d-flex justify-content-between">
              <div class="text-success">
                <h6 class="my-0">Số lượng</h6>
              </div>
              <span class="text-success"><%=totalProduct%></span>
            </li>

            <li class="list-group-item d-flex justify-content-between">
              <span>Tổng (VND)</span>
              <h4 id="tong_gia" name="tong_gia"><%=totalAmount%></h4>
            </li>

          </ul>

          <a href="product.asp" class="text-body text-success">
            <i class="fas fa-long-arrow-alt-left me-2"></i>Quay lại
          </a>

        </div>

        <div class="col-md-8 order-md-1">
          <h4 class="mb-3">Thông tin khách hàng</h4>
          <form class="needs-validation" novalidate method="post">
            <div class="mb-3">
                <label for="FullName">Họ và tên</label>
                <input type="text" class="form-control" id="FullName" name="FullName" placeholder="" value="<%=fullname%>" required>
                <div class="invalid-feedback">
                  Valid last name is required.
                </div>

            </div>


            <div class="mb-3">
              <label for="Email">Email </label>
              <input type="email" class="form-control" id="Email" name="Email" placeholder="you@example.com" value="<%=email%>">
              <div class="invalid-feedback">
                Please enter a valid email address for shipping updates.
              </div>
            </div>

            <div class="mb-3">
                <label for="email">SĐT</span></label>
                <input type="text" class="form-control" id="phone" name="phone" placeholder="0123456789" value="<%=sdt%>">
                <div class="invalid-feedback">
                  Please enter a valid email address for shipping updates.
                </div>
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

            <input type="hidden" name="totalAmount" id="totalAmount" value="<%=totalAmount%>">
            <h4 class="mb-3">Thanh toán</h4>
            <div class="d-block my-3">
              <div class="custom-control custom-radio">
                <input id="credit" readonly name="paymentMethod" type="radio" class="custom-control-input" checked required>
                <label class="custom-control-label" for="credit">Ship COD</label>
              </div>
            </div>
    
            <hr class="mb-4">
            <button class="btn btn-success btn-lg btn-block" type="submit">Xác nhận thanh toán</button>
          </form>
         </div>
        </div>
    </div>
</div>

<!--#include file="layouts/footer.asp"-->