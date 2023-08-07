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

<jsp:include page="layout/header.jsp"/>

<body>

<jsp:include page="layout/menu-header-white.jsp"/>

<!-- Start Hero -->
<section class="bg-half-170 d-table w-100" style="background: url('assets/images/bg/banner.jpg');">
    <div class="bg-overlay bg-overlay-dark"></div>
    <div class="container">
        <div class="row mt-5 justify-content-center">
            <div class="col-12">
                <div class="section-title text-center">
                    <h3 class="sub-title mb-4 text-white title-dark">Liên hệ</h3>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-3">
                        <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
                            <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Liên hệ</li>
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
    </div>
</section>
<div class="position-relative">
    <div class="shape overflow-hidden text-white">
        <svg viewBox="0 0 2880 48" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M0 48H1437.5H2880V0H2160C1442.5 52 720 0 720 0H0V48Z" fill="currentColor"></path>
        </svg>
    </div>
</div>

<section class="mt-100 mt-60">
    <div class="container">
        <div class="row">
            <div class="col-lg-4 col-md-6">
                <div class="card features feature-primary text-center border-0">
                    <div class="icon text-center rounded-md mx-auto">
                        <i class="uil uil-phone h3 mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <h5>Đường dây nóng</h5>
                        <a href="tel:888195313" class="link">0888195313</a>
                    </div>
                </div>
            </div><!--end col-->

            <div class="col-lg-4 col-md-6 mt-4 mt-sm-0 pt-2 pt-sm-0">
                <div class="card features feature-primary text-center border-0">
                    <div class="icon text-center rounded-md mx-auto">
                        <i class="uil uil-envelope h3 mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <h5>Email</h5>
                        <a href="mailto:support@doctriscare.ml" class="link">hntdentail@gmail.com</a>
                    </div>
                </div>
            </div><!--end col-->

            <div class="col-lg-4 col-md-6 mt-4 mt-lg-0 pt-2 pt-lg-0">
                <div class="card features feature-primary text-center border-0">
                    <div class="icon text-center rounded-md mx-auto">
                        <i class="ri-user-2-line text-primary h5 fw-normal mb-0"></i>
                    </div>
                    <div class="card-body p-0 mt-3">
                        <h5>Địa chỉ</h5>
                        <a href="https://goo.gl/maps/G8Dyw5XUAiFcHrss5" class="link"> Me Linh , Ha Noi</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-100 mt-60">
        <div class="row align-items-center">
            <div class="col-lg-5 col-md-6">
                <div class="me-lg-5">
                    <img src="assets/images/about/about.jpg" class="img-fluid" alt="">
                </div>
            </div>

        </div>
    </div>

    <div class="container-fluid mt-100 mt-60">
        <div class="row">
            <div class="col-12 p-0">
                <div class="card map border-0">
                    <div class="card-body p-0">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.879040483311!2d105.80901941158781!3d20.997485288769774!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac90cd5ade37%3A0x22ac3f321d6ec9bf!2zUGjDsm5nIEtow6FtIE5oYSBLaG9hIEjDoCBO4buZaSBTbWlsZQ!5e0!3m2!1sen!2s!4v1685624894282!5m2!1sen!2s" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
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
