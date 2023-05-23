<!--#include file="connect.asp"-->
<!--#include file="layouts/header.asp"-->

<div class="container form-signup">
    <form method="post" action="signup.asp">
        <div class="mb-3">
            <label for="user-name" class="form-label">Tên khách hàng</label>
            <input type="text" class="form-control" id="user-name" name="user-name">
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="text" class="form-control" id="email" name="email" value="">
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password">
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="address" name="address">
        </div>
        <div class="mb-3">
            <label for="DoB" class="form-label">Ngày sinh</label>
            <input type="date" class="form-control" id="date" name="date">
        </div>
        <div class="mb-3">
            <!-- <label for="gender" class="form-label">Giới tính</label>
            <div class="gender-chosen">
                <span class="gender">
                    <label class="gender">Nam</label>
                    <input type="radio" id="male" name="gender">
                </span>
                <span class="gender female">
                    <label class="gender female">Nữ</label>
                    <input type="radio" id="female" name="gender">
                </span>
            </div> -->
            <label for="gender" class="form-label">Giới tính:</label>
            <label class="radio-inline gender">
                <input type="radio" id="male" name="gender">Nam
            </label>
            <label class="radio-inline gender">
                <input type="radio" id="female" name="gender">Nữ
            </label>
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="phone" name="phone">
        </div>
        <div class="mb-3 pt-3"> 
        <button type="submit" class="btn-signup">Đăng ký</button>
        </div>
    </form>
</div>
<!--#include file="layouts/footer.asp"-->