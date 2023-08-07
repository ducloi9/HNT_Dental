<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>HNT Dental - Forgot Password</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="${pageContext.request.contextPath}/static/css/bootstrap.min.css" class="theme-opt" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/css/icons.min.css" rel="stylesheet" type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/libs/remixicon/fonts/remixicon.css" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/libs/@iconscout/unicons/css/line.css" type="text/css"
          rel="stylesheet"/>
    <link href="${pageContext.request.contextPath}/static/css/style.min.css" class="theme-opt" rel="stylesheet"
          type="text/css"/>
    <link href="${pageContext.request.contextPath}/static/css/styles.css" rel="stylesheet" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/preloader.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.preloader.min.js"></script>
</head>

<body>

<div class="back-to-home rounded d-none d-sm-block">
    <a href="/home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
</div>
<div class="col-8 align-self-center preloader-custom"></div>
<section class="bg-home d-flex bg-light align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-8">
                <div class="card login-page shadow mt-4 rounded border-0">
                    <div class="card-body">
                        <h4 class="text-center"> Khôi phục mật khẩu </h4>
                        <form class="forgot mt-4" id="forgot">
                            <p id="content" style="color: red; align-content: center;"></p>
                            <div class="row">
                                <div class="col-lg-12">
                                    <p class="text-muted">Hãy điền địa chỉ email của bạn. Bạn sẽ nhận được một liên kết đến
                                        tạo mật khẩu mới qua email.</p>
                                    <div class="mb-3">
                                        <label class="form-label">Địa chỉ Email <span
                                                class="text-danger">*</span></label>
                                        <input type="text" class="form-control" placeholder="Nhập địa chỉ Email của bạn"
                                               name="email" required="">
                                    </div>
                                </div>
                                <div class="col-lg-12">
                                    <div class="d-grid">
                                        <button class="btn btn-primary">Gửi</button>
                                    </div>
                                </div>
                                <div class="mx-auto">
                                    <p class="mb-0 mt-3"><small class="text-dark me-2">Nhớ mật khẩu ?</small>
                                        <a href="${pageContext.request.contextPath}/auth/login"
                                           class="text-dark h6 mb-0">Đăng nhập</a></p>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
<script src="${pageContext.request.contextPath}/static/js/auth/auth_forgot_password.js"></script>
</body>
</html>