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
                    <div class="col-md-5 row">
                        <div class="col-md-4">
                            <h5 class="mb-0">Bệnh nhân của tôi</h5>
                        </div>
                        <div class="col-md-7">
                            <div class="search-bar p-0 d-lg-block ms-2">
                                <div class="menu-search mb-0">
                                    <form id="searchForm" class="searchform">
                                        <div>
                                            <input type="text" class="form-control border rounded-pill" name="search"
                                                   value="${search}" id="search" placeholder="Tìm kiếm ...">
                                            <input type="submit" id="btn-search" value="Tìm kiếm">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-7">
                        <form action="doctormanage?action=filter" method="POST"
                              onSubmit="document.getElementById('submit').disabled = true;">
                            <div class="justify-content-md-end row">
                                <div class="col-md-5 row align-items-center">

                                </div>

                                <div class="col-md-5 row align-items-center">


                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="col-md-4 col-sm-1 align-items-center">

                    </div>

                    <div class="row">
                        <div class="col-12 mt-4">
                            <div class="table-responsive bg-white shadow rounded">
                                <table class="table mb-0 table-center">
                                    <thead>
                                    <tr>
                                        <th class="border-bottom p-3">ID</th>
                                        <th class="border-bottom p-3">Tên bệnh nhân</th>
                                        <th class="border-bottom p-3">Giới tính</th>
                                        <th class="border-bottom p-3">Tuổi</th>
                                        <th class="border-bottom p-3">Dịch vụ khám</th>
                                        <th class="border-bottom p-3">Loại dịch vụ</th>
                                        <th class="border-bottom p-3 ">Ngày khám</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${list}" var="o">
                                        <tr>
                                            <td class="border-bottom p-3">${o.id}</td>
                                            <td class="border-bottom p-3">${o.name}</td>
                                            <td class="border-bottom p-3">
                                                <c:if test="${o.gender == true}">
                                                    Nữ
                                                </c:if>
                                                <c:if test="${o.gender == false}">
                                                    Nam
                                                </c:if>
                                            </td>
                                            <td class="border-bottom p-3">${o.age}</td>
                                            <td class="border-bottom p-3">${o.serviceResDto.name}</td>
                                            <td class="border-bottom p-3">${o.serviceTypeDto.nameType}</td>
                                            <td class="border-bottom p-3">${o.date}</td>
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
                                    <c:forEach begin="1" end="${totalPage}" var="i">
                                        <li class="page-item ${i==page?'active':''}">
                                            <a class="page-link"
                                               href="${url}?page=${i}&search=${search}&status=${status}&gender=${gender}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <jsp:include page="../layout/footer.jsp"/>
        </div>

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
    $(document).ready(function () {
        $("#btn-search").click(function () {
            let search = $("#search").val();
            window.location.href = "${url}?search=" + search;
        });
    });

    function changeGender(date) {
        var url = "${url}";
        var search = "${search}";
        var name = "${name}";

        if (date == 'all') {
            window.location.href = url + "?search=" + search + "&status=" + name;
        } else {
            window.location.href = url + "?search=" + search + "&name=" + name + "&name=" + name;
        }
    }

    function changeStatus(status) {
        var url = "${url}";
        var search = "${search}";
        var gender = "${gender}";

        if (status == 'all') {
            window.location.href = url + "?search=" + search + "&gender=" + gender;
        } else {
            window.location.href = url + "?search=" + search + "&gender=" + gender + "&status=" + status;
        }
    }

    function onClickDelete(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa?',
            text: "Bạn sẽ không thể khôi phục lại dữ liệu sau khi xóa!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',

            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/management/doctor/delete?id=" + id;
            }
        })
    }
</script>
</body>
</html>
