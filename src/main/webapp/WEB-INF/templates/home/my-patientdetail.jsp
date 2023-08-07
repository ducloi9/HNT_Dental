<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<jsp:include page="layout/header.jsp"/>
<body>
<jsp:include page="layout/menu-header-white.jsp"/>
<section class="bg-dashboard">
    <div>
        <div class="row justify-content-center">
            <jsp:include page="layout/profile-sidebar.jsp"/>
            <div class="col-xl-8 col-lg-8 col-md-7 mt-4 pt-2 mt-sm-0 pt-sm-0">
                <div class="col-lg-12 col-md-12 mt-4">
                    <div class="bg-white rounded shadow overflow-hidden">
                        <div class="p-4 border-bottom">
                            <h5 class="mb-0"><a href="${pageContext.request.contextPath}/management/mypatient/detail">Thông tin chi tiết từ bệnh nhân</a></h5>
                        </div>
                        <c:forEach items="${patient}" var="p" varStatus="status">
                            <c:if test="${status.index == 0}">
                                <div class="p-4">
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="uil uil-italic align-text-bottom text-primary h5 mb-0 me-2"></i>
                                        <h6 class="mb-0">Tên</h6>
                                        <p class="text-muted mb-0 ms-2">${p.name}</p>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="uil uil-italic align-text-bottom text-primary h5 mb-0 me-2"></i>
                                        <h6 class="mb-0">Email</h6>
                                        <p class="text-muted mb-0 ms-2">${p.email}</p>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="uil uil-book-open align-text-bottom text-primary h5 mb-0 me-2"></i>
                                        <h6 class="mb-0">Số điện thoại</h6>
                                        <p class="text-muted mb-0 ms-2">0${p.phone}</p>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="uil uil-user align-text-bottom text-primary h5 mb-0 me-2"></i>
                                        <h6 class="mb-0">Giới tính</h6>
                                        <c:if test="${p.gender == true}">
                                            <p class="text-muted mb-0 ms-2">Nam</p>
                                        </c:if>
                                        <c:if test="${p.gender == false}">
                                            <p class="text-muted mb-0 ms-2">Nữ</p>
                                        </c:if>
                                    </div>
                                    <div class="d-flex align-items-center mt-2">
                                        <i class="uil uil-envelope align-text-bottom text-primary h5 mb-0 me-2"></i>
                                        <h6 class="mb-0">Ngày sinh</h6>
                                        <p class="text-muted mb-0 ms-2">${p.dob}</p>
                                    </div>
                                </div>
                            </c:if>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 mt-4">
                    <div class="bg-white rounded shadow overflow-hidden">
                        <div class="p-6 border-bottom">
                            <h5 class="mb-50">Danh sách cuộc hẹn của bệnh nhân</h5>
                        </div>
                        <table class="table p-6 mb-100 table-center">
                            <thead>
                            <tr>
                                <th class="border-bottom p-3">Ngày Khám</th>
                                <th class="border-bottom p-3">Thời gian</th>
                                <th class="border-bottom p-3">Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${patient}" var="o">
                                <tr>
                                    <td class="p-3">${o.date}</td>
                                    <td class="p-3">${o.time}</td>
                                    <td class="p-3">${o.status}</td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <c:set var="page1" value="${currentPage}"/>
                    <div class="row text-center">
                        <div class="col-12 mt-4">
                            <div class="d-md-flex align-items-center text-center justify-content-between">
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                    <c:forEach begin="${1}" end="${totalPage}" var="i">
                                        <li class="page-item ${i==page1?'active':''}"><a class="page-link" href="${url}?page=${i}">${i}</a></li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<jsp:include page="layout/footer.jsp"/>
<script src="${pageContext.request.contextPath}/static/libs/tobii/js/tobii.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
</body>
</html>
