<!-- #include file="connect.asp" -->
<!-- #include file="layouts/header.asp" -->
<!-- #include file="sidebar.asp" -->
<%

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
    limit = 8

    if (trim(page) = "") or (isnull(page)) then
        page = 1
    end if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    strSQL = "SELECT COUNT(MaHD) AS count FROM HOADON"
    connDB.Open()
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
<div class="container-fluid">
    <div class="d-flex bd-highlight mb-3">
        <div class="me-auto p-2 bd-highlight"><h2>Danh sách hóa đơn</h2></div>
        <!-- <div class="p-2 bd-highlight">
            <a href="/AddCustomer.asp" class="btn btn-primary">Thêm khách hàng</a>
        </div> -->
    </div>

    <div class="table-responsive">
        <table class="table table dark">
            <thead>
                <tr>
                    <th>STT</th>
                    <th>Mã hóa đơn</th>
                    <th>Mã khách hàng</th>
                    <th>Tổng</th>
                    <th>Ngày lập</th>   
                    <th>View</th>                
                </tr>
            </thead>

            <tbody>
                <%
                        Set cmdPrep = Server.CreateObject("ADODB.Command")
                        cmdPrep.ActiveConnection = connDB
                        cmdPrep.CommandType = 1
                        cmdPrep.Prepared = True
                        cmdPrep.CommandText = "SELECT MaHD, MaKH, Tong, NgayLap FROM HOADON ORDER BY MaHD OFFSET ? ROWS FETCH NEXT ? ROWS ONLY"
                        cmdPrep.parameters.Append cmdPrep.createParameter("offset",3,1, ,offset)
                        cmdPrep.parameters.Append cmdPrep.createParameter("limit",3,1, , limit)


                        Set Result = cmdPrep.execute
                        Dim i
                        i = 0
                        do while not Result.EOF
                        i = i + 1
                %>

                    <tr>
                        <td><%= i %></td>
                        <td><%=Result("MaHD")%></td>
                        <td><%=Result("MaKH")%></td>
                        <td><%=Result("Tong")%></td>
                        <td><%=Result("NgayLap")%></td>
                         <td>
                             <!-- <a href="/EditCustomer.asp?id=<%=Result("MaKH")%>" class="btn btn-secondary"><i class="fa-solid fa-pen-to-square"></i></a>
                            <a data-href="/DeleteCustomer.asp?id=<%=Result("MaKH")%>" class="btn btn-danger" data-toggle="modal" data-target="#confirm-delete" title="Delete"><i class="fa-solid fa-trash"></i></a> -->
                             <a href="detail-bill.asp?idBill=<%=Result("MaHD")%>" class="detail-product pull-right"><i class="fa-solid fa-circle-info"></i></a> 
                        </td>
                    </tr>

                <%
                    Result.MoveNext
                    loop
                %>
            </tbody>
        </table>
    </div>
    <nav aria-label="Page Navigation">
        <ul class="pagination pagination-sm justify-content-center my-5">
            <% if (pages>1) then 
            'kiem tra trang hien tai co >=2
                    if(Clng(page)>=2) then
            %>
                    <li class="page-item"><a class="page-link" href="BillManagement.asp?page=<%=Clng(page)-1%>">Previous</a></li>
            <%    
                    end if 
                    for i= 1 to range
            %>
                        <li class="page-item <%=checkPage(Clng(i)=Clng(page),"active")%>"><a class="page-link" href="BillManagement.asp?page=<%=i%>"><%=i%></a></li>
            <%
                    next
                    if (Clng(page)<pages) then

            %>
                    <li class="page-item"><a class="page-link" href="BillManagement.asp?page=<%=Clng(page)+1%>">Next</a></li>
            <%
                    end if    
                end if
            %>
        </ul>
    </nav>
</div>


<!-- #include file="layouts/footer.asp" -->