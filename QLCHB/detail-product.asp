<!-- #include file="connect.asp" -->
<!--#include file="layouts/header.asp"-->

<%
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") Then
        ' true
        id = Request.QueryString("id")
        If (id<>"") Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM SANPHAM WHERE MaSP=?"
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                name = Result("TenSP")
                price = Result("DonGia")
                description = Result("MoTa")
                img = Result("HinhAnh")
            End If

            ' Set Result = Nothing
            ' Result.Close()
        End If
        ' false
    End if
%>

<main role="main" style="margin-top:40px; margin-bottom:40px;">
    <!-- Block content - Đục lỗ trên giao diện bố cục chung, đặt tên là content -->
    <div class="container mt-4">
        <div id="thongbao" class="alert alert-danger d-none face" role="alert">
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">×</span>
            </button>
        </div>

        <div class="card">
            <div class="container-fliud">
                <form name="frmsanphamchitiet" id="frmsanphamchitiet" method="post">
                    <input type="hidden" name="sp_ma" id="sp_ma" value="<%= Result("MaSP")%>">
                    <input type="hidden" name="sp_ten" id="sp_ten" value="<%= Result("TenSP")%>">
                    <input type="hidden" name="sp_gia" id="sp_gia" value="<%= Result("DonGia")%>">
                    <input type="hidden" name="hinhdaidien" id="hinhdaidien" value="<%= Result("HinhAnh")%>">

                    <div class="wrapper row">
                        
                        <div class="col-md-6">
                            <img src="<%= Result("HinhAnh")%>" class="img-thumbnail">
                        </div>
                        <div class="details col-md-6">
                            <h3 class="product-title" style="color:#b1c23c"><%= Result("TenSP")%></h3>

                            <p class="product-description">Mô tả: <span style="font-style: italic;"><%= Result("MoTa")%></span></p>                 
                            <h4 class="price">Đơn giá: <span style="color:#b1c23c"><%= Result("DonGia")%></span>VND</h4>
                            
                            <!--<h5 class="colors">Số lượng:
                            </h5>
                            <div class="form-group">
                                <label for="soluong">Số lượng đặt mua:</label>
                                <input type="number" class="form-control" id="soluong" name="soluong">
                            </div>-->
                            <div class="action">
                                <!--<a class="add-to-cart btn btn-default" id="btnThemVaoGioHang">Thêm vào giỏ hàng</a>-->
                                <a href="" class="link-cart">Thêm vào giỏ hàng <i class="fa fa-shopping-cart"></i></a>
                                <h6 class="mb-0 col-lg-10 pt-1">
                                <a href="product.asp" class="text-body" style="color:#b1c23c">
                                    <i class="fas fa-long-arrow-alt-left me-2"></i>Quay lại trang sản phẩm
                                </a>
                                </h6>
                            </div>

                        </div>

                    </div>
                    
                </form>
            </div>
        </div>

        <%
            Result.Close()
            connDB.Close()
        %>
    </div>
    <!-- End block content -->
</main>
<!--#include file="layouts/footer.asp"--> 