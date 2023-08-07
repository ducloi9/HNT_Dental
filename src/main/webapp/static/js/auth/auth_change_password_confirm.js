$(document).ready(function () {
        const change = $('#change');
        change.validate({
            rules: {
                newPassword: {
                    required: true,
                    maxlength: 50
                },
                rePassword: {
                    required: true,
                    maxlength: 50
                },
                oldPassword: {
                    required: true,
                    maxlength: 50
                },
            },
            messages: {
                oldPassword: {
                    required: 'Vui lòng nhập mật khẩu',
                    maxlength: 'Mật khẩu không được quá 50 ký tự',
                },
            },
            submitHandler: function () {
                getChangePassword();
            }
        });
    }
);

function getChangePassword() {
    $.ajax({
        url: '/auth/changePassword',
        type: 'POST',
        data: $('#login').serialize(),
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
        }
    });
}