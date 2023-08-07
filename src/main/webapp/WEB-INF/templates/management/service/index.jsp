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
                    <div class="row">
                        <div class="col-md-8 col-sm-12 row">
                            <div class="col-md-4">
                                <h5 class="mb-0">Quản lí dịch vụ</h5>
                            </div>
                            <div class="col-md-8">
                                <div class="search-bar p-0 d-lg-block ms-2">
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4 col-sm-12">
                            <a href="${pageContext.request.contextPath}/management/service/create">
                                <button class="btn btn-primary">Thêm dịch vụ</button>
                            </a>
                            <a href="${pageContext.request.contextPath}/management/type">
                                <button class="btn btn-primary">Loại dịch vụ</button>
                            </a>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <br><br>
                        <form action="doctormanage?action=filter" method="POST"
                              onSubmit="document.getElementById('submit').disabled = true;">
                            <div class="justify-content-md-end row">
                                <div class="col-md-5 row align-items-center">
                                    <div class="col-md-3">
                                        <label class="form-label">Gói dịch vụ</label>
                                    </div>
                                    <div class="col-md-9">
                                        <select name="gender" class="form-select">
                                            <option value="0">Tất cả</option>
                                            <c:forEach items="${getALlType}" var="g">
                                                <option value="${g.idType}">${g.nameType}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-5 row align-items-center">
                                    <div class="col-md-4">
                                        <label class="form-label">Trạng thái</label>
                                    </div>
                                    <div class="col-md-8">
                                        <select name="speciality" class="form-select">
                                            <option <c:if test="${speciality == 'all'}"> selected </c:if> value="all">
                                                Tất cả
                                            </option>
                                            <option <c:if test="${speciality == 'all'}"> selected </c:if> value="all">
                                                Active
                                            </option>
                                            <option <c:if test="${speciality == 'all'}"> selected </c:if> value="all">
                                                Deactive
                                            </option>

                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-1 md-0">
                                    <button type="submit" class="btn btn-primary">Lọc</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>


                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive bg-white shadow rounded">
                            <div class="row">
                                <div class="col-12 mt-4">
                                    <div class="table-responsive bg-white shadow rounded">
                                        <table class="table mb-0 table-center">
                                            <thead>
                                            <tr>
                                                <th class="border-bottom p-3 text-center">ID</th>
                                                <th class="border-bottom p-3 ">Tên dịch vụ</th>
                                                <th class="border-bottom p-3 text-center">Gói dich vụ</th>
                                                <th class="border-bottom p-3 text-center">Phí</th>
                                                <th class="border-bottom p-3 text-center">Trạng thái</th>
                                                <th class="border-bottom p-3 text-center">Tác vụ</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <c:forEach items="${serviceManagementDtos}" var="s">
                                                <tr>
                                                    <td class="border-bottom p-3 text-center">${s.id}</td>
                                                    <td class="border-bottom p-3 ">${s.name}</td>
                                                    <td class="border-bottom p-3 text-center">${s.type}</td>
                                                    <td class="border-bottom p-3 text-center">${s.fee}</td>
                                                    <c:if test="${s.status == 1}">
                                                        <td class="border-bottom p-3 text-center">Active</td>
                                                    </c:if>
                                                    <c:if test="${s.status == 0}">
                                                        <td class="border-bottom p-3 text-center">Deactive</td>
                                                    </c:if>
                                                    <td class="text-center">
                                                        <a href="#">
                                                            <button class="btn btn-primary"
                                                                    onclick="window.location.href='${pageContext.request.contextPath}/management/service/detail?id=${s.id}'"
                                                            >Chi tiết
                                                            </button>
                                                        </a>
                                                    <td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <c:set var="page" value="${currentPage}"/>
                <div class="row text-center">
                    <div class="col-12 mt-4">
                        <div class="d-md-flex align-items-center text-center justify-content-between">
                            <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                <c:forEach begin="${1}" end="${totalPage}" var="i">
                                    <li class="page-item ${i==page?"active":""}"><a class="page-link"
                                                                                    href="/management/service?page=${i}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp"/>
    </main>

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

