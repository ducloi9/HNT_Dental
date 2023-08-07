<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 5/30/2023
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
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
                    <div class="col-md-5 row">
                        <div class="col-md-4">
                            <h5 class="mb-0"> Quản lý lịch hẹn</h5>
                        </div>
                        <div class="col-md-8">
                            <div class="search-bar p-0 d-lg-block ms-2">
                                <div class="row mb-0">
                                    <div class="col-lg-8">
                                        <input type="text" class="form-control border rounded-pill" name="txt"
                                               value="${search}"
                                               id="search" placeholder="Tìm kiếm bệnh nhân...">
                                    </div>
                                    <div class="col-lg-4">
                                        <button class="btn btn-primary rounded-pill" id="btn-search">Tìm kiếm</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <form action="doctormanage?action=filter" method="POST"
                              onSubmit="document.getElementById('submit').disabled = true;">
                            <div class="justify-content-md-end row">
                                <div class="col-md-5 row align-items-center">
                                    <div class="col-md-3">
                                        <label class="form-label">Dịch vu</label>
                                    </div>
                                    <div class="col-md-9">
                                        <select class="form-select" onchange="changeService(this.value)">
                                            <option value="all">Tất cả</option>
                                            <c:forEach items="${services}" var="s">
                                                <option
                                                        <c:if test="${s.service.id == service}">
                                                            selected
                                                        </c:if>
                                                        value="${s.service.id}">${s.service.name}</option>
                                            </c:forEach>
                                        </select>

                                    </div>
                                </div>
                                <div class="col-md-5 row align-items-center">
                                    <div class="col-md-4">
                                        <label class="form-label">Trạng thái</label>
                                    </div>
                                    <div class="col-md-8">
                                        <select class="form-select" onchange="changeStatus(this.value)">
                                            <option value="all">Tất cả</option>
                                            <c:forEach items="${statuses}" var="st">
                                                <option
                                                        <c:if test="${st.id == status}">
                                                            selected
                                                        </c:if>
                                                        value="${st.id}">${st.name}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 mt-4">
                        <div class="table-responsive bg-white shadow rounded">
                            <table class="table mb-0 table-center">
                                <thead>
                                <tr>
                                    <th class="border-bottom p-3">ID</th>
                                    <th class="border-bottom p-3">Tên bệnh nhân</th>
                                    <th class="border-bottom p-3">Dịch vụ</th>
                                    <th class="border-bottom p-3">Ngày khám bệnh</th>
                                    <th class="border-bottom p-3">Thời gian</th>
                                    <th class="border-bottom p-3">Trạng thái</th>
                                    <th class="border-bottom p-3 text-center">Tác vụ</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${bookings}" var="b">
                                    <tr>
                                        <td>${b.id}</td>
                                        <td>${b.name}</td>
                                        <td>${b.service.name}</td>
                                        <td>${b.date}</td>
                                        <td>${b.time}</td>

                                        <td>
                                                ${b.status}
                                        </td>
                                        <td class="text-center">
                                            <button class="btn btn-primary"
                                                    onclick="window.location.href='${pageContext.request.contextPath}/management/booking/detail?id=${b.id}'"
                                            >Chi tiết
                                            </button>
                                        <td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
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
                                                                                    href="${url}?page=${i}&search=${search}">${i}</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../layout/footer.jsp"/>
    </main>
</div>
<!--View Appoiment-->
<script src="${pageContext.request.contextPath}/static/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    $(document).ready(function () {
        $("#btn-search").click(function () {
            let search = $("#search").val();
            window.location.href = "${url}?search=" + search;
        });
    });

    function changeStatus(id) {
        if(id == 'all'){
            window.location.href = "${url}?search=${search}&service=${service}";
        }else{
            window.location.href = "${url}?search=${search}&service=${service}&status=" + id;
        }
    }

    function changeService(id) {
        if(id == 'all'){
            window.location.href = "${url}?search=${search}&status=${status}";
        }else{
            window.location.href = "${url}?search=${search}&status=${status}&service=" + id;
        }
    }
</script>
</body>
</html>
