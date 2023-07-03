<!-- #include file="connect.asp" -->
<!--#include file="layouts/header.asp"-->
<!-- #include file="sidebar.asp" -->
<%
    Dim idBill
    idBill = Request.QueryString("idBill")
    'Do Something...
    If (NOT IsNull(idBill) and idBill <> "") Then
        Dim cmdPrep, rs
        Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM CTHD INNER JOIN SANPHAM ON CTHD.MaSP = SANPHAM.MaSP WHERE MaHD=?"
            cmdPrep.Parameters(0)=idBill
            Set rs = cmdPrep.execute 
            If not rs.EOF then
                Set madh = rs("MaDH")
                Set mahd = rs("MaHD")
                Set tensp = rs("TenSP")
                Set soluong = rs("SoLuong")              
            Else
                 connDB.Close()
                 Session("Error") = "Hoá đơn không tồn tại"
            End If
    Else 
         Session("Error") = "Hóa đơn lựa chọn không thể kiểm tra"
    End If
%>
<div class="container-fluid">
    <div class="d-flex bd-highlight mb-3">
        <div class="me-auto p-2 bd-highlight"><h2>Bảng chi tiết hóa đơn</h2></div>
    </div>

    <div class="table-responsive">
        <table class="table table dark">
            <thead>
                <tr>
                    <th>Mã đơn hàng</th>
                    <th>Mã hóa đơn</th>
                    <th>Tên sản phẩm</th>
                    <th>Số lượng</th>                
                </tr>
            </thead>

            <tbody>
                <% do while Not rs.EOF %>
                    <tr>                       
                        <td><%=madh%></td>
                        <td><%=mahd%></td>
                        <td><%=tensp%></td>
                        <td><%=soluong%></td>
                    </tr>
                <%
                   rs.MoveNext
                   loop
                   rs.Close()
                %>
            </tbody>
        </table>
    </div>
</div>


<!-- #include file="layouts/footer.asp" -->