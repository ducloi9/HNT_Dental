<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 6/21/2023
  Time: 4:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                <div class="row">
                    <div class="col-lg-12">
                        <ul class="nav nav-pills nav-justified flex-column flex-sm-row rounded" id="pills-tab"
                            role="tablist">
                            <li class="nav-item">
                                <a class="nav-link rounded active" id="pills-cloud-tab" data-bs-toggle="pill"
                                   href="#info" role="tab" aria-controls="infor" aria-selected="false">
                                    <div class="text-center pt-1 pb-1">
                                        <h4 class="title font-weight-normal mb-0">Thông tin</h4>
                                    </div>
                                </a>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link rounded" id="pills-smart-tab" data-bs-toggle="pill" href="#edit"
                                   role="tab" aria-controls="edit" aria-selected="false">
                                    <div class="text-center pt-1 pb-1">
                                        <h4 class="title font-weight-normal mb-0">Thêm mới</h4>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="tab-content" id="1">
                    <div class="tab-pane show active row" id="info" role="tabpanel" aria-labelledby="info">
                        <div class="col-lg-12 col-md-12 mt-4">
                            <div class="bg-white rounded shadow overflow-hidden">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Danh sách loại dịch vụ</h5>
                                </div>
                                <table class="table p-4 mb-0 table-center">
                                    <thead>
                                    <tr>
                                        <th class="border-bottom p-3">ID</th>
                                        <th class="border-bottom p-3">Tên</th>
                                        <th class="border-bottom p-3">Mô tả</th>
                                        <th class="border-bottom p-3">Rank phụ trách</th>
                                        <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${serviceTypes}" var="s">
                                        <tr>

                                            <td class="p-3">${s.id}</td>
                                            <td class="p-3">${s.name}</td>
                                            <td class="p-3">${s.description}</td>
                                            <td class="p-3">${s.rankName}</td>
                                            <td>
                                                <button type="button" class="btn btn-primary"
                                                        data-bs-toggle="modal" onclick="window.location.href='${pageContext.request.contextPath}/management/type/detail?id=${s.id}'" >
                                                    Chi tiết
                                                </button>
                                                <button type="button" class="btn btn-danger"
                                                         onclick="deleteType(${s.id})">
                                                    Xóa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <c:set var="page" value="${currentPage}"/>
                        <div class="row text-center">
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <c:forEach begin="${1}" end="${totalPage}" var="i">
                                            <li class="page-item ${i==page?"active":""}"><a class="page-link"
                                                                                            href="${url}?page=${i}">${i}</a>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="edit" role="tabpanel" aria-labelledby="edit">
                        <div class="card border-0 shadow overflow-hidden">
                            <div class="tab-content p-4" id="pills-tabContent">

                                <h5 class="mb-0">Thêm mới loại dịch vụ :</h5>

                                <form action="/management/type/create" method="POST"
                                      class="mt-4">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên</label>
                                                <input name="name" id="name" type="text"
                                                       class="form-control">
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mô tả</label>
                                                <input name="description" type="text" class="form-control">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <input type="submit" id="submit" name="send" class="btn btn-primary"
                                                   value="Thêm">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <c:forEach items="${serviceTypeDetail}" var="s">
            <div class="modal fade" id="service_type${s.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body mx-3">
                            <div class="md-form mb-2">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <label data-error="wrong" data-success="right">Loại dịch vụ</label>

                                <select name="types" class="form-control">
                                    <c:forEach items="${types}" var="t">
                                        <option
                                                <c:if test="${s.type == t.nameType}">selected</c:if>
                                                value="${t.idType}">${t.nameType}</option>
                                    </c:forEach>
                                </select>

                            </div>

                            <div class="md-form mb-2">
                                <label data-error="wrong" data-success="right">Giá</label>
                                <input type="text" name="price" value="${s.fee}" class="form-control validate">
                            </div>

                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button class="btn btn-primary">Lưu</button>
                            <button class="btn btn-danger">Xóa</button>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:forEach items="${doctorOfService}" var="d">
            <div class="modal fade" id="doctor_id${d.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-body mx-3">
                            <div class="md-form mb-2">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <div class="md-form mb-2">
                                    <label data-error="wrong" data-success="right">Loại dịch vụ của bác sĩ
                                        : ${d.name}</label>
                                    <c:forEach items="${d.types}" var="t">
                                        <div class="d-flex justify-content-between bg-light p-2 mb-2">
                                            <p>${t.nameType}</p>
                                            <button class="btn btn-danger">Xóa</button>
                                        </div>
                                    </c:forEach>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        <jsp:include page="../layout/footer.jsp"/>
    </main>

</div>


<script src="${pageContext.request.contextPath}/static/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>

</body>
<script>
    function deleteType(id){
        window.location.href = "${pageContext.request.contextPath}/management/type/deletemain?id="+id;
    }
</script>
</html>
