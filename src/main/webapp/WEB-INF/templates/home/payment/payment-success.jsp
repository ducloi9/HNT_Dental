<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 6/23/2023
  Time: 2:40 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="../../home/layout/header.jsp"/>
<body>
<div class="back-to-home rounded d-none d-sm-block">
    <a href="home" class="btn btn-icon btn-primary"><i data-feather="home" class="icons"></i></a>
</div>

<section class="bg-home d-flex bg-light align-items-center" style="background: url('https://file.vfo.vn/hinh/2018/03/hinh-mau-trang-tinh-tron-hinh-nen-anh-dai-dien-anh-bia-toan-mau-trang1.png') center;">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-10 text-center">
            <br><br><br><br><br>
            <img src="${pageContext.request.contextPath}/static/images/payment/payment-success.gif" class="img-fluid" alt="">
            <br><br><br><br>
            <h3 class="mb-4">Thanh toán thành công.</h3>
            <a href="${pageContext.request.contextPath}/home" class="btn btn-primary mt-2">Quay lại trang chủ</a>
        </div>
    </div>
</div>
</section>

</body>

</html>






