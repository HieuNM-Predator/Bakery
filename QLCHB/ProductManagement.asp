<!-- #include file="connect.asp" -->
<!-- #include file="layouts/header.asp" -->
<!-- #include file="sidebar.asp" -->

<div class="container-fluid">
    <div class="d-flex bd-highlight mb-3">
        <div class="me-auto p-2 bd-highlight"><h2>Danh sách sản phẩm</h2></div>
        <div class="p-2 bd-highlight">
            <a href="" class="btn btn-primary">Thêm sản phẩm</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table dark">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã sản phẩm</th>
                    <th>Tên sản phẩm</th>
                    <th>Đơn giá</th>
                    <th>Loại</th>
                    <th>Mô tả</th>
                    <th>Hình ảnh</th>
                    <th>Tình trạng</th>
                    <th>Thao tác</th>
                </tr>
            </thead>

            <tbody>
                <%
                        Set cmdPrep = Server.CreateObject("ADODB.Command")
                        connDB.Open()
                        cmdPrep.ActiveConnection = connDB
                        cmdPrep.CommandType = 1
                        cmdPrep.Prepared = True
                        cmdPrep.CommandText = "SELECT * FROM SANPHAM"
                        ' cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                        ' cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)


                        Set Result = cmdPrep.execute
                        Dim i
                        i = 0
                        do while not Result.EOF
                        i = i + 1
                %>

                    <tr>
                        <td><%= i %></td>
                        <td><%=Result("MaSP")%></td>
                        <td><%=Result("TenSP")%></td>
                        <td><%=Result("DonGia")%></td>
                        <td><%=Result("Loai")%></td>
                        <td><%=Result("MoTa")%></td>
                        <td><%=Result("HinhAnh")%></td>
                        <td><%=Result("TinhTrang")%></td>
                        <td>
                            <a href="" class="btn btn-secondary"><i class="fa-solid fa-pen-to-square"></i></a>
                            <a data-href="" class="btn btn-danger"title="Delete"><i class="fa-solid fa-trash"></i></a>
                        </td>
                    </tr>

                <%
                    Result.MoveNext
                    loop
                %>
            </tbody>
        </table>
    </div>
</div>

<!-- #include file="layouts/footer.asp" -->