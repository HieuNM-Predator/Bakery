<!-- #include file="connect.asp" -->
<!-- #include file="layouts/header.asp" -->
<!-- #include file="sidebar.asp" -->

<div class="container">
    <div class="d-flex bd-highlight mb-3">
        <div class="me-auto p-2 bd-highlight"><h2>Danh sách tài khoản</h2></div>
        <div class="p-2 bd-highlight">
            <a href="" class="btn btn-primary">Thêm tài khoản</a>
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table dark">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Email</th>
                    <th>Mật khẩu</th>
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
                        cmdPrep.CommandText = "SELECT Id, TenTK, MatKhau FROM TAIKHOAN"
                        ' cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                        ' cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)


                        Set Result = cmdPrep.execute
                        do while not Result.EOF
                %>

                    <tr>
                        <td><%=Result("Id")%></td>
                        <td><%=Result("TenTK")%></td>
                        <td><%=Result("MatKhau")%></td>
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