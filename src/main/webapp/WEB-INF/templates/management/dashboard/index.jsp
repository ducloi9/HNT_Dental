
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<jsp:include page="../layout/head.jsp"/>
<body>
<div class="page-wrapper doctris-theme toggled">
  <jsp:include page="../layout/slide_bar.jsp"/>
  <main class="page-content bg-light">
    <jsp:include page="../layout/menu_bar.jsp"/>
    <div class="container-fluid">
      <div class="layout-specing">
        <h5 class="mb-0">Dashboard</h5>
        <div class="row">
          <div class="col-xl-6 col-lg-4 col-md-4 mt-4">
            <div class="card features feature-primary rounded border-0 shadow p-4">
              <div class="d-flex align-items-center">
                <div class="icon text-center rounded-md">
                  <i class="uil uil-bed h3 mb-0"></i>
                </div>
                <div class="flex-1 ms-2">

                  <p class="text-muted mb-0">Bệnh nhân</p>
                  <h5 class="mb-0">${countPatient}</h5>
                </div>
              </div>
            </div>
          </div>

          <div class="col-xl-6 col-lg-4 col-md-4 mt-4">
            <div class="card features feature-primary rounded border-0 shadow p-4">
              <div class="d-flex align-items-center">
                <div class="icon text-center rounded-md">
                  <i class="uil uil-social-distancing h3 mb-0"></i>
                </div>
                <div class="flex-1 ms-2">

                  <p class="text-muted mb-0">Bác sĩ</p>
                  <h5 class="mb-0">${countDoctor}</h5>
                </div>
              </div>
            </div>
          </div>

          <div class="col-xl-6 col-lg-4 col-md-4 mt-4">
            <div class="card features feature-primary rounded border-0 shadow p-4">
              <div class="d-flex align-items-center">
                <div class="icon text-center rounded-md">
                  <i class="uil uil-file-medical-alt h3 mb-0"></i>
                </div>
                <div class="flex-1 ms-2">
                  <p class="text-muted mb-0">Doanh thu</p>
                  <h5 class="mb-0">${countRevenue}đ</h5>
                </div>
              </div>
            </div>
          </div>

          <div class="col-xl-6 col-lg-4 col-md-4 mt-4">
            <div class="card features feature-primary rounded border-0 shadow p-4">
              <div class="d-flex align-items-center">
                <div class="icon text-center rounded-md">
                  <i class="uil uil-medkit h3 mb-0"></i>
                </div>
                <div class="flex-1 ms-2">
                  <p class="text-muted mb-0">Số lịch hẹn</p>
                  <h5 class="mb-0">${countBooking}</h5>
                </div>
              </div>

            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-12 mt-4">
            <div class="card shadow border-0 p-4">
              <div class="d-flex justify-content-between align-items-center mb-3">
                <h6 class="align-items-center mb-0">Thống kê số lịch hẹn</h6>
                <div class="mb-0 position-relative">
                  <select onchange="window.location.href = '/management/dashboard?type=' + this.value" class="form-select form-control" id="yearchart">
                    <option <c:if test="${param.type == '7'}"> selected </c:if> value="7">7 ngày gần đây</option>
                    <option <c:if test="${param.type == '14'}"> selected </c:if> value="14">14 Ngày gần đây</option>
                    <option <c:if test="${param.type == '30'}"> selected </c:if> value="30">30 ngày gần đây</option>
                  </select>
                </div>
              </div>
              <div id="dashboard" class="apex-chart"></div>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-xl-12 col-lg-12 mt-4">
            <div class="card border-0 shadow rounded">
              <div class="d-flex justify-content-between align-items-center p-4 border-bottom">
                <h6 class="mb-0"><i class="uil uil-calender text-primary me-1 h5"></i>Danh sách lịch hẹn hôm nay</h6>
              </div>

              <table class="list-unstyled mb-0 p-4">
                <thead>
                <tr>
                  <th class="border-bottom p-3" >Bệnh nhân</th>
                  <th class="border-bottom p-3" >Dịch vụ</th>
                  <th class="border-bottom p-3" >Loại dịch vụ</th>
                  <th class="border-bottom p-3" >Thời gian</th>
                  <th class="border-bottom p-3" >Trạng thái</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${getBookingToday}" var="getBookingToday">
                  <tr>
                    <td class="border-bottom p-3">${getBookingToday.name}</td>
                    <td class="border-bottom p-3">${getBookingToday.service.name}</td>
                    <td class="border-bottom p-3">${getBookingToday.serviceType.name}</td>
                    <td class="border-bottom p-3">${getBookingToday.time}</td>
                    <td class="border-bottom p-3 align-content-center">${getBookingToday.status}</td>
                  </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>

  </main>
</div>
<script src="${pageContext.request.contextPath}/static/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.41.0/apexcharts.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
  var options1 = {
    series: [{
      name: 'Booking',
      data: [<c:forEach items="${getStatisticBookingTime}" var="a">${a.count},</c:forEach>]
    }],
    chart: {
      type: 'bar',
      height: 350,
      stacked: true,
      toolbar: {
        show: true
      },
      zoom: {
        enabled: true
      }
    },
    responsive: [{
      breakpoint: 480,
      options: {
        legend: {
          position: 'bottom',
          offsetX: -10,
          offsetY: 0
        }
      }
    }],
    plotOptions: {
      bar: {
        horizontal: false,
        borderRadius: 10
      },
    },
    xaxis: {
      type: 'text',
      categories: [<c:forEach items="${getStatisticBookingTime}" var="a">'${a.date}',</c:forEach>
      ],
    },
    legend: {
      position: 'right',
      offsetY: 40
    },
    fill: {
      opacity: 1
    }
  };
  var chart1 = new ApexCharts(document.querySelector("#dashboard"), options1);
  chart1.render();
</script>
</body>
</html>


