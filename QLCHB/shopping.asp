<!-- #include file="connect.asp" -->
<!--#include file="layouts/header.asp"-->
<section class="h-100 h-custom" style="background-color: #eee; margin-bottom: 259px">
    <div class="container py-2 h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12">
          <div class="card card-registration card-registration-2" style="border-radius: 15px;">
            <div class="card-body p-0">
              <div class="row g-0">
                <div class="col-lg-8">
                  <div class="p-5">
                    <div class="d-flex justify-content-between align-items-center mb-5">
                      <h1 class="fw-bold mb-0 text-black">Giỏ hàng</h1>
                      <h6 class="mb-0 text-muted"></h6>
                    </div>
                    <form action="removecart.asp" method=post>
                    <hr class="my-4">
                    <h5 class="mt-3 text-center text-body-secondary <%= statusViews %>">Bạn phải thêm sản phẩm vào trong giỏ</h5>
  <%
                  If (totalProduct<>0) Then
                  do while not rs.EOF
                  %>
                    <div class="row mb-4 d-flex justify-content-between align-items-center">
                      <div class="col-md-2 col-lg-2 col-xl-2">
                        <img
                          src="https://mdbcdn.b-cdn.net/img/Photos/Horizontal/E-commerce/Products/img%20(4).webp"
                          class="img-fluid rounded-3" alt="Cotton T-shirt">
                      </div>
                      <div class="col-md-3 col-lg-3 col-xl-3">
                        <h6 class="text-muted"><%= rs("tensp")%></h6>
                        <h6 class="text-black mb-0"><%= rs("mota")%></h6>
                      </div>
                      <div class="col-md-3 col-lg-3 col-xl-2 d-flex">
                        <button class="btn btn-link px-2"
                          onclick="this.parentNode.querySelector('input[type=number]').stepDown()">
                          <i class="fas fa-minus"></i>
                        </button>
  
                        <input id="form1" min="0" name="quantity" value="<%
                                      Dim id
                                      id  = CStr(rs("masp"))
                                      Response.Write(mycarts.Item(id))                                     
                                      %>" type="number"
                          class="form-control form-control-sm" />
  
                        <button class="btn btn-link px-2"
                          onclick="this.parentNode.querySelector('input[type=number]').stepUp()">
                          <i class="fas fa-plus"></i>
                        </button>
                      </div>
                      <div class="col-md-3 col-lg-2 col-xl-2 offset-lg-1">
                        <h6 class="mb-0">$ <%= rs("giasp")%></h6>
                      </div>
                      <div class="col-md-1 col-lg-1 col-xl-1 text-end">
                      
                        <a href="removecart.asp?id=<%= rs("masp")%>" class="text-muted"><i class="fas fa-times"></i></a>
                      </div>
                    </div>
  
                    <hr class="my-4">
  <%
                  rs.MoveNext
                  loop
                  'phuc vu cho viec update subtotal
                  rs.MoveFirst
                  End If
                  %> 
                  
                    <div class="row pt-2">
                      <h6 class="mb-0 col-lg-10 pt-3"><a href="product.asp" class="text-body"><i
                            class="fas fa-long-arrow-alt-left me-2"></i>Quay lại trang sản phẩm</a></h6>
                            <input type="submit" name="update" value="Update" class="btn btn-warning btn-block btn-lg text-white col-lg-2 <%= statusButtons %>"
                      data-mdb-ripple-color="dark"/>
                    </div>
                  </form>
                  </div>
                </div>
                <div class="col-lg-4 bg-secondary-subtle <%= statusButtons %>">
                  <div class="p-5">
                    <h3 class="fw-bold mb-5 mt-2 pt-1">Hoá đơn hàng</h3>
                    <!-- <hr class="my-4"> -->
  
                    <!-- <div class="d-flex justify-content-between mb-4">
                      <h5 class="text-uppercase"></h5>
                      <h5>$ <%= subtotal%></h5>
                    </div> -->
  
                    <!-- <h5 class="text-uppercase mb-3">Shipping</h5> -->
  
                    <!-- <div class="mb-4 pb-2">
                      <select class="select">
                        <option value="1">Standard-Delivery- $5</option>
                        <option value="2">Two</option>
                        <option value="3">Three</option>
                        <option value="4">Four</option>
                      </select>
                    </div> -->
  
                    <!-- <h5 class="text-uppercase mb-3">Give code</h5> -->
  
                    <!-- <div class="mb-5">
                      <div class="form-outline">
                        <input type="text" id="form3Examplea2" class="form-control form-control-lg" />
                        <label class="form-label" for="form3Examplea2">Enter your code</label>
                      </div>
                    </div> -->
  
                    <hr class="my-4">
  
                    <div class="d-flex justify-content-between mb-5">
                      <h5 class="text-uppercase">Tổng tiền</h5>
                      <h5>VND <%= subtotal %></h5>
                    </div>
                    <div class="row">
                      <button type="button" class="btn btn-success btn-lg"
                        data-mdb-ripple-color="dark">Thanh toán</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </section>
<!--#include file="layouts/footer.asp"-->