$.validator.addMethod('dob', function(value, element) {
    // Parse the date string into a Date object
    const dob = new Date(value)

    // Calculate the age in milliseconds
    const ageInMs = Date.now() - dob.getTime()

    // Calculate the age in years
    const ageInYears = ageInMs / (1000 * 60 * 60 * 24 * 365.25)

    // Check if the age is greater than or equal to 18
    return ageInYears >= 18
}, 'Bạn phải đủ 18 tuổi để đăng ký tài khoản');

$(document).ready(function () {
        const register = $('#register');
        register.validate({
            rules: {
                email: {
                    required: true,
                    email: true,
                },
                password: {
                    required: true,
                    maxlength: 50
                },
                fullName: {
                    required: true,
                    maxlength: 255
                },
                phone: {
                    required: true,
                    number: true,
                    maxlength: 10
                },
                dob: {
                    required: true,
                    date: true,
                    dob: true
                },

                address: {
                    required: true,
                    maxlength: 200
                },
                confirmPassword: {
                    required: true,
                    equalTo: "#password"
                },
                acceptTncCheck: {
                    required: true
                }

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
                fullName: {
                    required: 'Vui lòng nhập họ và tên',
                    maxlength: 'họ và tên không được quá 255 ký tự',
                },
                phone: {
                    required: 'Vui lòng nhập số điện thoại',
                    number: 'Số điện thoại không đúng định dạng',
                    maxlength: 'Số điện thoại không được quá 10 ký tự',
                },
                dob: {
                    required: 'Vui lòng nhập ngày sinh',
                },
                address: {
                    required: 'Vui lòng nhập địa chỉ',
                    maxlength: 'Địa chỉ không được quá 200 ký tự',
                },
                confirmPassword: {
                    required: 'Vui lòng nhập lại mật khẩu',
                    equalTo: 'Mật khẩu không trùng khớp',
                },
                acceptTncCheck: {
                    required: 'Vui lòng đồng ý với điều khoản sử dụng dịch vụ',
                }
            },
            submitHandler: function () {
                getRegister();
            }
        });
    }
);

function getRegister() {
    document.getElementById('btn-register').disabled = true;
    $.ajax({
        url: '/auth/register',
        type: 'POST',
        data: $('#register').serialize(),
        beforeSend: function () {
            $('.preloader-custom').preloader();
        },
        success: function (data) {
            $('.preloader-custom').preloader('remove');
            switch (data.message) {
                case 'email_existed':
                    document.getElementById("content").style.color = "red";
                    document.getElementById("content").innerHTML = "Email đã tồn tại!";
                    break;
                case 'success':
                    document.getElementById("content").style.color = "green";
                    Swal.fire({
                        confirmButtonColor: '#396cf0',
                        title: 'Đăng ký thành công',
                        icon: 'success',
                        text: 'Vui lòng kiểm tra email để xác nhận'
                    })
                    break;
                default:
                    document.getElementById("content").style.color = "red";
                    document.getElementById("content").innerHTML = "Đăng ký thất bại!";
                    break;
            }
            document.getElementById('btn-register').disabled = false;
        },
        error: function (data) {
            console.log(data);
            document.getElementById("content").style.color = "red";
            document.getElementById("content").innerHTML = "Đăng ký thất bại!";
            document.getElementById('btn-register').disabled = false;
            $('.preloader-custom').preloader('remove');
        }
    });
}

function showTerms() {
    Swal.fire({
        confirmButtonColor: '#396cf0',
        title: 'Điều khoản sử dụng dịch vụ',
        html: `
      <ol class="list-terms">
        <li class="list-terms-item align-content-start">
          <strong>Quy định về việc sử dụng dịch vụ:</strong>
          <ul>
            <li>Người dùng cần phải tuân thủ các quy định và hướng dẫn được đưa ra trên trang web.</li>
            <li>Việc sử dụng dịch vụ phải tuân thủ các quy định pháp luật hiện hành.</li>
          </ul>
        </li>
        <li>
          <strong>Quy định về bảo mật thông tin:</strong>
          <ul>
            <li>Các thông tin liên quan đến người dùng sẽ được bảo mật tuyệt đối và không được tiết lộ cho bất kỳ bên thứ ba nào mà không có sự đồng ý của người dùng.</li>
            <li>Trong trường hợp có sự cố liên quan đến bảo mật thông tin, phòng khám nha khoa sẽ thông báo ngay cho người dùng để có biện pháp xử lý kịp thời.</li>
          </ul>
        </li>
        <li>
          <strong>Quy định về thanh toán và hoàn tiền:</strong>
          <ul>
            <li>Người dùng sẽ phải thanh toán đầy đủ số tiền theo quy định sau khi sử dụng dịch vụ.</li>
            <li>Trường hợp người dùng muốn hủy bỏ dịch vụ đã đăng ký, phòng khám nha khoa sẽ xử lý và hoàn tiền cho người dùng theo quy định.</li>
          </ul>
        </li>
        <li>
          <strong>Quy định về giải quyết tranh chấp:</strong>
          <ul>
            <li>Trong trường hợp có tranh chấp liên quan đến việc sử dụng dịch vụ, các bên sẽ cố gắng giải quyết bằng thỏa thuận hòa giải.</li>
            <li>Nếu không thể giải quyết được, tranh chấp sẽ được chuyển đến cơ quan có thẩm quyền để giải quyết.</li>
          </ul>
        </li>
      </ol>
    `,
        showCloseButton: true,
        width: '600px',
    });
}
