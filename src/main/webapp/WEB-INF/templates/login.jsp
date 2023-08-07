<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 5/20/2023
  Time: 4:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <title>HNT Dental - Login</title>
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
        <div class="row d-flex justify-content-center">
            <div class="col-lg-5 col-md-8">
                <div class="card login-page shadow mt-4 rounded border-0">
                    <div class="card-body">
                        <h4 class="text-center">Đăng nhập</h4>
                        <p id="content" style="color: red; align-content: center;"></p>
                        <form class="login-form mt-4" id="login">
                            <div class="row">
                                <div class="col-lg-12">
                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                    <div class="mb-3">
                                        <input type="email" class="form-control" placeholder="Email"
                                               name="email">
                                    </div>
                                </div>

                                <div class="col-lg-12">
                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu <span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" placeholder="Mật khẩu"
                                               name="password">
                                    </div>
                                </div>

                                <div class="col-lg-12">
                                    <div class="d-flex justify-content-between">
                                        <a href="${pageContext.request.contextPath}/auth/forgot" class="text-dark h6 mb-0">Quên mật khẩu ?</a>
                                    </div>
                                </div>
                                <div class="col-lg-12 mb-0">
                                    <div class="d-grid">
                                        <button class="btn btn-primary" type="submit" id="btn-login">Đăng nhập</button>
                                    </div>
                                </div>

                                <div class="col-12 text-center">
                                    <p class="mb-0 mt-3"><small class="text-dark me-2">Chưa có tài khoản ?</small> <a
                                            href="${pageContext.request.contextPath}/auth/register" class="text-dark fw-bold">Đăng ký</a></p>
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
<script src="${pageContext.request.contextPath}/static/js/auth/auth_login.js"></script>
</body>

</html>