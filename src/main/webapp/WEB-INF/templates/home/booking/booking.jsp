<%--
    Document   : booking
    Created on : Mar 8, 2022, 10:54:32 PM
    Author     : Khuong Hung
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">

<jsp:include page="../layout/header.jsp"/>

<style>
    .error {
        color: red;
        font-weight: normal;
        display: block;
    }
</style>
<body>
<jsp:include page="../layout/menu-header-white.jsp"/>
<section class="bg-half-170 d-table w-100 bg-light">
    <div class="container">
        <div class="row mt-5 justify-content-center">
            <div class="col-12">
                <div class="section-title text-center">
                    <h3 class="sub-title mb-4">Đặt lịch</h3>
                    <p class="para-desc mx-auto text-muted">hỗ trợ ngay lập tức, điều trị khẩn cấp hoặc tư vấn đơn
                        giản.</p>

                    <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                        <ul class="breadcrumb bg-transparent mb-0 py-1">
                            <li class="breadcrumb-item"><a href="#">Bác sĩ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Đặt Lịch</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="position-relative">
    <div class="shape overflow-hidden text-white">
        <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
        </svg>
    </div>
</div>

<section class="section">
    <div class="px-lg-5">
        <div class="row">
            <div class="col-lg-7">
                <div class="card border-0 shadow rounded overflow-hidden">
                    <div class="tab-content p-4" id="pills-tabContent">
                        <c:if test="${not empty error}">
                            <p class="text-bg-danger p-3 border rounded">
                                    ${error}
                            </p>
                        </c:if>
                        <form id="bookingForm" action="${pageContext.request.contextPath}/booking" method="POST">
                            <input name="id" value="${id}" hidden>
                            <input name="typeId" value="${typeId}" hidden>
                            <div class="row">
                                <div class="p-6">
                                    <h6 class="mb-0">Thông tin bệnh nhân</h6>
                                </div>
                                <br><br>
                                <div class="col-lg-6">
                                    <div class="mb-3">
                                        <label class="form-label">Tên<span class="text-danger">*</span></label>
                                        <input class="form-control" name="name" id="name">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="mb-3">
                                        <label class="form-label">Số điện thoại<span
                                                class="text-danger">*</span></label>
                                        <input type="number" class="form-control" name="phone" id="phone"
                                               required="">
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="mb-3">
                                        <label class="form-label">Giới tính</label>
                                        <div>
                                            <select name="gender" class="form-control">
                                                <option
                                                        value="true">Nam
                                                </option>
                                                <option
                                                        value="false">Nữ
                                                </option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-lg-6">
                                    <div class="mb-3">
                                        <label class="form-label">Tuổi<span class="text-danger">*</span></label>
                                        <input type="number" id="age" class="form-control" name="age"
                                               required="">
                                    </div>
                                </div>
                                <br>
                                <div class="p-6">
                                    <h6 class="mb-0">Thông tin lịch hẹn</h6>
                                </div>
                                <br><br>
                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label"> Ngày : <span class="text-danger">*</span></label>
                                        <input required="" name="date" type="text"
                                               class="flatpickr flatpickr-input form-control"
                                               id="checkinDate">
                                    </div>
                                </div>

                                <div class="col-md-6">
                                    <div class="mb-3">
                                        <label class="form-label">Thời gian<span class="text-danger">*</span></label>
                                        <select required="" name="time"
                                                class="form-control department-name select2input">
                                            <option
                                                    value="07:00">7:00
                                            </option>
                                            <option

                                                    value="08:00">8:00
                                            </option>
                                            <option

                                                    value="09:00">9:00
                                            </option>
                                            <option

                                                    value="10:00">10:00
                                            </option>
                                            <option

                                                    value="11:00">11:00
                                            </option>
                                            <option

                                                    value="14:00">14:00
                                            </option>
                                            <option

                                                    value="15:00">15:00
                                            </option>
                                            <option

                                                    value="16:00">16:00
                                            </option>
                                            <option

                                                    value="17:00">17:00
                                            </option>
                                        </select>
                                    </div>
                                </div><!--end col-->

                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Thông tin bệnh lý<span
                                                class="text-danger">*</span></label>
                                        <textarea required="" name="decription" id="decription" rows="4"
                                                  class="form-control"></textarea>
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-12">
                                    <div class="mb-3">
                                        <label class="form-label">Phương thức thanh toán<span
                                                class="text-danger">*</span></label>
                                        <select name="payment"
                                                id="mySelect" class="form-control department-name select2input">
                                            <option

                                                    value="CASH">Thanh toán sau khi khám
                                            </option>
                                            <option

                                                    value="VNPAY">Thanh toán thông qua VNPay
                                            </option>
                                        </select>

                                    </div>
                                </div><!--end col-->
                                <button class="btn btn-primary" id="btn-booking" onclick="onClickForm()">Đặt lịch
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="col-lg-5 mt-4 mt-sm-4 pt-sm-0">
                <div class="card border-0 sidebar rounded shadow">
                    <div class="card-body">
                        <div class="row align-items-center p-2">
                            <div class="col-md-5">
                                <div class="slider slider-for">
                                    <div><img
                                            src="${services.image}"
                                            class="img-fluid rounded" alt=""></div>
                                </div>
                            </div>
                            <div class="col-md-7 mt-4 mt-sm-0 pt-2 pt-sm-0">
                                <div class="section-title ms-md-4">
                                    <h4 class="title">${services.name}</h4>

                                    <div class="row">
                                        <div class="col">
                                            <select class="form-select form-control"
                                                    onchange="redirectToService(this.value)">
                                                <c:forEach items="${types}" var="s">
                                                    <option
                                                            <c:if test="${s.idType == typeId}">
                                                                selected
                                                            </c:if>
                                                            value="${s.idType}">${s.nameType}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <br>
                                    <p class="text-muted">Giá dịch vụ: ${services.fee} </p>
                                    <ul class="list-unstyled text-warning h5 mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item me-2 h6 text-muted">(100 Đánh giá)</li>
                                    </ul>
                                    <h5 class="mt-4 py-2">Mô tả :</h5>
                                    <p class="text-muted">
                                        ${services.description}
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${sessionScope.type == 'reservation'}">
                <div class="col-lg-5">
                    <div class="bg-white rounded shadow overflow-hidden">
                        <div class="p-4 border-bottom">
                            <h6 class="mb-0">Thông tin dịch vụ</h6>
                        </div>
                        <br><br><br><br><br>
                        <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                            <c:if test="${sessionScope.service.img == 'default'}">
                                <img src="https://taimienphi.vn/tmp/cf/aut/hinh-anh-cute-dep-de-thuong-nhat-1.jpg"
                                     class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                            </c:if>
                            <c:if test="${sessionScope.service.img != 'default'}">
                                <img src="data:image/png;base64,${sessionScope.service.img}"
                                     class="rounded-circle shadow-md avatar avatar-md-md" alt="">
                            </c:if>s
                            <h5 class="mt-3 mb-1">${sessionScope.service.title}</h5>
                        </div>

                        <div class="list-unstyled p-4">
                            <div class="d-flex align-items-center mt-3">
                                <h6 class="mb-0">Phí : </h6>
                                <p class="text-muted mb-0 ms-2"><fmt:formatNumber pattern="#,###,###,###"
                                                                                  value="${sessionScope.service.fee}"/>
                                    đ</p>
                            </div>
                            <div class="d-flex align-items-center mt-3">
                                <h6 class="mb-0">Đánh giá : </h6>
                                <c:if test="${sessionScope.service.ratestar.star != 0}">
                                    <c:forEach var="i" begin="1" end="${sessionScope.service.ratestar.star}">
                                        <li class="list-inline-item mb-0 ms-2"><i class="mdi mdi-star text-warning"></i>
                                        </li>
                                    </c:forEach>
                                    <c:forEach var="i" begin="1" end="${5-sessionScope.service.ratestar.star}">
                                        <li class="list-inline-item mb-0 ms-2"><i class="mdi mdi-star"></i></li>
                                    </c:forEach>
                                </c:if>
                                <li class="list-inline-item me-2 h6 text-muted mb-0 ms-2">
                                    (${sessionScope.service.ratestar.countfeedback} Đánh giá)
                                </li>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</section>
<jsp:include page="../layout/footer.jsp"/>
<a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i
        data-feather="arrow-up" class="icons"></i></a>


<script src="${pageContext.request.contextPath}/static/libs/tobii/js/tobii.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/flatpickr.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/flatpickr.init.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/timepicker.init.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>

    function redirectToService(id) {
        window.location.href = "/booking?serviceId=" + ${id} +"&typeId=" + id;
    }

    let selectedDate = document.querySelector("#checkinDate");
    $("#checkinDate").flatpickr({
        defaultDate: selectedDate.value || new Date(),
        minDate: new Date().fp_incr(1),
        maxDate: new Date().fp_incr(14),
        dateFormat: "d/m/Y",
        locale: "vn"
    });

    $(document).ready(function () {
        const bookingForm = $('#bookingForm');
        console.log(bookingForm);
        bookingForm.validate({
            rules: {
                name: {
                    required: true,
                    maxlength: 255,
                    minlength: 2,
                },
                phone: {
                    required: true,
                    number: true,
                    maxlength: 10,
                    minlength: 10,
                },
                age: {
                    required: true,
                    number: true,
                    maxlength: 3,
                },
                email: {
                    required: true,
                    email: true
                },
                checkinDate: {
                    required: true,
                },
                decription: {
                    required: true,
                },
            },
            messages: {
                name: {
                    required: "Vui lòng nhập tên",
                    maxlength: "Tên không được vượt quá 255 ký tự",
                },
                phone: {
                    required: "Vui lòng nhập số điện thoại",
                    number: "Số điện thoại không hợp lệ",
                    maxlength: "Số điện thoại không hợp lệ",
                    minlength: "Số điện thoại không hợp lệ",
                },
                age: {
                    required: "Vui lòng nhập tuổi",
                    number: "Tuổi không hợp lệ",
                    maxlength: "Tuổi không hợp lệ",
                },
                email: {
                    required: "Vui lòng nhập email",
                    email: "Email không hợp lệ",
                },
                checkinDate: {
                    required: "Vui lòng chọn ngày",
                },
                decription: {
                    required: "Vui lòng nhập thông tin bệnh lý",
                }
            },
            submitHandler: function () {
                onClickSubmit();
            }
        });
    });

    function onClickForm() {
        $('#bookingForm').valid()
    }


    function onClickSubmit() {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn đặt lịch không?',
            text: "Bạn sẽ không thể hoàn tác lại điều này!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById("bookingForm").submit();
            }
        })
    }
</script>
</body>

</html>