$(document).ready(function () {
        const forgot = $('#forgot');
        forgot.validate({
            rules: {
                email: {
                    required: true,
                    email: true,
                }
            },
            messages: {
                email: {
                    required: 'Vui lòng nhập Email',
                    email: 'Email không đúng định dạng',
                },

            },
            submitHandler: function () {
                getForgotPassword() ;
            }
        });
    }
);

function getForgotPassword() {
    $.ajax({
        url: '/auth/forgot',
        type: 'POST',
        data: $('#forgot').serialize(),
        beforeSend: function () {
            $('.preloader-custom').preloader();
        },
        success: function (data) {
            switch (data.message) {
                case 'email_not_existed':
                    document.getElementById("content").innerHTML = "Email không tồn tại!";
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