<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 6/1/2023
  Time: 7:49 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<jsp:include page="../layout/header.jsp"/>

<body>

<jsp:include page="../layout/menu-header-white.jsp"/>

<section class="bg-half-150 bg-light d-table w-100">
    <div class="container">
        <div class="row mt-5 justify-content-center">
            <div class="col-12">
                <div class="section-title text-center">
                    <h3 class="sub-title mb-4">Danh sách dịch vụ</h3>
                    <p class="para-desc mx-auto text-muted">Nếu bạn,người nhà của mình cần nhận được sự trợ giúp ngay
                        lập tức, điều trị khẩn cấp hãy đặt lịch hẹn.</p>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                        <ul class="breadcrumb bg-transparent mb-0">
                            <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="#">Dịch vụ</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="section">
    <div class="container">

        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <form action="${url}" method="get">
                        <div class="input-group">
                            <input type="text" class="form-select form-control" name="search" value="${search}" id="search" placeholder="Tìm kiếm dịch vụ...">
                        </div>
                    </form>
                </div>
                <div class="col-lg-3">
                    <form action="${url}" method="get">
                        <div class="input-group">
                            <select class="form-select form-control" name="typeId" id="typeId">
                                <option value="all">Tất cả</option>
                                <c:forEach items="${types}" var="type">
                                    <option value="${type.idType}" ${typeId == type.idType ? 'selected' : ''}>${type.nameType}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
                <div class="col-lg-3">
                    <!-- Use the same form for search and filter -->
                    <div class="input-group">
                        <button type="submit" class="btn btn-primary rounded-pill mt-2" id="btn-search">Tìm kiếm & Lọc</button>
                    </div>
                </div>
            </div>
            <br>
        </div>




        <div class="row">
            <div class="col-lg-12 col-lg-12 row align-items-center">

                <c:forEach items="${services}" var="s">
                    <div class="col-xl-3 col-lg-3 col-md-6 mt-2 pt-2">
                        <div class="card team border-0 rounded shadow overflow-hidden">
                            <div class="team-person position-relative overflow-hidden">
                                <img src="${s.image}"
                                     style="display: block;margin-left: auto;margin-right: auto; width: 400px; height: 200px"
                                     class="img-fluid"
                                     alt="">
                            </div>
                            <div class="card-body" style="height: 250px">
                                <a href="#" class="text-dark d-block mb-0">${s.name}</a>
                                <small class="text-muted speciality">Loại dịch vụ : ${s.type}</small>
                                <br>
                                <small class="text-muted speciality">Gía tiền: ${s.fee}</small>
                                <div class="d-flex justify-content-between align-items-center mt-2">
                                    <ul class="list-unstyled mb-0">
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                        <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                    </ul>
                                </div>
                                <div class="pt-2">
                                    <button class="btn btn-soft-primary"
                                            onclick="window.location.href = '/service/detail?id=${s.id}'">Chi tiết
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
        <c:set var="page" value="${currentPage}"/>
        <div class="row text-center">
            <div class="col-12 mt-4">
                <div class="d-md-flex align-items-center text-center justify-content-between">
                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                        <c:forEach begin="1" end="${totalPage}" var="i">
                            <li class="page-item ${i == page ? 'active' : ''}">
                                <a class="page-link" href="${url}?page=${i}&search=${search}&typeId=${typeId}">${i}</a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../layout/footer.jsp"/>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
    /* Custom CSS to adjust the width of the label */
    .search-label {
        width: 100px; /* You can adjust the width as needed */
    }
</style>


<script>
    $(document).ready(function () {
        let selectedTypeId = "${typeId}";

        // Handle the search and filter form submission
        $("#btn-search").click(function (event) {
            // Prevent default form submission
            event.preventDefault();

            // Get the search and filter values
            let search = $("#search").val();
            let typeId = $("#typeId").val();

            // Determine the URL parameters based on the input values
            let urlParams = "";
            if (search.trim() !== "" && typeId === "all") {
                // Search only (typeId is empty)
                urlParams = "search=" + encodeURIComponent(search);
            } else if (search.trim() === "" && typeId !== "all") {
                // Filter only (search is empty)
                urlParams = "typeId=" + encodeURIComponent(typeId);
            } else if (search.trim() !== "" && typeId !== "all") {
                // Search and Filter both
                urlParams = "search=" + encodeURIComponent(search) + "&typeId=" + encodeURIComponent(typeId);
            }

            // Combine the base URL and URL parameters
            let url = "${url}" + "?" + urlParams;

            // Redirect to the new URL with appropriate search and filter criteria
            window.location.href = url;
        });
    });
    $(document).ready(function () {
        let selectedTypeId = "${typeId}";

        // Handle the search and filter form submission
        $("#btn-search").click(function (event) {
            // Prevent default form submission
            event.preventDefault();

            // Get the search and filter values
            let search = $("#search").val();
            let typeId = $("#typeId").val();

            // Determine the URL parameters based on the input values
            let urlParams = "";
            if (search.trim() !== "" && typeId === "all") {
                // Search only (typeId is empty)
                urlParams = "search=" + encodeURIComponent(search);
            } else if (search.trim() === "" && typeId !== "all") {
                // Filter only (search is empty)
                urlParams = "typeId=" + encodeURIComponent(typeId);
            } else if (search.trim() !== "" && typeId !== "all") {
                // Search and Filter both
                urlParams = "search=" + encodeURIComponent(search) + "&typeId=" + encodeURIComponent(typeId);
            }

            // Combine the base URL and URL parameters
            let url = "${url}" + "?" + urlParams;

            // Redirect to the new URL with appropriate search and filter criteria
            window.location.href = url;
        });
    });

</script>




</body>

</html>