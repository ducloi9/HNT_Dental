<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<jsp:include page="../layout/header.jsp"/>
<body>
<jsp:include page="../layout/menu-header-white.jsp"/>
<section class="section">
    <div class="container-sm">
        <div class="row">
            <div class="col-lg-8 col-lg-7 card border-0 sidebar rounded shadow">
                <div class="row align-items-center p-2">
                    <div class="col-md-5">
                        <div class="slider slider-for">
                            <div><img
                                    src="${doctorDetailDto.image}"
                                    class="img-fluid rounded" alt=""></div>
                        </div>
                    </div>

                    <div class="col-md-7 mt-4 mt-sm-0 pt-2 pt-sm-0">
                        <div class="section-title ms-md-4">
                            <h4 class="title">${doctorDetailDto.fullName}</h4>
                            <p class="text-muted">${doctorDetailDto.position}</p>
                            <ul class="list-unstyled text-warning h5 mb-0">
                                <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                <li class="list-inline-item me-2 h6 text-muted">(100 Đánh giá)</li>
                            </ul>

                            <h5 class="mt-4 py-2">Mô tả :</h5>
                            <p class="text-muted">
                                ${doctorDetailDto.description}
                            </p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mt-4 mt-sm-4 pt-sm-0">
                <div class="card border-0 sidebar rounded shadow">
                    <div class="card-body">
                        <div class="widget mb-4 pb-2">
                            <h5 class="widget-title">Dịch vụ của bác sĩ</h5>
                            <div class="mt-4">

                                <c:forEach items="${services}" var="s">
                                    <div class="clearfix post-recent">
                                        <div class="post-recent-thumb float-start"><a
                                                href="${pageContext.request.contextPath}/service/detail?id=${s.id}">
                                            <img
                                                    alt="img"
                                                    src="${s.image}"
                                                    class="img-fluid rounded"></a>
                                        </div>
                                        <div class="post-recent-content float-start">
                                            <a href="${pageContext.request.contextPath}/service/detail?id=${s.id}">${s.name}</a>
                                            <span class="text-muted mt-2"><b>Loại:</b> ${s.type}</span>
                                            <br>
                                            <span class="text-muted mt-2"><b>Giá tiền:</b> ${s.fee}</span></div>
                                    </div>
                                </c:forEach>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container mt-4">
            <div class="row">
                <div class="col-12">
                    <h5 class="card-title mt-4 mb-0">Đánh giá :</h5>
                    <ul class="media-list list-unstyled mb-0">

                        <c:forEach items="${feedbacks}" var="f">
                            <li class="mt-4">
                                <div class="d-flex justify-content-between">
                                    <div class="d-flex align-items-center">
                                        <a class="pe-3" href="#">
                                            <img src="${f.image}"
                                                 class="img-fluid avatar avatar-md-sm rounded-circle shadow" alt="img">
                                        </a>
                                        <div class="commentor-detail">
                                            <h6 class="mb-0"><a href="javascript:void(0)"
                                                                class="text-dark media-heading">${f.fullName}</a></h6>
                                            <small class="text-muted">${f.createdAt}</small>
                                            <ul class="list-unstyled text-warning h5 mb-0">
                                                <c:forEach var="i" begin="1" end="${f.star}">
                                                    <li class="list-inline-item"><i class="mdi mdi-star"></i></li>
                                                </c:forEach>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-3">
                                    <p class="text-muted font-italic p-3 bg-light rounded">${f.description}</p>
                                </div>
                            </li>
                        </c:forEach>

                    </ul>

                    <div class="row text-center">
                        <!-- PAGINATION START -->
                        <div class="col-12 mt-4">
                            <div class="d-md-flex align-items-center text-center justify-content-between">
                                <span class="text-muted me-3">Hiển thị 1 - 10 trên 50</span>
                                <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">

                                </ul>
                            </div>
                        </div><!--end col-->
                        <!-- PAGINATION END -->
                    </div><!--end row-->
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