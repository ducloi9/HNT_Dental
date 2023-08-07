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
                                        <h4 class="title font-weight-normal mb-0">Chỉnh sửa</h4>
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
                                    <h5 class="mb-0">Thông tin loại dịch vụ</h5>
                                </div>
                                <br>

                                <div class="p-4">
                                    <div class="d-flex align-items-center mt-2 row">
                                        <h6 class="mb-0 col-1">Loại dịch vụ:</h6>
                                        <p class="mb-0 col-11">${serviceType.name}</p>
                                    </div>
                                </div>

                                <div class="p-4">
                                    <div class="d-flex align-items-center mt-2 row">
                                        <h6 class="mb-0 col-1">Mô tả:</h6>
                                        <p class="mb-0 col-11">${serviceType.description}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 mt-4">
                            <div class="bg-white rounded shadow overflow-hidden">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Danh sách rank của các loại dịch vụ</h5>
                                    <button type="button" class="btn btn-soft-primary"
                                            data-bs-toggle="modal" data-bs-target="#rank_new">
                                        Thêm rank
                                    </button>
                                </div>


                                <table class="table p-4 mb-0 table-center">
                                    <thead>
                                    <tr>
                                        <th class="border-bottom p-3">STT</th>
                                        <th class="border-bottom p-3">Tên</th>

                                        <th class="border-bottom p-3">Tác vụ</th>
                                    </tr>
                                    </thead>
                                    <tbody>

                                    <c:forEach items="${getAllRankOfType}" var="rank">
                                        <tr>
                                            <td class="p-3">${getAllRankOfType.indexOf(rank) + 1}</td>
                                            <td class="p-3">${rank.doctorRank.name}</td>
                                            <td>
                                                <button type="button" class="btn btn-danger" onclick="deleteType(${rank.id}, ${rank.doctorRank.id})">
                                                    Xoa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane fade" id="edit" role="tabpanel" aria-labelledby="edit">
                        <div class="card border-0 shadow overflow-hidden">
                            <div class="tab-content p-4" id="pills-tabContent">

                                <form action="${pageContext.request.contextPath}/management/type/update"
                                      method="POST"
                                      class="mt-4" >
                                    <input value="${param.id}"name="id"hidden="hidden">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên dịch vụ</label>
                                                <input name="name" id="name" type="text"
                                                       class="form-control" value="${serviceType.name}">
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mô tả</label>
                                                <input name="description" type="text" class="form-control"
                                                       value="${serviceType.description}">
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Trạng thái <span
                                                        class="text-danger"></span></label>
                                                <table>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <input type="submit" id="submit" name="send" class="btn btn-primary"
                                                   value="Cập nhật">
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="rank_new" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <form action="${pageContext.request.contextPath}/management/type/detail" method="post">
                    <div class="modal-content">
                        <div class="modal-body mx-3">
                            <div class="md-form mb-2">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <label data-error="wrong" data-success="right">Cấp bậc</label>
                                <input name="id" value="${param.id}" hidden="hidden">
                                <select name="rank" class="form-control">

                                    <c:forEach items="${listRankOfTypeAvailable}" var="l">
                                        <option value="${l.id}">${l.name}</option>
                                    </c:forEach>
                                </select>

                            </div>
                        </div>
                        <div class="modal-footer d-flex justify-content-center">
                            <button <c:if test="${listRankOfTypeAvailable.size() == 0}"> disabled </c:if>


                                    type="submit" class="btn btn-primary">Lưu</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="../layout/footer.jsp"/>
    </main>

</div>


<script src="${pageContext.request.contextPath}/static/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>

<script>
    function deleteType(id, rankId){
        window.location.href = "${pageContext.request.contextPath}/management/type/delete?id="+id+"&rank="+rankId;
    }
</script>
</body>
</html>
