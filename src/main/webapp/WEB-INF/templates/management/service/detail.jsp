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
                                    <h5 class="mb-0">Thông tin dịch vụ</h5>
                                </div>
                                <br><br><br><br><br>
                                <div class="text-center margin-nagative mt-n5 position-relative pb-4 border-bottom">

                                    <img src="${serviceDetail.image}"
                                         class="img-fluid rounded w-50 h-50" alt="">
                                    <h5 class="mt-3 mb-1">${serviceDetail.name}</h5>
                                </div>

                                <div class="p-4">
                                    <div class="d-flex align-items-center mt-2 row">
                                        <h6 class="mb-0 col-1">Mô tả</h6>
                                        <p class="mb-0 col-11">${serviceDetail.description}</p>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-12 col-md-12 mt-4">
                            <div class="bg-white rounded shadow overflow-hidden">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Danh sách loại dịch vụ</h5>
                                    <button type="button" class="btn btn-soft-primary mt-2"
                                            data-bs-toggle="modal" data-bs-target="#add_service_type">
                                        Thêm
                                    </button>
                                </div>
                                <table class="table p-4 mb-0 table-center">
                                    <thead>
                                    <tr>
                                        <th class="border-bottom p-3">Loại</th>
                                        <th class="border-bottom p-3">Gía tiền</th>

                                        <th class="border-bottom p-3">Tác vụ</th>
                                    </tr>
                                    </thead>
                                    <tbody>


                                    <c:forEach items="${serviceTypeDetail}" var="s">
                                        <tr>
                                            <td class="p-3">${s.type}</td>
                                            <td class="p-3">${s.fee}</td>
                                            <td>
                                                <button type="button" class="btn btn-soft-primary"
                                                        data-bs-toggle="modal" data-bs-target="#service_type${s.id}">
                                                    Cập nhật
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>


                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="col-lg-12 col-md-12 mt-4">
                            <div class="bg-white rounded shadow overflow-hidden">
                                <div class="p-4 border-bottom">
                                    <h5 class="mb-0">Danh sách bác sĩ của dịch vụ</h5>
                                </div>
                                <table class="table p-4 mb-0 table-center">
                                    <thead>


                                    <tr>
                                        <th class="border-bottom p-3">Tên bác sĩ</th>
                                        <th class="border-bottom p-3">Email</th>
                                        <th class="border-bottom p-3">Loại</th>
                                        <th class="border-bottom p-3">Tác vụ</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${doctorOfService}" var="d">
                                        <tr>
                                            <td class="p-3">${d.name}</td>
                                            <td class="p-3">${d.email}</td>
                                            <td class="p-3">${d.type}</td>

                                            <td>
                                                <button type="button" class="btn btn-danger"
                                                        onclick="deleteDoctor(${d.id})">
                                                    Xóa
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
                                <form action="${pageContext.request.contextPath}/management/service/update?id=${serviceDetail.id}"
                                      method="POST"
                                      enctype="multipart/form-data"
                                      onSubmit="document.getElementById('submit').disabled = true;">
                                    <h5 class="mb-0">Chỉnh sửa thông tin :</h5>
                                    <p hidden="">${serviceDetail.id}</p>

                                    <div>
                                        <p class="text-muted">Cập nhật ảnh dịch vụ</p>
                                        <div id="myfileupload">
                                            <input type="file" name="image" id="uploadfile" name="ImageUpload"
                                                   onchange="readURL(this);"/>
                                        </div>
                                        <div id="thumbbox">
                                            <img class="rounded" height="20%" width="30%" alt="Thumb image"
                                                 id="thumbimage" style="display: none"/>
                                            <a class="removeimg" href="javascript:"></a>
                                        </div>
                                        <div id="boxchoice">
                                            <a href="javascript:" class="Choicefile"><i
                                                    class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                                            <p style="clear:both"></p>
                                            <input type="submit" id="" style="display: none" name="send"
                                                   class="Update btn btn-primary"
                                                   value="Cập nhật">
                                            <p style="clear:both"></p>
                                        </div>
                                    </div>
                                </form>

                                <form action="${pageContext.request.contextPath}/management/service/update"
                                      method="POST"
                                      class="mt-4" onSubmit="document.getElementById('submit').disabled = true;">
                                    <input value="${param.id}" name="id" hidden="hidden">
                                    <div class="row">
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Tên dịch vụ</label>
                                                <input name="name" oninvalid="CheckFullName(this);"
                                                       oninput="CheckFullName(this);" id="name" type="text"
                                                       class="form-control" value="${serviceDetail.name}">
                                            </div>
                                        </div>

                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Mô tả</label>
                                                <input name="description" type="text" class="form-control"
                                                       value="${serviceDetail.description}">
                                            </div>
                                        </div>
                                        <div class="col-lg-12">
                                            <div class="mb-3">
                                                <label class="form-label">Trạng thái <span
                                                        class="text-danger"></span></label>
                                                <table>
                                                    <tbody>
                                                    <tr class="d-flex align-items-center">
                                                        <td><input id="credit"
                                                                   name="status" ${serviceDetail.status==true?"checked":""}
                                                                   value="true" type="radio"
                                                                   class="form-check-input"
                                                                   checked required></td>
                                                        <td><label class="form-check-label">Hoạt động</label></td>
                                                        <td></td>
                                                        <td><input id="debit"
                                                                   name="status" ${serviceDetail.status==false?"checked":""}
                                                                   value="false" type="radio"
                                                                   class="form-check-input"
                                                                   required></td>
                                                        <td><label class="form-check-label">Khóa</label></td>
                                                    </tr>
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

        <c:forEach items="${serviceTypeDetail}" var="s">
            <div class="modal fade" id="service_type${s.id}" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <form action="${pageContext.request.contextPath}/management/service/updateFee" method="post">
                        <div class="modal-content">
                            <div class="modal-body mx-3">
                                <div class="md-form mb-2">
                                    <i class="fas fa-envelope prefix grey-text"></i>
                                    <label data-error="wrong" data-success="right">Loại dịch vụ</label>
                                    <input value="${param.id}" name="id" hidden="">
                                    <select name="idServiceType" class="form-control" hidden="">
                                        <c:forEach items="${types}" var="t">
                                            <option
                                                    <c:if test="${s.type == t.nameType}">selected</c:if>
                                                    value="${t.idType}">${t.nameType}</option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <div class="md-form mb-2">
                                    <label data-error="wrong" data-success="right">Giá</label>
                                    <input type="text" name="fee" value="${s.fee}" class="form-control validate">
                                </div>

                            </div>
                            <div class="modal-footer d-flex justify-content-center">
                                <button class="btn btn-primary" type="submit">Lưu</button>
                                <button class="btn btn-danger">Xóa</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </c:forEach>

        <div class="modal fade" id="add_service_type" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
             aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <form action="${pageContext.request.contextPath}/management/service/createFee" method="POST"
                          class="mt-4">
                        <input value="${param.id}" name="id" hidden="">
                        <div class="modal-body mx-3">
                            <div class="md-form mb-2">
                                <i class="fas fa-envelope prefix grey-text"></i>
                                <label data-error="wrong" data-success="right">Thêm loại của dịch vụ</label>
                                <select name="idType" class="form-control">
                                    <c:forEach items="${getTypeOfServiceAvailable}" var="g">
                                        <option value="${g.idType}">${g.nameType}</option>
                                    </c:forEach>
                                </select>

                            </div>

                            <div class="md-form mb-2">
                                <label data-error="wrong" data-success="right">Giá</label>
                                <input type="text" name="fee"
                                       class="form-control validate">
                            </div>
                            <div class="modal-footer d-flex justify-content-center">
                                <button class="btn btn-primary" type="submit"
                                        <c:if test="${getTypeOfServiceAvailable.size() == 0}">disabled</c:if>
                                >Thêm
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
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
    function deleteDoctor(id) {
        if (confirm("Bạn có chắc chắn muốn xóa bác sĩ này không?")) {
            window.location.href = "${pageContext.request.contextPath}/management/service/deleteDoctor?id=${param.id}&&did=" + id;
        }
    }
</script>
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
