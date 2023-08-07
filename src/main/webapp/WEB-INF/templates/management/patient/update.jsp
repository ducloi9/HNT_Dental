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
                    <h5 class="mb-0">Bệnh Nhân </h5>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="#">Quản lí</a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/management/patient">Bệnh nhân</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Thêm bệnh nhân</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4">
                        <p style="color: red; font-weight: bold; padding: 10px">${error}</p>
                        <div class="card border-0 p-4 rounded shadow">
                            <div class="row align-items-center">
                                <div class="col-lg-2 col-md-4">
                                    <img src="${pageContext.request.contextPath}/static/images/user.png"
                                         class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                </div>
                                <div class="col-lg-5 col-md-8 text-center text-md-start mt-4 mt-sm-0">
                                    <h5 class="">Tải lên hình ảnh của bạn </h5>
                                    <p class="text-muted mb-0"> Để có kết quả tốt nhất , vui lòng sử dụng một hình ảnh ít nhất 600px x 600px trong
                                        định dạng .jpg hoặc .png</p>
                                </div>

                                <div class="col-lg-5 col-md-12 text-lg-end text-center mt-4 mt-lg-0">
                                    <a href="#" class="btn btn-primary">Thêm ảnh</a>
                                    <a href="#" class="btn btn-soft-primary ms-2">Xóa ảnh</a>
                                </div>
                            </div>

                            <form class="mt-4" action="${pageContext.request.contextPath}/management/patient/update"
                                  method="post">
                                <input value="${detail.id}" name="id" type="hidden">

                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Họ và tên</label>
                                            <input name="full_name" id="name" type="" class="form-control"
                                                   value="${detail.fullName}"
                                            >
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Ngày sinh</label>
                                            <input name="dob" id="name2" type="text" class="form-control"
                                                   value="${detail.dob}"
                                                   placeholder="YYYY-MM-DD">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" id="address" type="text" class="form-control"
                                                   placeholder="Địa chỉ" value="${detail.address}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Điện thoại</label>
                                            <input name="phone" id="phone" type="text" class="form-control"
                                                   placeholder="Điện thoại" value="${detail.phone}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" id="email" type="email" class="form-control"
                                                   value="${detail.account.email}"
                                                   placeholder="Email :">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Giới tính</label>
                                            <select name="gender" id="gender" class="form-select form-control">
                                                <option value="nu"
                                                <c:if test="${detail.gender == false}">
                                                    selected
                                                </c:if>
                                                >Nữ</option>
                                                <option value="nam"
                                                <c:if test="${detail.gender == true}">
                                                    selected
                                                </c:if>
                                                >Nam</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Trạng thái</label>
                                            <select name="status" class="form-select form-control">
                                                <option value="deactive"
                                                <c:if test="${detail.status == false}">
                                                    selected
                                                </c:if>
                                                >deactive</option>
                                                <option value="active"
                                                <c:if test="${detail.status == true}">
                                                    selected
                                               </c:if>
                                                >active</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label class="form-label">Mô tả</label>
                                            <textarea name="description" id="comments" rows="3" class="form-control"
                                                      placeholder="Bio :">${detail.description}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary">Lưu</button>
                            </form>
                        </div>
                    </div>
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
</body>
</html>