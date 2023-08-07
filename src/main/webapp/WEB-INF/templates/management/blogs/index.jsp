<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<jsp:include page="../layout/head.jsp"/>
<body>
<div id="demo-modal" class="modal">
    <div class="modal__content" id="model_content">
        <h2>Confirm</h2>
        <p>
            Bạn có muốn thay đổi trạng thái của blog ?
        </p>
        <div class="modal__footer">
            <button type="button" onclick="modal_close()" class="button-10">Hủy</button>
            <button type="button" onclick="modal_change()" class="button-10">Xác nhận</button>
        </div>

        <a href="#" class="modal__close">&times;</a>
    </div>
</div>
<div class="page-wrapper doctris-theme toggled">
    <jsp:include page="../layout/slide_bar.jsp"/>
    <main class="page-content bg-light">
        <jsp:include page="../layout/menu_bar.jsp"/>
        <div class="container-fluid">
            <div class="layout-specing">
                <div class="row">
                    <div class="col-md-10 row">
                        <div class="col-md-6">
                            <div class="search-bar p-0 d-lg-block ms-2">
                                <div class="menu-search mb-0">
                                    <form action="${pageContext.request.contextPath}/management/blog" method="get"
                                          id="searchform" class="searchform">
                                        <div>
                                            <input
                                                    value="${search}"
                                                    type="text" class="border rounded"
                                                    name="search" id="search" placeholder="Nhập từ khóa">
                                            <input type="submit" id="searchsubmit" value="Search">
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-2 row align-items-center">
                            <a href="${pageContext.request.contextPath}/management/blog/create" class="btn btn-primary"
                               onclick="window.location.href='/management/blog/create'">Thêm mới</a>
                        </div>
                    </div>
                </div>
                <br>
                <br>
                <div class="row">
                    <form action="${pageContext.request.contextPath}/management/blog" method="get">
                        <div class="row">
                            <div class="col-md-4 row align-items-center">
                                <div class="col-md-4">
                                    <label class="form-label">Danh Mục</label>
                                </div>
                                <div class="col-md-8">
                                    <select name="category" class="form-select">
                                        <option value="all">Tất cả</option>
                                        <c:forEach var="c" items="${cate_lst}">
                                            <option value="${c.id}"
                                                    <c:if test="${c.id.toString() eq category}">selected</c:if>
                                            >${c.name}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3 row align-items-center">
                                <div class="col-md-5">
                                    <label class="form-label">Trạng Thái</label>
                                </div>
                                <div class="col-md-7">
                                    <select name="status" class="form-select">
                                        <option value="all" ${status == 'all' ? 'selected' : ''}>Tất cả</option>
                                        <option value="0" ${status == '0' ? 'selected' : ''}>Ẩn</option>
                                        <option value="1" ${status == '1' ? 'selected' : ''}>Hiện</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-1 md-0">
                                <button type="submit" class="btn btn-primary">Lọc</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <c:forEach items="${blogs}" var="b">
                                <div class="col-xl-3 col-lg-4 col-md-6 col-12 mt-4">
                                    <div class="card blog blog-primary border-0 shadow rounded overflow-hidden">
                                        <img src="${b.image}" class="img-fluid"
                                             alt="">
                                        <div class="card-body p-4">
                                            <ul class="list-unstyled mb-2">
                                                <li class="list-inline-item text-muted small me-3">${b.categoryBlog.name}
                                                </li>
                                                <li class="list-inline-item text-muted small">${b.create_at}
                                                </li>
                                            </ul>
                                            <a href="#" class="text-dark title h5">${b.title}</a>
                                            <br>
                                            <br>
                                            <div class="post-meta d-flex justify-content-between mt-3">
                                                <table>
                                                    <tbody>
                                                    <tr>
                                                        <td class="p-3 text-center">
                                                            <button class="btn btn-primary"
                                                                    onclick="window.location.href='${pageContext.request.contextPath}/management/blog/update?id=${b.id}'"
                                                            >Xem
                                                            </button>

                                                            <button class="btn btn-danger"
                                                                    onclick="onClickDelete(${b.id})"
                                                            >Xóa
                                                            </button>
                                                        </td>
                                                    </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!--end col-->
                            </c:forEach>
                        </div><!--end row-->
                        <c:set var="page" value="${currentPage}"/>
                        <div class="row">
                            <div class="col-12 mt-4">
                                <ul class="pagination justify-content-end mb-0 list-unstyled">
                                    <c:forEach begin="${1}" end="${totalPage}" var="i">
                                        <li class="page-item ${i==page?"status":""}"><a class="page-link"
                                                                                        href="${url}?page=${i}&search=${search}&category=${category}&status=${status}">${i}</a>
                                        </li>
                                    </c:forEach>
                                </ul><!--end pagination-->
                            </div><!--end col-->
                        </div><!--end row-->
                    </div>
                </div><!--end container-->
                <!-- Footer Start -->
            </div>
            <jsp:include page="../layout/footer.jsp"/>
    </main>
</div>
<script>
    function Sort(type) {
        window.location.href = "blogmanage?action=sort&type=" + type;
    }
    function onClickDelete(id) {
        Swal.fire({
            title: 'Bạn có chắc chắn muốn xóa?',
            text: "Bạn sẽ không thể khôi phục lại dữ liệu sau khi xóa!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Xóa',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = "${pageContext.request.contextPath}/management/blog/delete?id=" + id;
            }
        })
    }
</script>
<script src="${pageContext.request.contextPath}/static/libs/tobii/js/tobii.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/flatpickr.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/flatpickr.init.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/jquery.timepicker.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/date/timepicker.init.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</body>
<style>
    .Choicefile {
        display: block;
        background: #396CF0;
        border: 1px solid #fff;
        color: #fff;
        width: 150px;
        text-align: center;
        text-decoration: none;
        cursor: pointer;
        padding: 5px 0px;
        border-radius: 5px;
        font-weight: 500;
        align-items: center;
        justify-content: center;
    }

    .Choicefile:hover {
        text-decoration: none;
        color: white;
    }

    #uploadfile,
    .removeimg {
        display: none;
    }

    #thumbbox {
        position: relative;
        width: 100%;
        margin-bottom: 20px;
    }

    .removeimg {
        height: 25px;
        position: absolute;
        background-repeat: no-repeat;
        top: 5px;
        left: 5px;
        background-size: 25px;
        width: 25px;
        border-radius: 50%;

    }

    .removeimg::before {
        -webkit-box-sizing: border-box;
        box-sizing: border-box;
        content: '';
        border: 1px solid red;
        background: red;
        text-align: center;
        display: block;
        margin-top: 11px;
        transform: rotate(45deg);
    }

    .removeimg::after {
        content: '';
        background: red;
        border: 1px solid red;
        text-align: center;
        display: block;
        transform: rotate(-45deg);
        margin-top: -2px;
    }

</style>
</html>