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
                    <h3 class="sub-title mb-4">Danh sách bác sĩ</h3>
                    <p class="para-desc mx-auto text-muted">Nếu bạn,người nhà của mình cần nhận được sự trợ giúp ngay
                        lập tức, điều trị khẩn cấp hãy đặt lịch hẹn.</p>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                        <ul class="breadcrumb bg-transparent mb-0">
                            <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="#">Bác sĩ</a></li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Start -->
<section class="section">

    <div class="container">
        <div class="row align-items-center">

            <div class="col-md-12">
                <div class="search-bar p-0 d-lg-block ms-2">
                    <div class="row mb-0">
                        <div class="col-lg-8">
                            <input type="text" class="form-select form-control" name="txt"
                                   value="${search}"
                                   id="search" placeholder="Tìm kiếm bác sĩ...">
                        </div>

                        <div class="col-lg-4">
                            <button class="btn btn-primary rounded-pill" id="btn-search">Tìm kiếm</button>
                            <br><br>
                        </div>
                    </div>
                </div>
            </div>

            <c:forEach items="${doctors}" var="d">
                <div class="col-lg-6 col-md-12">
                    <div class="card team border-0 rounded shadow overflow-hidden">
                        <div class="row align-items-center">
                            <div class="col-md-6">
                                <div class="team-person position-relative overflow-hidden">
                                    <img src="${d.image}"
                                         class="img-fluid" alt="">
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card-body">
                                    <a href="#" class="title text-dark h5 d-block mb-0">${d.fullName}</a>
                                    <small class="text-muted speciality">Cập bâc: ${d.rankName}</small>
                                    <br>
                                    <small class="text-muted speciality">Thông tin: ${d.description}</small>
                                    <div class="d-flex justify-content-between align-items-center mt-2">
                                        <ul class="list-unstyled mb-0">
                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                            <li class="list-inline-item"><i class="mdi mdi-star text-warning"></i></li>
                                        </ul>
                                        <p class="text-muted mb-0">5 sao</p>
                                    </div>
                                    <div class="pt-2">
                                        <button class="btn btn-soft-primary" onclick="window.location.href = '/doctor/detail?id=${d.id}'">Chi tiết
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--end col-->
            </c:forEach>
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
    </div><!--end container-->
</section><!--end section-->
<!-- End -->

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
<script>
    $(document).ready(function () {
        $("#btn-search").click(function () {
            let search = $("#search").val();
            window.location.href = "${url}?search=" + search;
        });
    });
</script>
</body>

</html>