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
                        <h5 class="mb-0">Lịch sử lịch hẹn</h5>
                    </div>
                    <div class="p-2">
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table mb-0 table-center">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">ID</th>
                                    <th class="border-bottom p-5">Tên dịch vụ</th>
                                    <th class="border-bottom p-3">Loại dịch vụ</th>
                                    <th class="border-bottom p-3">Ngày khám</th>
                                    <th class="border-bottom p-3">Giờ khám</th>
                                    <th class="border-bottom p-3">Trạng thái</th>
                                    <th class="border-bottom p-5">Tác vụ</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${service}" var="o">
                                    <tr>
                                        <td class="p-3">${o.id}</td>
                                        <td class="p-3">${o.serviceResDto.name}</td>
                                        <td class="p-3">${o.serviceTypeDto.nameType}</td>
                                        <td class="p-3">${o.date}</td>
                                        <td class="p-3">${o.time}</td>
                                        <td class="p-3">${o.status}</td>
                                        <td class="p-3 text-center">
                                            <a href="#">
                                                <button class="btn btn-primary"
                                                        onclick="window.location.href='${pageContext.request.contextPath}/auth/detail-appointment-history?id=${o.id}'">
                                                    Chi tiết
                                                </button>
                                            </a>
                                        </td>
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
                                        <c:forEach begin="${1}" end="${totalPage}" var="i">
                                            <li class="page-item ${i==page?'active':''}"><a class="page-link"
                                                                                            href="${url}?page=${i}">${i}</a>
                                            </li>
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

</body>

</html>
