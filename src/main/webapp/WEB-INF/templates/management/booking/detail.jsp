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
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="bg-white rounded shadow overflow-hidden">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Thông tin bệnh nhân</h5>
                            </div>
                            <br><br><br><br><br>
                            <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <img src="${pageContext.request.contextPath}/static/images/user.png"
                                     class="avatar" style="width: 200px; height: 200px" alt="">
                                <h5 class="mt-3 mb-1">${patientBooking.name}</h5>
                            </div>

                            <div class="list-unstyled p-4">
                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-user align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Giới tính</h6>
                                    <c:if test="${patientBooking.gender == true}">
                                        <p class="text-muted mb-0 ms-2">Nam</p>
                                    </c:if>
                                    <c:if test="${patientBooking.gender == false}">
                                        <p class="text-muted mb-0 ms-2">Nữ</p>
                                    </c:if>
                                </div>

                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-book-open align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Số điện thoại</h6>
                                    <p class="text-muted mb-0 ms-2">0${patientBooking.phone}</p>
                                </div>

                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-medical-drip align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Tuổi</h6>
                                    <p class="text-muted mb-0 ms-2">${patientBooking.age}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6 ">
                        <div class="bg-white rounded shadow overflow-hidden">
                            <div class="p-4 border-bottom">
                                <h5 class="mb-0">Thông tin dịch vụ</h5>
                            </div>
                            <br><br><br><br><br>
                            <div class="text-center margin-nagative mt-n5 position-relative pb-4 border-bottom">
                                <c:if test="${serviceBooking.image == 'default'}">
                                    <img src="${pageContext.request.contextPath}/static/images/user.png"
                                         class="rounded-md" alt="" style="width: 300px; height: 200px; ">
                                </c:if>
                                <c:if test="${serviceBooking.image != 'default'}">
                                    <img src="${serviceBooking.image}"
                                         class="rounded-md" style="width: 300px; height: 200px" alt="">
                                </c:if>
                                <h5 class="mt-3 mb-1">${serviceBooking.name}</h5>
                            </div>

                            <div class="list-unstyled p-4">
                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-book-open align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Loại dịch vụ</h6>
                                    <p class="text-muted mb-0 ms-2">${serviceBooking.type}</p>
                                </div>

                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-book-open align-text-bottom text-primary h5 mb-0 me-2"></i>
                                    <h6 class="mb-0">Gía tiền</h6>
                                    <p class="text-muted mb-0 ms-2">${serviceBooking.fee}</p>
                                </div>
                                <div class="d-flex align-items-center mt-2">
                                    <i class="uil uil-book-open align-text-bottom text-white h5 mb-0 me-2"></i>
                                    <h6 class="mb-0"></h6>
                                    <p class="text-muted mb-0 ms-2"></p>
                                </div>
                            </div>


                        </div>
                    </div>
                </div>
                <div class="card border-0 shadow overflow-hidden mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Thông tin lịch hẹn</h5>
                    </div>
                    <div class="tab-content p-4">
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Ngày hẹn</label>
                                    <p>${booking.date}</p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Thời gian</label>
                                    <p>${booking.time}</p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Trạng thái</label>
                                    <p>${booking.status}</p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Bác sĩ</label>
                                    <p>${booking.doctors.fullName}</p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Hình thức thanh toán</label>
                                    <p>${booking.paymentType}</p>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Nhân viên hỗ trợ</label>
                                    <p>${booking.employee.fullName}</p>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Trạng thái thanh toán</label>
                                    <c:if test="${booking.payment.status == false}">
                                        <p class="text-danger">Chưa thanh toán</p>
                                    </c:if>
                                    <c:if test="${booking.payment.status == true}">
                                        <p class="text-success">Đã thanh toán</p>
                                    </c:if>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label fw-bold">Thông tin</label>
                                    <p>${booking.decription}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%--Admin Marketting--%>
                <div class="card border-0 shadow overflow-hidden mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Cập nhật thông tin</h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/management/booking/update" id="bookingInforForm"
                          method="POST">
                        <input name="id" value="${param.id}" hidden>
                        <div class="tab-content p-4">
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Phí tư vấn</label>
                                    <input name="fee"
                                           id="number" type="number" class="form-control"
                                    <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4}">
                                           readonly
                                    </c:if>
                                           value="${serviceBooking.fee}">
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Bác sĩ</label>
                                    <select name="doctor" class="form-select"
                                            <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4}">
                                                disabled
                                            </c:if>
                                    >
                                        <option class="form-control" value="">Chọn bác sĩ</option>
                                        <c:forEach items="${doctors}" var="doctor">
                                            <option
                                                    <c:if test="${doctor.id == booking.doctors.id}">
                                                        selected
                                                    </c:if>

                                                    class="form-control"
                                                    value="${doctor.id}">${doctor.fullName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Nhân viên hỗ trợ</label>
                                    <select name="staff" class="form-select"
                                            <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4}">
                                                disabled
                                            </c:if>

                                    >
                                        <option class="form-control" value="">Chọn nhân viên</option>
                                        <c:forEach items="${employee}" var="e">
                                            <option
                                                    <c:if test="${e.id == booking.employee.id}">
                                                        selected
                                                    </c:if>
                                                    class="form-control" value="${e.account.id}">${e.fullName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="mb-3">
                                    <label class="form-label">Trạng thái lịch hẹn</label>
                                    <select name="status" id="status" class="form-select"
                                            aria-label="Default select example"
                                            <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4}">
                                                disabled
                                            </c:if>
                                    >
                                        <option
                                                <c:if test="${booking.status == 'PENDING'}">
                                                    selected
                                                </c:if>
                                                value="PENDING">Pending
                                        </option>
                                        <option
                                                <c:if test="${booking.status == 'CANCEL'}">
                                                    selected
                                                </c:if>
                                                value="CANCEL">Cancel
                                        </option>
                                        <option
                                                <c:if test="${booking.status == 'CONFIRM'}">
                                                    selected
                                                </c:if>
                                                value="CONFIRM">Confirm
                                        </option>
                                        <c:if test="${sessionScope.account.role == 1}">
                                            <option
                                                    <c:if test="${booking.status == 'ASSIGNED'}">
                                                        selected
                                                    </c:if>
                                                    value="ASSIGNED">Assigned
                                            </option>
                                            <option
                                                    <c:if test="${booking.status == 'REJECT'}">
                                                        selected
                                                    </c:if>
                                                    value="REJECT">Reject
                                            </option>
                                            <option
                                                    <c:if test="${booking.status == 'DONE'}">
                                                        selected
                                                    </c:if>
                                                    value="DONE">DONE
                                            </option>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="row">
                                    <div class="mb-3 col-lg-6">
                                        <label class="form-label">Loại thanh toán</label>
                                        <select name="payment_type" class="form-select"
                                                <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4}">
                                                    disabled
                                                </c:if>
                                                aria-label="Default select example">
                                            <option
                                                    <c:if test="${booking.paymentType == 'VNPAY'}">
                                                        selected
                                                    </c:if>
                                                    value="VNPAY">VNPay
                                            </option>
                                            <option
                                                    <c:if test="${booking.paymentType == 'CASH'}">
                                                        selected
                                                    </c:if>
                                                    value="CASH">Thanh toán tại phòng khám
                                            </option>
                                        </select>
                                    </div>

                                    <div class="mb-3 col-lg-6">
                                        <label class="form-label">Trạng thái thanh toán</label>
                                        <select name="payment_status" class="form-select"
                                                <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4}">
                                                    disabled
                                                </c:if>
                                                aria-label="Default select example">
                                            <option
                                                    <c:if test="${booking.payment.status == true}">
                                                        selected
                                                    </c:if>
                                                    value="1">Đã thanh toán
                                            </option>
                                            <option
                                                    <c:if test="${booking.payment.status == false}">
                                                        selected
                                                    </c:if>
                                                    value="0">Chưa thanh toán
                                            </option>
                                        </select>
                                    </div>
                                </div>
                                <c:if test="${sessionScope.account.role != 2 && sessionScope.account.role != 4}">
                                    <div class="tab-content p-0">
                                        <button type="submit" class="btn btn-primary">Cập nhật</button>
                                    </div>
                                </c:if>
                                <c:if test="${sessionScope.account.role == 2 || sessionScope.account.role == 4 && booking.status == 'DONE'}">
                                    <div class="tab-content p-0">
                                        <button type="button" class="btn btn-primary" onclick="setStatusSuceess()">Hoàn
                                            thành lịch hẹn
                                        </button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </form>
                </div>

                <%--Staff & doctor--%>
                <div class="card border-0 shadow overflow-hidden mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Kết quả khám</h5>
                    </div>
                    <form action="${pageContext.request.contextPath}/management/booking/result"
                          method="POST">
                        <div class="row tab-content p-4">
                            <div class="col-lg-12">
                                <input hidden="" name="id" value="${param.id}">
                                <div class="mb-3">
                                    <label class="form-label">Kết quả khám bao gồm kết luần của bác sĩ + đơn thuốc +
                                        Phim XQ (nếu có)</label>
                                    <textarea name="result" class="form-control attachments"
                                              rows="3">${bookingResult.result}</textarea>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="tab-content p-0">
                                    <button type="submit" class="btn btn-primary">Cập nhật</button>
                                </div>
                            </div>
                        </div>
                    </form>
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
    ClassicEditor.create(document.querySelector(".history"), {
        toolbar: {
            items: [
                "heading",
                "|",
                "bold",
                "italic",
                "link",
                "bulletedList",
                "numberedList",
                "|",
                "indent",
                "outdent",
                "|",
                "imageUpload",
                "blockQuote",
                "mediaEmbed",
                "undo",
                "redo",
            ],
        },
        image: {
            toolbar: ["imageTextAlternative", "imageStyle:full", "imageStyle:side"],
        },
    }).then((editor) => {
        window.editor = editor;
    })

    ClassicEditor.create(document.querySelector(".symptoms"), {
        toolbar: {
            items: [
                "heading",
                "|",
                "bold",
                "italic",
                "link",
                "bulletedList",
                "numberedList",
                "|",
                "indent",
                "outdent",
                "|",
                "imageUpload",
                "blockQuote",
                "mediaEmbed",
                "undo",
                "redo",
            ],
        },
        image: {
            toolbar: ["imageTextAlternative", "imageStyle:full", "imageStyle:side"],
        },
    }).then((editor) => {
        window.editor = editor;
    })


    ClassicEditor.create(document.querySelector(".attachments"), {
        toolbar: {
            items: [
                "heading",
                "|",
                "bold",
                "italic",
                "link",
                "bulletedList",
                "numberedList",
                "|",
                "indent",
                "outdent",
                "|",
                "imageUpload",
                "blockQuote",
                "mediaEmbed",
                "undo",
                "redo",
            ],
        },
        image: {
            toolbar: ["imageTextAlternative", "imageStyle:full", "imageStyle:side"],
        },
    }).then((editor) => {
        window.editor = editor;
    })
    ClassicEditor.create(document.querySelector(".diagnosis"), {
        toolbar: {
            items: [
                "heading",
                "|",
                "bold",
                "italic",
                "link",
                "bulletedList",
                "numberedList",
                "|",
                "indent",
                "outdent",
                "|",
                "imageUpload",
                "blockQuote",
                "mediaEmbed",
                "undo",
                "redo",
            ],
        },
        image: {
            toolbar: ["imageTextAlternative", "imageStyle:full", "imageStyle:side"],
        },
    }).then((editor) => {
        window.editor = editor;
    })
    ClassicEditor.create(document.querySelector(".prescription"), {
        toolbar: {
            items: [
                "heading",
                "|",
                "bold",
                "italic",
                "link",
                "bulletedList",
                "numberedList",
                "|",
                "indent",
                "outdent",
                "|",
                "imageUpload",
                "blockQuote",
                "mediaEmbed",
                "undo",
                "redo",
            ],
        },
        image: {
            toolbar: ["imageTextAlternative", "imageStyle:full", "imageStyle:side"],
        },
    }).then((editor) => {
        window.editor = editor;
    })
</script>

<script>
    function setStatusSuceess() {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn hoàn thành lịch hẹn này?',
            showDenyButton: true,
            confirmButtonText: `Hoàn thành`,
            denyButtonText: `Không`,
        }).then((result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/management/booking/success?id=${param.id}";
            } else if (result.isDenied) {
                Swal.fire('Lịch hẹn chưa được hoàn thành', '', 'info')
            }
        })
    }
</script>
</body>
</html>
