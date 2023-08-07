<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">

<jsp:include page="../layout/header.jsp"/>

<body>

<jsp:include page="../layout/menu-header-white.jsp"/>

<section class="bg-half-170 d-table w-100" >
  <div class="bg-overlay bg-overlay-dark"></div>
  <div class="container">
    <div class="row mt-5 justify-content-center">
      <div class="col-12">
        <div class="section-title text-center">
          <h3 class="sub-title mb-4 text-white title-dark">Tin Tức & Chủ đề</h3>
          <p class="para-desc mx-auto text-white-50">Bạn có thể trở thành một bác sĩ bất đắc dĩ trong gia đình với những kiến thức tại HNT Dental blog.
            Tại đây chúng tôi luôn cập nhập những thông tin bổ ích về sức khỏe, sinh lý, sơ cứu,...</p>

          <nav aria-label="breadcrumb" class="d-inline-block mt-3">
            <ul class="breadcrumb bg-light rounded mb-0 py-1 px-2">
              <li class="breadcrumb-item"><a href="home">Trang chủ</a></li>
              <li class="breadcrumb-item active" aria-current="page">Tin tức</li>
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



<!-- Start -->
<section class="section">
  <div class="container">
    <div class="container">
      <div class="row">
        <div class="col-lg-4">
          <input type="text" class="form-select form-control" name="txt"
                 value="${search}"
                 id="search" placeholder="Tìm kiếm bài viết...">
        </div>
        <div class="col-lg-2">
          <button class="btn btn-primary rounded-pill" id="btn-search">Tìm kiếm</button>
        </div>
        <div class="col-lg-4">
          <select id="select-category" class="form-select form-control">
            <option value="" <c:if test="${categoryId == null}">selected</c:if> >Tất cả</option>
            <c:forEach items="${categoryBlogList}" var="category">
              <option <c:if test="${categoryId == category.id}">selected</c:if> value="${category.id}">${category.name}</option>
            </c:forEach>
          </select>
        </div>
        <div class="col-lg-2">
          <button class="btn btn-primary rounded-pill" id="btn-category">Lọc</button>
        </div>
      </div>
      <br>
    </div>
    <div class="row">
      <c:forEach items="${blogs}" var="b">
        <div class="col-lg-4 col-md-6 col-12 mb-4 pb-2">
          <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
            <img src="${b.image}" class="img-fluid" style="height: 250px; width: 500px"
                 alt="">
            <div class="card-body p-4">
              <ul class="list-unstyled mb-2">
                <li class="list-inline-item text-muted small"><i
                        class="uil uil-clock text-dark h6 me-1"></i>
                </li>
                <li class="list-inline-item text-muted small me-3">${b.create_at}
                </li>

              </ul>
              <a href="${pageContext.request.contextPath}/blog/detail?id=${b.id}" class="text-dark title h5">${b.title}</a>
              <div class="post-meta d-flex justify-content-between mt-3">
                <a href="${pageContext.request.contextPath}/blog/detail?id=${b.id}" class="link">Đọc thêm <i
                        class="mdi mdi-chevron-right align-middle"></i></a>
              </div>
            </div>
          </div>
        </div>
        <!--end col-->
      </c:forEach>
      </div><!--end col-->
    <c:set var="page" value="${currentPage}"/>
    <div class="row text-center">

      <div class="col-12 mt-4">
        <div class="d-md-flex align-items-center text-center justify-content-between">
          <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
            <c:forEach begin="${1}" end="${totalPage}" var="i">
              <li class="page-item ${i==page?"active":""}"><a class="page-link"
                                                              href="${url}?page=${i}&search=${search}">${i}</a>
              </li>
            </c:forEach>
          </ul>
        </div>
      </div>
    </div>
      <div class="col-12">

      </div><!--end col-->
    </div><!--end row-->
  </div><!--end container-->
</section><!--end section-->
<!-- End -->
<jsp:include page="../layout/footer.jsp"/>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function () {
    $("#btn-search").click(function () {
      let search = $("#search").val();
      console.log(search)
      let categoryId = $("#select-category").val();
      window.location.href = "${url}?search=" + search +"&categoryId=" + categoryId;
    });
  });
  $(document).ready(function () {
    $("#btn-category").click(function () {
      let categoryId = $("#select-category").val();
      let search = $("#search").val();
      console.log(categoryId)
      window.location.href = "${url}?search=" + search +"&categoryId=" + categoryId;
    });
  });
</script>
</body>

</html>