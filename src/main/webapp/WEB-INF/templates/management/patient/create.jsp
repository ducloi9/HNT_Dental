<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<jsp:include page="../layout/head.jsp"/>
<body>
<div class="page-wrapper doctris-theme toggled">
    <jsp:include page="../layout/slide_bar.jsp"/>
    <main class="page-content bg-light">
        <jsp:include page="../layout/menu_bar.jsp"/>
        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Thêm mới bệnh nhân</h5>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="#">Quản lí</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/management/patient">Bệnh nhân</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Thêm bệnh nhân</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4">
                        <div class="card border-0 p-4 rounded shadow">
                            <div class="row align-items-center">
                                <div class="col-lg-2 col-md-4">
                                    <img src="${pageContext.request.contextPath}/static/images/user.png"
                                         class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                </div><!--end col-->

                                <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                    <h5 class="">Tải hình ảnh của bạn</h5>
                                    <p class="text-muted mb-0">Để có kết quả tốt nhất , vui lòng sử dụng một hình ảnh ít nhất 600px x 600px trong
                                        định dạng .jpg hoặc .png</p>
                                </div><!--end col-->

                                <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                    <a href="#" class="btn btn-primary">Thêm ảnh</a>
                                    <a href="#" class="btn btn-soft-primary ms-2">Xóa ảnh</a>
                                </div><!--end col-->
                            </div><!--end row-->

                            <form class="mt-4" action="${pageContext.request.contextPath}/management/patient/create" method="post" onSubmit="return validateForm()">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Họ và tên</label>
                                            <input name="full_name" id="name" type="text" class="form-control"
                                                   placeholder="Họ và tên :">
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Ngày sinh</label>
                                            <input name="dob" id="dob" type="text" class="form-control"
                                                   placeholder="DD/MM/YYYY">
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" id="email" type="email" class="form-control"
                                                   placeholder="Email :">
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" id="address" type="text" class="form-control"
                                                   placeholder="Địa chỉ">
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Điện thoại</label>
                                            <input name="phone" id="phone" type="text" class="form-control"
                                                   placeholder="Điện thoại">
                                        </div>
                                    </div><!--end col-->

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Giới tính</label>
                                            <select name="gender" class="form-select form-control">
                                                <option value="Nu">Nữ</option>
                                                <c:if test="${detail.gender == false}">
                                                    selected
                                                </c:if>
                                                <option value="Nam">Nam</option>
                                                <c:if test="${detail.gender == true}">
                                                    selected
                                                </c:if>
                                            </select>
                                        </div>
                                    </div><!--end col-->

                                    <button type="submit" class="btn btn-primary">Thêm bệnh nhân</button>
                                </div>
                            </form>
                        </div>
                    </div><!--end col-->
                </div>
            </div>
        </div>
        <jsp:include page="../layout/footer.jsp"/>
    </main>
</div>

<script src="${pageContext.request.contextPath}/static/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
    function validateForm() {
        var fullName = document.getElementById('name').value;
        var dob = document.getElementById('dob').value;
        var email = document.getElementById('email').value;
        var address = document.getElementById('address').value;
        var phone = document.getElementById('phone').value;


        if (fullName.trim() === '') {
            displayErrorMessage('Họ và tên không được bỏ trống');
            return false;
        }
        if (dob.trim() === '') {
            displayErrorMessage('Ngày sinh không được bỏ trống');
            return false;
        }
        if (!isValidDateFormat(dob)) {
            displayErrorMessage('Ngày sinh phải có định dạng YYYY-MM-DD');
            return false;
        }
        if (email.trim() === '') {
            displayErrorMessage('Email không được bỏ trống');
            return false;
        }
        if (address.trim() === '') {
            displayErrorMessage('Địa chỉ không được bỏ trống');
            return false;
        }
        if (phone.trim() === '') {
            displayErrorMessage('Điện thoại không được bỏ trống');
            return false;
        }
        if (!isValidPhoneNumber(phone)) {
            displayErrorMessage('Số điện thoại chỉ có được nhập 10 chữ số (số 0 tự thêm sẵn)');
            return false;
        }
        displaySuccessMessage('Thông tin đã được cập nhật thành công');
        return true;
    }

    function isValidDateFormat(dateString) {
        var pattern = /^\d{4}-\d{2}-\d{2}$/;
        return pattern.test(dateString);
    }
    function isValidPhoneNumber(phone) {
        var pattern = /^\d{10}$/;
        return pattern.test(phone);
    }
    function displayErrorMessage(message) {
        Swal.fire({
            icon: 'error',
            title: 'Lỗi',
            text: message,
            timer: 40000,
            showConfirmButton: false
        });
    }

    function displaySuccessMessage(message) {
        Swal.fire({
            icon: 'success',
            title: 'Thành công',
            text: message,
            timer: 40000,
            showConfirmButton: false
        });
    }
</script>
</body>
</html>
