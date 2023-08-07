<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<jsp:include page="layout/header.jsp"/>

<body>
<jsp:include page="layout/menu-header-white.jsp"/>

<section class="bg-dashboard">
  <div class="container">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card mt-4">
          <div class="card-header">Đánh giá dịch vụ và bác sĩ</div>
          <div class="card-body">
            <!-- Feedback Form -->
            <form id="feedbackForm" action="${pageContext.request.contextPath}/auth/my-feedback" method="post">
              <div class="form-group mb-3">
                <label for="feedbackType">Loại đánh giá:</label>
                <select name="feedbackType" id="feedbackType" class="form-control" required>
                  <option value="service">Đánh giá dịch vụ</option>
                  <option value="doctor">Đánh giá bác sĩ</option>
                </select>
              </div>
              <div class="form-group mb-3">
                <label>Đánh giá sao:</label>
                <div class="star-rating">
                  <input type="radio" name="star" id="star5" value="5" required />
                  <label for="star5"></label>
                  <input type="radio" name="star" id="star4" value="4" required />
                  <label for="star4"></label>
                  <input type="radio" name="star" id="star3" value="3" required />
                  <label for="star3"></label>
                  <input type="radio" name="star" id="star2" value="2" required />
                  <label for="star2"></label>
                  <input type="radio" name="star" id="star1" value="1" required />
                  <label for="star1"></label>
                </div>
              </div>
              <div class="form-group mb-3">
                <label for="description">Nội dung đánh giá:</label>
                <textarea name="description" id="description" class="form-control" rows="5" required></textarea>
              </div>

              <!-- Hidden fields for feedback data -->
              <input type="hidden" name="id" value="${param.id}">
              <input type="hidden" name="booking_id" value="${param.booking_id}">
              <input type="hidden" name="doctor_id" value="${param.doctor_id}">
              <input type="hidden" name="service_id" value="${param.service_id}">
              <button type="submit" class="btn btn-primary">Gửi đánh giá</button>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- ... (existing content) ... -->

<jsp:include page="layout/footer.jsp"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-validate/1.19.5/jquery.validate.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script src="${pageContext.request.contextPath}/static/libs/tobii/js/tobii.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
<script src="https://cdn.jsdelivr.net/npm/toastr@2.1.4"></script>
<style>
  .star-rating {
    display: flex;
    align-items: center;
  }

  .star-rating input[type="radio"] {
    display: none;
  }

  .star-rating label {
    cursor: pointer;
  }

  .star-rating label:before {
    content: "\2605"; /* Unicode star icon */
    font-size: 24px;
    padding-right: 5px;
    color: #ffc107;
  }

  .star-rating input[type="radio"]:checked ~ label:before {
    color: #f39c12;
  }
</style>

<!-- Script for handling form submission with AJAX -->
<script>
  $(document).ready(function() {
    $("#feedbackForm").submit(function(e) {
      e.preventDefault();
      $.ajax({
        type: "POST",
        url: $(this).attr("action"),
        data: $(this).serialize(),
        success: function(data) {
          // Handle successful feedback submission with Swal notification
          Swal.fire({
            icon: "success",
            title: "Đánh giá thành công",
            text: "Cám ơn bạn đã đánh giá!",
            showConfirmButton: false,
            timer: 1500
          });
          // Redirect to the detail-appointment-history page
          setTimeout(function() {
            window.location.href = "${pageContext.request.contextPath}/auth/detail-appointment-history?id=${param.id}";
          }, 1500); // Redirect after 1.5 seconds
        },
        error: function(xhr, status, error) {
          // Handle failed feedback submission with Swal notification
          Swal.fire({
            icon: "error",
            title: "Đánh giá thất bại",
            text: "Đã xảy ra lỗi khi đánh giá. Vui lòng thử lại sau.",
            showConfirmButton: false,
            timer: 1500
          });
        }
      });
    });
  });
</script>

</body>
</html>
