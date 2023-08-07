<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<nav id="sidebar" class="sidebar-wrapper">
    <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
        <div class="sidebar-brand">
            <a href="home">
                <img src="${pageContext.request.contextPath}/static/images/logo.png" height="180" width="200"
                     class="logo-light-mode" alt="">
            </a>
        </div>

        <ul class="sidebar-menu pt-3">

            <c:if test="${sessionScope.account.role == 1}">
                <li><a href="${pageContext.request.contextPath}/management/dashboard"><i class="uil uil-dashboard me-2 d-inline-block"></i>Bảng điều khiển </a></li>
                <li><a href="${pageContext.request.contextPath}/management/employee"><i
                        class="uil uil-user me-2 d-inline-block"></i>Quản lý nhân viên </a></li>
                <li><a href="${pageContext.request.contextPath}/management/doctor"><i
                        class="uil uil-user me-2 d-inline-block"></i>Quản lý bác sĩ </a></li>
                <li><a href="${pageContext.request.contextPath}/management/patient"><i
                        class="uil uil-user me-2 d-inline-block"></i>Quản lý bệnh nhân </a></li>
                <li><a href="${pageContext.request.contextPath}/management/service"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý dịch vụ </a></li>
                <li><a href="${pageContext.request.contextPath}/management/booking"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý lịch hẹn </a></li>
                <li><a href="${pageContext.request.contextPath}/management/blog"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý bài đăng </a></li>
            </c:if>
            <c:if test="${sessionScope.account.role == 2}">
                <li><a href="${pageContext.request.contextPath}/management/booking"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý lịch hẹn </a></li>
            </c:if>
            <c:if test="${sessionScope.account.role == 3}">
                <li><a href="${pageContext.request.contextPath}/management/doctor"><i
                        class="uil uil-user me-2 d-inline-block"></i>Quản lý bác sĩ </a></li>
                <li><a href="${pageContext.request.contextPath}/management/patient"><i
                        class="uil uil-user me-2 d-inline-block"></i>Quản lý bệnh nhân </a></li>
                <li><a href="${pageContext.request.contextPath}/management/service"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý dịch vụ </a></li>
                <li><a href="${pageContext.request.contextPath}/management/booking"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý lịch hẹn </a></li>
                <li><a href="${pageContext.request.contextPath}/management/blog"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý bài đăng </a></li>
            </c:if>
            <c:if test="${sessionScope.account.role == 4}">
                <li><a href="${pageContext.request.contextPath}/management/booking"><i
                        class="ri-user-2-line h5 fw-normal mb-0"></i>Quản lý lịch hẹn </a></li>
                <li><a href="${pageContext.request.contextPath}/management/myPatientOfDoctor"><i
                        class="uil uil-user me-2 d-inline-block"></i>Bệnh nhân của tôi</a></li>
            </c:if>


        </ul>
    </div>
</nav>
