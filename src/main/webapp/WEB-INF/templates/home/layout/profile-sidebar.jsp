<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="col-xl-3 col-lg-3 col-md-4 col-12">
    <div class="rounded shadow overflow-hidden sticky-bar">
        <div class="text-center avatar-profile margin-nagative mt-n5 position-relative pb-4 border-bottom">
            <br><br><br><br>
            <c:if test="${sessionScope.profile.image != null}">
                <img src="${sessionScope.profile.image}"
                     class="rounded-circle shadow-md avatar avatar-md-md" alt="">
            </c:if>
            <c:if test="${sessionScope.profile.image == null}">
                <img src="${pageContext.request.contextPath}/static/images/user.png"
                     class="rounded-circle shadow-md avatar avatar-md-md" alt="">
            </c:if>

            <h5 class="mt-3 mb-1">${sessionScope.profile.fullName}</h5>
            <p class="text-muted mb-0">${sessionScope.profile.email}</p>
        </div>

        <ul class="list-unstyled sidebar-nav mb-0">
            <c:if test="${sessionScope.account.role == 0}">
                <li class="navbar-item"><a href=" /auth/profile" class="navbar-link"><i
                        class="ri-airplay-line align-middle navbar-icon"></i>Thông tin tài khoản</a></li>
                <li class="navbar-item"><a href="/auth/service-booking-history" class="navbar-link"><i
                        class="ri-airplay-line align-middle navbar-icon"></i> Lịch sử dịch vụ</a></li>
                <li class="navbar-item"><a href="/auth/my-appointment-history" class="navbar-link"><i
                        class="ri-airplay-line align-middle navbar-icon"></i> Lịch sử lịch hẹn</a></li>
            </c:if>
            <c:if test="${sessionScope.account.role != 0}">
                <li class="navbar-item"><a href="/auth/profile" class="navbar-link"><i
                        class="ri-airplay-line align-middle navbar-icon"></i>Thông tin tài khoản</a></li>
            </c:if>
        </ul>
    </div>
</div>