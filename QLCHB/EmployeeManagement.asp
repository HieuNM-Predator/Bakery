<!-- #include file="connect.asp" -->
<!-- #include file="layouts/header.asp" -->
<!-- #include file="sidebar.asp" -->

    <div class="container-fluid">
        <div class="d-flex bd-highlight mb-3">
            <div class="me-auto p-2 bd-highlight"><h2>Danh sách nhân viên</h2></div>
            <div class="p-2 bd-highlight">
                <a href="/AddEmployee.asp" class="btn btn-primary">Thêm nhân viên</a>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table dark">
                <thead>
                    <tr>
                        <th>Mã nhân viên</th>
                        <th>Họ tên</th>
                        <th>Email</th>
                        <th>SĐT</th>
                        <th>Địa chỉ</th>
                        <th>Giới tính</th>
                        <th>CCCD</th>
                        <th>Ngày sinh</th>
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
                            cmdPrep.CommandText = "SELECT MaNV, TenNV, Email, SDT, DiaChi, GioiTinh, CCCD, NgaySinh FROM NHANVIEN"
                            ' cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                            ' cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)


                            Set Result = cmdPrep.execute
                            do while not Result.EOF
                    %>

                        <tr>
                            <td><%=Result("MaNV")%></td>
                            <td><%=Result("TenNV")%></td>
                            <td><%=Result("Email")%></td>
                            <td><%=Result("SDT")%></td>
                            <td><%=Result("DiaChi")%></td>
                            <td><%=Result("GioiTinh")%></td>
                            <td><%=Result("CCCD")%></td>
                            <td><%=Result("NgaySinh")%></td>
                            <td>
                                <a href="/EditEmployee.asp?id=<%=Result("MaNV")%>" class="btn btn-secondary"><i class="fa-solid fa-pen-to-square"></i></a>
                                <a data-href="/DeleteEmployee.asp?id=<%=Result("MaNV")%>" class="btn btn-danger" data-toggle="modal" data-target="#confirm-delete" title="Delete"><i class="fa-solid fa-trash"></i></a>
                            </td>
                        </tr>

                    <%
                        Result.MoveNext
                        loop
                    %>
                </tbody>
            </table>
        </div>
        <!-- <div class="modal" tabindex="-1" id="confirm-delete">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Xác nhận xóa</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>Bạn có chắc muốn xóa sản phẩm?</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    <a class="btn btn-danger btn-delete">Xóa</a>
                </div>
            </div>
        </div>
    </div> -->
    <div class="modal" tabindex="-1" role="dialog" id="confirm-delete">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title">Xác nhận xóa</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <p>Bạn có chắc muốn xóa sản phẩm?</p>
            </div>
            <div class="modal-footer">
              <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
              <!-- <button type="button" class="btn btn-primary">Xóa sản phẩm</button> -->
              <a class="btn btn-danger btn-delete">Xóa</a>
            </div>
          </div>
        </div>
       </div>
      <!--END confirm delete-->
    </div>

<!-- #include file="layouts/footer.asp" -->