<!--#include file="layouts/header.asp"-->
<!--#include file="connect.asp"-->
<%
    ' code here to retrive the data from product table
    Dim sqlString, rs
    sqlString = "Select * from SANPHAM"
    connDB.Open()
    set rs = connDB.execute(sqlString)  
   
'Phan trang'
' ham lam tron so nguyen
    function Ceil(Number)
        Ceil = Int(Number)
        if Ceil<>Number Then
            Ceil = Ceil + 1
        end if
    end function

    function checkPage(cond, ret) 
        if cond=true then
            Response.write ret
        else
            Response.write ""
        end if
    end function
    ' trang hien tai
    page = Request.QueryString("page")
        limit = 4
    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if
    offset = (Clng(page) * Clng(limit)) - Clng(limit)
    strSQL = "SELECT COUNT(MaSP) AS count FROM SANPHAM"
    'connDB.Open()
    Set CountResult = connDB.execute(strSQL)
    totalRows = CLng(CountResult("count"))
    Set CountResult = Nothing
' lay ve tong so trang
    pages = Ceil(totalRows/limit)
    'gioi han tong so trang la 5
    Dim range
    If (pages<=5) Then
        range = pages
    Else
        range = 5
    End if
%>
<main role="main">
    <!-- Danh sách sản phẩm -->
    <section class="jumbotron text-center">
        <div class="container">
            <h1 class="jumbotron-heading">Danh sách Sản phẩm</h1>
        </div>
    </section>

    <!-- Giải thuật duyệt và render Danh sách sản phẩm theo dòng, cột của Bootstrap -->
        <div class="danhsachsanpham py-5 bg-light">
            <div class="container">
                <div class="row">          
                    <%
                    Set cmdPrep = Server.CreateObject("ADODB.Command")
                    cmdPrep.ActiveConnection = connDB
                    cmdPrep.CommandType = 1
                    cmdPrep.Prepared = True
                    cmdPrep.CommandText = "SELECT * FROM SANPHAM ORDER BY MaSP OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                    cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                    cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)

                    Set rs = cmdPrep.execute
                    do while not rs.EOF
                     %>
                    <div class="col-xs-1 col-md-3 productOfIndex">
                        <div class="box">
                            <img src="<%=rs("HinhAnh")%>" alt="" class="img-responsive img-sp">
                        </div>
                        <div class="detail-box">
                            <h6 class="product-name"><%= rs("TenSP")%></h6>
                            <h6 class="product-price"><%= rs("DonGia") %>VND</h6>
                            <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                            <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                        </div>
                    </div>
    
                    <!-- <div class="col-xs-1 col-md-3 productOfIndex">
                        <div class="box">
                            <img src="https://product.hstatic.net/200000411281/product/1-03_9153eb9828514f419bdccc9dbe49e410_master.jpg" alt="" class="img-responsive img-sp">
                        </div>
                        <div class="detail-box">
                            <h6 class="product-name">Bánh kem Cloudy Doraemon</h6>
                            <h6 class="product-price">300000VND</h6>
                            <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                            <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                        </div>
                    </div>
        
    
                    <div class="col-xs-1 col-md-3 productOfIndex">
                        <div class="box">
                            <img src="https://product.hstatic.net/200000411281/product/endless_love_c7027cf9711b4fde9b654c0a5da1bee9_master.png" alt="" class="img-responsive img-sp">
                        </div>
                        <div class="detail-box">
                            <h6 class="product-name">Bánh kem Endless Love</h6>
                            <h6 class="product-price">300000VND</h6>
                            <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                            <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                        </div>
                    </div>
                    <div class="col-xs-1 col-md-3 productOfIndex">
                        <div class="box">
                            <img src="https://product.hstatic.net/200000411281/product/banh_kem_amazing_chocolate_c89da3fb2deb4060be34f42b054922f7_master.png" alt="" class="img-responsive img-sp">
                        </div>
                        <div class="detail-box">
                            <h6 class="product-name">Bánh kem Chocolate Lover</h6>
                            <h6 class="product-price">300000VND</h6>
                            <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                            <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                        </div>
                    </div> -->
                    <%
                    rs.MoveNext
                    loop
                    rs.Close()
                    connDB.Close()
                    %> 
                </div>
          <!--  <div class="row">

                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/rosie_love_24e1cc3a3aab4b65a82a2d080e4d2785_master.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Rosie Love</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>

                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/1-01_3a81a0864ccc48adbad99820677e1133_master.jpg" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Pink Angle</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>
    

                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/1-removebg-preview__1___1__cd1a59ee89344030956d4a191392282c_grande.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Love Melody</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>
                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/7-removebg-preview__1___1__301d13b05c0449838515ab346bac0e7a_grande.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Tasty Love</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>
            </div>
            <div class="row">

                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/3_0ce516afdfce46df8af5780791947af0_grande.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Blue Ocean</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>

                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/4_619645dada9b423890c9ae9880900c6c_grande.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Romantic</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>
    

                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/thiet_ke_chua_co_ten__3__7899d2bdbec44f51b2fac69ef76a8f72_grande.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh kem Mousse Mango</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>
                <div class="col-xs-1 col-md-3 productOfIndex">
                    <div class="box">
                        <img src="https://product.hstatic.net/200000411281/product/2_6021e843fcb8458aa4f889525b3b2ff2_grande.png" alt="" class="img-responsive img-sp">
                    </div>
                    <div class="detail-box">
                        <h6 class="product-name">Bánh Passion Fruit Mousse</h6>
                        <h6 class="product-price">300000VND</h6>
                        <a href="" class="link-cart"><i class="fa fa-shopping-cart"></i></a>
                        <a href="" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a>
                    </div>
                </div>
            </div> 

            </div>-->
        </div>
    </div>
    <nav aria-label="Page Navigation">
        <ul class="pagination pagination-sm justify-content-center my-5">
            <% if (pages>1) then
            'kiem tra trang hien tai co >=2
                if(Clng(page)>=2) then
            %>
                <li class="page-item"><a class="page-link" href="product.asp?page=<%=Clng(page)-1%>">Previous</a></li>
            <%    
                end if 
                for i= 1 to range
            %>
                    <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="product.asp?page=<%=i%>"><%=i%></a></li>
            <%
                next
                if (Clng(page)<pages) then
    
            %>
                <li class="page-item"><a class="page-link" href="product.asp?page=<%=Clng(page)+1%>">Next</a></li>
            <%
                end if    
            end if
            %>
        </ul>
    </nav>
    

    <!-- End block content -->
</main>
    


<!--#include file="layouts/footer.asp"-->