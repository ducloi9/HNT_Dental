<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 6/3/2023
  Time: 12:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="vi">

<jsp:include page="layout/header.jsp"/>

<body>
<jsp:include page="layout/menu-header-white.jsp"/>
<style>
    .Choicefile {
        display: block;
        background: #396CF0;
        border: 1px solid #fff;
        color: #fff;
        width: 150px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        padding: 5px 0px;
        border-radius: 5px;
        font-weight: 500;
        align-items: center;
        justify-content: center;
    }

    .Choicefile:hover {
        text-decoration: none;
        color: white;
    }

    #uploadfile,
    .removeimg {
        display: none;
    }

    #thumbbox {
        position: relative;
        width: 100%;
        margin-bottom: 20px;
    }

    .removeimg {
        height: 25px;
        position: absolute;
        background-repeat: no-repeat;
        top: 5px;
        left: 5px;
        background-size: 25px;
        width: 25px;
        border-radius: 50%;
    }

    .removeimg::before {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        content: '';
        border: 1px solid red;
        background: red;
        text-align: center;
        display: block;
        margin-top: 11px;
        transform: rotate(45deg);
    }

    .removeimg::after {
        content: '';
        background: red;
        border: 1px solid red;
        text-align: center;
        display: block;
        transform: rotate(-45deg);
        margin-top: -2px;
    }

</style>
<section class="bg-dashboard">
    <div>
        <div class="row justify-content-center">
            <jsp:include page="layout/profile-sidebar.jsp"/>
            <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                <h3 class="mb-0"></h3>
                <div class="rounded shadow mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Thông tin tài khoản</h5>
                        <p class="text-bg-danger p-1 w-50 rounded-3"
                                <c:if test="${empty error}">
                                    style="display: none"
                                </c:if>
                        >${error}</p>
                        <p class="text-bg-success p-1 w-50 rounded-3"
                                <c:if test="${empty success}">
                                    style="display: none"
                                </c:if>
                        >${success}</p>
                        <p style="color: blue; align-content: center;">
                            ${requestScope.updatesuccess}
                        </p>
                    </div>
                    <form action="${pageContext.request.contextPath}/auth/profile" method="POST" id="formaddnew" enctype="multipart/form-data">
                        <div class="p-4">
                            <h5 class="mb-0">Chỉnh sửa thông tin :</h5>
                            <div>
                                <p class="text-muted">Cập nhật ảnh đại diện.</p>
                                <div id="myfileupload">
                                    <input type="file" name="image" id="uploadfile" name="ImageUpload"
                                           onchange="readURL(this);"/>
                                </div>
                                <div id="thumbbox">
                                    <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbimage"
                                         style="display: none"/>
                                    <a class="removeimg" href="javascript:"></a>
                                </div>
                                <div id="boxchoice">
                                    <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i>
                                        Chọn ảnh</a>
                                    <p style="clear:both"></p>
                                    <input type="submit" style="display: none" name="send"
                                           class="Update btn btn-primary"
                                           value="Cập nhật">
                                    <p style="clear:both"></p>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Họ tên</label>
                                        <input name="fullName" value="${profile.fullName}" id="fullName" type="text"
                                               class="form-control">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input name="email" readonly value="${profile.email}" id="email" type="email"
                                               class="form-control">
                                        <span id="emailValidationMessage" class="text-danger"></span>
                                        <!-- Thêm phần tử span để hiển thị thông báo -->
                                    </div>
                                </div>


                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <input name="phone" value="${profile.phone}" id="phone" type="text"
                                               class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Ngày sinh</label>
                                        <input name="dob" value="${profile.dob}" id="dob" type="date"
                                               class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Địa chỉ</label>
                                        <input name="address" value="${profile.address}" id="address" type="text"
                                               class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Mô tả</label>
                                        <input name="description" value="${profile.description}" id="description"
                                               type="text" class="form-control">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Giới tính</label>
                                        <div class="my-3">
                                            <div class="form-check">
                                                <input id="credit"
                                                       name="gender" ${profile.gender == true ? "checked" : ""}
                                                       value="Nam" type="radio" class="form-check-input" checked
                                                       required>
                                                <label class="form-check-label">Nam</label>
                                            </div>
                                            <div class="form-check">
                                                <input id="debit"
                                                       name="gender" ${profile.gender == false ? "checked" : ""}
                                                       value="Nữ" type="radio" class="form-check-input" required>
                                                <label class="form-check-label">Nữ</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12">
                                    <input type="submit" id="submit" name="send" class="btn btn-primary" value="Lưu">
                                </div>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="rounded shadow mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Đổi mật khẩu :</h5>
                        <p style="color: red; align-content: center;">
                            ${requestScope.passerror}
                        </p>
                        <p style="color: blue; align-content: center;">
                            ${requestScope.passsuccess}
                        </p>
                    </div>

                    <div class="p-4">
                        <form action="/auth/changePassword" method="POST">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu cũ :</label>
                                        <input value="${oldpassword}" type="password" name="oldPassword"
                                               class="form-control" required="">
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu mới :</label>
                                        <input value="${newpassword}" id="password" type="password" name="newPassword"
                                               class="form-control" required="">
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Nhập lại mật khẩu :</label>
                                        <input value="${renewpassword}" type="password" name="confirmPassword"
                                               class="form-control" required="">
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-12 mt-2 mb-0">
                                    <button class="btn btn-primary">Thay đổi</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="layout/footer.jsp"/>
<a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i
        data-feather="arrow-up" class="icons"></i></a>

<div class="modal fade" id="watchvideomodal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-lg">
        <div class="modal-content video-modal rounded overflow-hidden">
            <div class="ratio ratio-16x9">
                <iframe src="https://www.youtube.com/embed/QIvIN8M91x4" title="YouTube video" allowfullscreen></iframe>
            </div>
        </div>
    </div>
</div>
<script src="${pageContext.request.contextPath}/static/libs/tobii/js/tobii.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    $(document).ready(function () {
        // Lưu giá trị ban đầu của trường email
        var originalEmail = $('#email').val();

        // Gắn sự kiện focusout cho trường email
        $('#email').focusout(function () {
            var editedEmail = $(this).val();

            // Kiểm tra nếu email đã được chỉnh sửa
            if (editedEmail !== originalEmail) {
                // Hiển thị thông báo không cho phép chỉnh sửa
                $('#emailValidationMessage').text('Không được phép chỉnh sửa email.');
            } else {
                // Xóa thông báo nếu email không được chỉnh sửa
                $('#emailValidationMessage').text('');
            }
        });

        $('#profileForm').submit(function (event) {
            event.preventDefault(); // Ngăn chặn gửi yêu cầu mặc định của form

            // Lấy dữ liệu từ các trường nhập liệu
            var formData = $(this).serialize();

            // Kiểm tra các trường bắt buộc không được để trống
            var image = $('#image').val();
            var fullName = $('#fullName').val();
            var phone = $('#phone').val();
            var dob = $('#dob').val();
            var address = $('#address').val();
            var description = $('#description').val();
            var gender = $('input[name="gender"]:checked').val();

            if (
                fullName.trim() === '' ||
                phone.trim() === '' ||
                dob.trim() === '' ||
                address.trim() === '' ||
                description.trim() === '' ||
                !gender
            ) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    text: 'Vui lòng điền đầy đủ thông tin.'
                });
                return; // Dừng xử lý nếu có trường bị trống
            }

            // Kiểm tra định dạng ngày sinh (DOB)
            var dobPattern = /^\d{4}-\d{2}-\d{2}$/;
            if (!dobPattern.test(dob)) {
                Swal.fire({
                    icon: 'error',
                    title: 'Lỗi',
                    html: 'Định dạng ngày sinh không hợp lệ.<br>Vui lòng nhập theo định dạng "YYYY-MM-DD".'
                });
                return; // Dừng xử lý nếu định dạng ngày sinh không hợp lệ
            }

            // Gửi yêu cầu AJAX để cập nhật thông tin
            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/auth/profile',
                data: new FormData($('#profileForm')[0]),
                processData: false,
                contentType: false,
                success: function (response) {
                    // Xử lý phản hồi từ server
                    console.log(response); // In ra response trong Console
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: 'Cập nhật thông tin thành công.'
                    }).then(function () {
                        // Tải lại trang để hiển thị thông tin đã cập nhật
                        window.location.reload();
                    });
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Lỗi',
                        text: 'Cập nhật thông tin thất bại.'
                    });
                }
            });
        });
    });

</script>
<script>
    function readURL(input, thumbimage) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#thumbimage").attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        } else {
            $("#thumbimage").attr('src', input.value);
        }
        $("#thumbimage").show();
        $('.filename').text($("#uploadfile").val());
        $(".Choicefile").hide();
        $(".removeimg").show();
    }

    $(document).ready(function () {
        $(".Choicefile").bind('click', function () {
            $("#uploadfile").click();
        });
        $(".removeimg").click(function () {
            $("#thumbimage").attr('src', '').hide();
            $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
            $(".removeimg").hide();
            $(".Choicefile").show();
            $(".filename").text("");
        });
    })
</script>
</body>

</html>
