<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display&display=swap" rel="stylesheet">
    
    <!-- font font-awesome -->
    <link rel="stylesheet" href="/files/fontawesome-free-6.4.0-web/css/solid.css">
    <link rel="stylesheet" href="/files/fontawesome-free-6.4.0-web/css/all.min.css">
    <link rel="stylesheet" href="/files/fontawesome-free-6.4.0-web/css/brands.min.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <!-- CSS -->
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="/css/header.css">
    <link rel="stylesheet" href="/css/footer.css">
    <link rel="stylesheet" href="/css/login.css">
    <link rel="stylesheet" href="/css/signup.css">
    <link rel="stylesheet" href="/css/product.css">
    <title>Fresh garden</title>
</head>
<body>
    <nav class="navbar navbar-expand-sm navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" style="color: blanchedalmond;" href="#"><img src="./files/img/logo.png" alt="LoGo" class="img-responsive logo"></a>
            <button class="navbar-toggler d-lg-none" type="button" data-toggle="collapse" data-target="#collapsibleNavId" aria-controls="collapsibleNavId"
                aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="collapsibleNavId">
                <ul class="navbar-nav mr-auto mt-2 mt-lg-0 mx-auto">
                    <li class="nav-item active">
                        <a class="nav-link title_header" href="index.asp">Trang chủ<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link title_header" href="product.asp">Sản phẩm<span class="sr-only">(current)</span></a>
                    </li>
                </ul>
                <div class="header-icon d-flex">
                    <a href="shopping.asp" class="icon-shopping-cart" style="color: #fff; margin-left: 20px; padding: 8px;"><i class="fa fa-shopping-cart icon_cart"></i></a>
                    <%
                        If (NOT isnull(Session("email"))) AND (Trim(Session("email")) <> "") Then
                            ' true
                    %>
                            <span class="navbar-text">Xin chào <%=Session("email")%>!</span>
                            <a href="logout.asp" class="icon-logout" style="color: #fff; margin-left: 7px;
                            padding: 8px;"><i class="fa-solid fa-arrow-right-from-bracket"></i></a>
                    <%
                        Else
                            ' false
                    %>
                        <a href="login.asp" class="icon-login" style="padding: 8px;"><i class="fa fa-user icon_login"></i></a>
                    <%
                        End if
                    %>
                </div>
                <!--<div class="d-flex">
                    <a href="#" class="btn btn-light">Đăng nhập<i class="fa fa-user icon_login"></i></a>
                </div>-->
            </div>
        </div>
    </nav>
    <!-- END HEADER -->
    
    <div class="container">
        <%
        If (NOT isnull(Session("Success"))) AND (TRIM(Session("Success"))<>"") Then
        %>
            <div class="alert alert-success" role="alert">
                <%=Session("Success")%>
             </div>
        <%
            Session.Contents.Remove("Success")
            End If
        %>
        <%
            If (NOT isnull(Session("Error"))) AND (TRIM(Session("Error"))<>"") Then
        %>
            <div class="alert alert-danger" role="alert">
                <%=Session("Error")%>
            </div>
        <%
            Session.Contents.Remove("Error")
            End If
        %>
    </div>

    <div class="main-content">
        <!-- main content is in here -->