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
                <h3 class="mb-0"></h3>
                <div class="rounded shadow mt-4">
                    <div class="p-4 border-bottom">
                        <h5 class="mb-0">Lịch hẹn từ bệnh nhân</h5>
                    </div>
                    <div class="p-2">
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table mb-0 table-center">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3" style="min-width: 10px;">ID</th>
                                    <th class="border-bottom p-5" style="min-width: 100px;">Tên bệnh nhân</th>
                                    <th class="border-bottom p-3" style="min-width: 110px;">Ngày khám</th>
                                    <th class="border-bottom p-3" style="min-width: 110px;">Giờ</th>
                                    <th class="border-bottom p-3" style="min-width: 70px;">Điện thoại</th>
                                    <th class="border-bottom p-3" style="min-width: 70px;">trạng thái</th>
                                </tr>
                                </thead>

                                <tbody>
                                <c:forEach items="${zpatients}" var="p">
                                    <tr>
                                        <td class="p-3">${p.id}</td>
                                        <td class="">
                                            <a href="#" class="text-dark">
                                                <div class="d-flex align-items-center">
                                                    <img src="data:image/png;base64,${a.account.img}" class="avatar avatar-md-sm rounded-circle shadow" alt="">
                                                    <span class="ms-2">${p.name}</span>
                                                </div>
                                            </a>
                                        </td>
                                        <td class="p-3">${p.date}</td>
                                        <td class="p-3">${p.time}</td>
                                        <td class="p-3">${p.phone}</td>
                                        <td class="p-3">${p.status}</td>
                                        <td class="text-center">
                                            <a href="#">
                                                <button class="btn btn-primary"
                                                        onclick="window.location.href='${pageContext.request.contextPath}/management/mypatient/detail?id=${p.id}'"
                                                >Chi tiết
                                                </button>
                                            </a>
                                        <td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <c:set var="page" value="${currentPage}"/>
                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item active"><a class="page-link">1</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link">1</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link">1</a>
                                        </li>
                                        <li class="page-item active"><a class="page-link">1</a>
                                        </li>
                                        <c:forEach begin="${1}" end="${totalPage}" var="i">
                                            <li class="page-item ${i==page?'active':''}"><a class="page-link" href="${url}?page=${i}">${i}</a></li>
                                        </c:forEach>
                                    </ul>
                                </div>
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
