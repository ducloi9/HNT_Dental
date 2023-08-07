$(document).ready(function () {
        const confirmForgot = $('#confirmForgot');
        confirmForgot.validate({
            rules: {
                password: {
                    required: true,
                    maxlength: 50
                },
                confirmForgot: {
                    required: true,
                    equalTo: "#password"
                }
            },
            messages: {
                password: {
                    required: 'Vui lòng nhập mật khẩu',
                    maxlength: 'Mật khẩu không được quá 50 ký tự',
                },
                confirmForgot: {
                    required: 'Vui lòng nhập lại mật khẩu',
                    equalTo: 'Mật khẩu không trùng khớp',
                }

            },
            submitHandler: function () {
                getConfirmForgotPassword();
            }
        });
    }
);

function getConfirmForgotPassword() {
    $.ajax({
        url: '/auth/forgot/confirm',
        type: 'POST',
        data: $('#confirmForgot').serialize(),
        beforeSend: function () {
            $('.preloader-custom').preloader();
        },
        success: function (data) {
            switch (data.message) {
                case 'token-invalid':
                    document.getElementById("content").innerHTML = "Link đã hết hạn"
                    break;
                case 'error':
                    document.getElementById("content").innerHTML = "Đã có lỗi xảy ra"
                    break;
                case 'success':
                    window.location.href = "/auth/login"
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