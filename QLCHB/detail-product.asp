<!-- #include file="connect.asp" -->
<!--#include file="layouts/header.asp"-->

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
                <form name="frmsanphamchitiet" id="frmsanphamchitiet" method="post"
                    action="/php/twig/frontend/giohang/themvaogiohang">
                    <input type="hidden" name="sp_ma" id="sp_ma" value="5">
                    <input type="hidden" name="sp_ten" id="sp_ten" value="Samsung Galaxy Tab 10.1 3G 16G">
                    <input type="hidden" name="sp_gia" id="sp_gia" value="10990000.00">
                    <input type="hidden" name="hinhdaidien" id="hinhdaidien" value="samsung-galaxy-tab-10.jpg">

                    <div class="wrapper row">
                        <!-- <div class="preview col-md-6">
                            <div class="preview-pic tab-content">
                                <div class="tab-pane" id="pic-1">
                                    <img src="../assets/img/product/samsung-galaxy-tab-10.jpg">
                                </div>
                                <div class="tab-pane" id="pic-2">
                                    <img src="../assets/img/product/samsung-galaxy-tab.jpg">
                                </div>
                                <div class="tab-pane active" id="pic-3">
                                    <img src="../assets/img/product/samsung-galaxy-tab-4.jpg">
                                </div>
                            </div>
                            <ul class="preview-thumbnail nav nav-tabs">
                                <li class="active">
                                    <a data-target="#pic-1" data-toggle="tab" class="">
                                        <img src="../assets/img/product/samsung-galaxy-tab-10.jpg">
                                    </a>
                                </li>
                                <li class="">
                                    <a data-target="#pic-2" data-toggle="tab" class="">
                                        <img src="../assets/img/product/samsung-galaxy-tab.jpg">
                                    </a>
                                </li>
                                <li class="">
                                    <a data-target="#pic-3" data-toggle="tab" class="active">
                                        <img src="../assets/img/product/samsung-galaxy-tab-4.jpg">
                                    </a>
                                </li>
                            </ul>
                        </div> -->
                        <div class="col-md-6">
                            <img src="https://product.hstatic.net/200000411281/product/banh_kem_amazing_chocolate_c89da3fb2deb4060be34f42b054922f7_master.png" class="img-thumbnail">
                        </div>
                        <div class="details col-md-6">
                            <h3 class="product-title">Samsung Galaxy Tab 10.1 3G 16G</h3>
                            <div class="rating">
                                <div class="stars">
                                    <span class="fa fa-star checked"></span>
                                    <span class="fa fa-star checked"></span>
                                    <span class="fa fa-star checked"></span>
                                    <span class="fa fa-star"></span>
                                    <span class="fa fa-star"></span>
                                </div>
                               
                            </div>
                            <p class="product-description">Màn hình 10.1 inch cảm ứng đa điểm</p>                 
                            <h4 class="price">Giá hiện tại: <span>10,990,000.00 vnđ</span></h4>
                            <p class="vote"><strong>100%</strong> hàng <strong>Chất lượng</strong>, đảm bảo
                                <strong>Uy
                                    tín</strong>!</p>
                            
                            <h5 class="colors">Số lượng:
                                <span class="color orange not-available" data-toggle="tooltip"
                                    title="Hết hàng"></span>
                                <span class="color green"></span>
                                <span class="color blue"></span>
                            </h5>
                            <div class="form-group">
                                <label for="soluong">Số lượng đặt mua:</label>
                                <input type="number" class="form-control" id="soluong" name="soluong">
                            </div>
                            <div class="action">
                                <a class="add-to-cart btn btn-default" id="btnThemVaoGioHang">Thêm vào giỏ hàng</a>
                                <a class="like btn btn-default" href="#"><span class="fa fa-heart"></span></a>
                            </div>
                        </div>

                    </div>
                </form>
            </div>
        </div>

        
    </div>
    <!-- End block content -->
</main>
<!--#include file="layouts/footer.asp"--> 