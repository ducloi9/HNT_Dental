$(document).ready(function () {
        const login = $('#login');
        login.validate({
            rules: {
                email: {
                    required: true,
                    email: true,
                },
                password: {
                    required: true,
                    maxlength: 50
                },
            },
            messages: {
                email: {
                    required: 'Vui lòng nhập Email',
                    email: 'Email không đúng định dạng',
                },
                password: {
                    required: 'Vui lòng nhập mật khẩu',
                    maxlength: 'Mật khẩu không được quá 50 ký tự',
                },
            },
            submitHandler: function () {
                getLogin();
            }
        });
    }
);

function getLogin() {
    $.ajax({
        url: '/auth/login',
        type: 'POST',
        data: $('#login').serialize(),
        beforeSend: function () {
            $('.preloader-custom').preloader();
        },
        success: function (data) {
            switch (data.message) {
                case 'email_incorrect':
                    document.getElementById("content").innerHTML = "Email không tồn tại!";
                    break;
                case 'password_incorrect':
                    document.getElementById("content").innerHTML = "Mật khẩu không đúng!";
                    break;
                case 'account_not_verified':
                    document.getElementById("content").innerHTML = "Tài khoản đã bị khóa!";
                    break;
                case 'success':
                    window.location.href = "/home";
                    break;
            }
        },
        error: function (data) {
            console.log(data);
        },
        complete: function () {
            $('.preloader-custom').preloader('remove');
        }
    });
}