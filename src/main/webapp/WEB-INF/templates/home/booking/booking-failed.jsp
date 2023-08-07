<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 6/17/2023
  Time: 4:37 PM
  To change this template use File | Settings | File Templates.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../layout/header.jsp"/>
<body>
<div class="back-to-home rounded d-none d-sm-block">
  <a href="home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
</div>

<!-- Hero Start -->
<section class="bg-home d-flex bg-light align-items-center">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-lg-7 col-md-10 text-center">
        <img src="${pageContext.request.contextPath}/static/images/booking/booking-error.gif" class="img-fluid" alt="">
        <br><br><br><br>
        <h3 class="mb-4">Lịch hẹn khởi tạo thất bại.</h3>
        <a href="home" class="btn btn-primary mt-2">Quay lại trang chủ</a>
      </div>
    </div>
  </div>
</section>

</body>

</html>



