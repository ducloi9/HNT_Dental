<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<header id="topnav" class="navigation sticky">
    <div class="container">

        <div>
            <a class="logo" href="${pageContext.request.contextPath}/home">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" class="logo-light" alt=""
                     height="80" width="80">
            </a>
        </div>

        <div class="menu-extras">
            <div class="menu-item">
                <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                    <div class="lines">
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </a>
            </div>
        </div>

        <ul class="dropdowns list-inline mb-0">


            <li class="list-inline-item mb-0 ms-1">
                <div class="dropdown dropdown-primary">
                    <c:if test="${sessionScope.account != null}">
                        <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0"
                                data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img
                                src="${pageContext.request.contextPath}/static/images/user.png"
                                class="avatar avatar-ex-small rounded-circle" alt=""></button>
                    </c:if>

                    <c:if test="${sessionScope.account == null}">
                        <button class="btn btn-primary p-1" onclick="window.location.href = '/auth/login'">Đăng nhập
                        </button>
                    </c:if>
                    <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3"
                         style="min-width: 200px;">
                        <c:if test="${sessionScope.account != null}">
                            <a class="dropdown-item d-flex align-items-center text-" href="#">
                                <img src="${pageContext.request.contextPath}/static/images/user.png"
                                     class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                <div class="flex-1 ms-2">
                                    <span class="d-block mb-1">${sessionScope.account.email}</span>
                                </div>
                            </a>
                            <a class="dropdown-item text-"
                               href="${pageContext.request.contextPath}/auth/profile"><span
                                    class="mb-0 d-inline-block me-1"><i
                                    class="uil uil-sign-out-alt align-middle h6"></i></span> Tài khoản của tôi</a>
                            <c:if test="${sessionScope.account.role != 0}">
                                <a class="dropdown-item text-"
                                   href="${pageContext.request.contextPath}/management-router"><span
                                        class="mb-0 d-inline-block me-1"><i
                                        class="uil uil-sign-out-alt align-middle h6"></i></span> Quản lý</a>
                            </c:if>
                        </c:if>
                        <div class="dropdown-divider border-top"></div>

                        <c:if test="${sessionScope.account != null}">
                            <a class="dropdown-item text-" href="${pageContext.request.contextPath}/auth/logout"><span
                                    class="mb-0 d-inline-block me-1"><i
                                    class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng xuất</a>
                        </c:if>
                        <c:if test="${sessionScope.account == null}">
                            <a class="dropdown-item text-" href="#"><span
                                    class="mb-0 d-inline-block me-1"><i
                                    class="uil uil-sign-out-alt align-middle h6"></i></span> Đăng Nhập</a>
                        </c:if>
                    </div>
                </div>
            </li>
        </ul>

        <div id="navigation">

            <ul class="navigation-menu nav-left nav-light">
                <li><a href="/" class="sub-menu-item">Trang chủ</a></li>
                <li><a href="/doctor" class="sub-menu-item">Bác sĩ</a></li>
                <li><a href="/service" class="sub-menu-item">Dịch vụ</a></li>
                <li><a href="/about" class="sub-menu-item">Liên hệ</a></li>
                <li><a href="/blog" class="sub-menu-item">Tin tức & chủ đề</a></li>
            </ul>

        </div>
    </div>
</header>
