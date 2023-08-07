<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<jsp:include page="../layout/head.jsp"/>
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
<body>
<div class="page-wrapper doctris-theme toggled">
    <jsp:include page="../layout/slide_bar.jsp"/>
    <main class="page-content bg-light">
        <jsp:include page="../layout/menu_bar.jsp"/>
        <div class="container-fluid">
            <div class="layout-specing">
                <div class="d-md-flex justify-content-between">
                    <h5 class="mb-0">Nhân viên</h5>
                    <nav aria-label="breadcrumb" class="d-inline-block mt-4 mt-sm-0">
                        <ul class="breadcrumb bg-transparent rounded mb-0 p-0">
                            <li class="breadcrumb-item"><a href="#">Quản lí</a></li>
                            <li class="breadcrumb-item"><a
                                    href="${pageContext.request.contextPath}/management/employee">Nhân viên</a></li>
                            <li class="breadcrumb-item status" aria-current="page">Thêm nhân viên</li>
                        </ul>
                    </nav>
                </div>

                <div class="row">
                    <div class="col-lg-12 mt-4">
                        <p style="color: red; font-weight: bold; padding: 10px">${error}</p>
                            <form class="mt-4" action="${pageContext.request.contextPath}/management/employee/update"
                                  enctype="multipart/form-data"
                                  method="post">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="col-lg-12">
                                        <div class="mb-3">
                                            <label class="form-label">Ảnh <span class="text-danger">*</span></label>
                                            <div id="myfileupload">
                                                <input type="file" name="image" class="img" id="uploadfile" name="ImageUpload"
                                                       onchange="readURL(this);"/>
                                            </div>
                                            <div id="thumbbox">
                                                <img class="rounded" height="20%" src="${employee.account.image}" width="30%" alt="Thumb image" id="thumbimage"
                                                <c:if test="${employee.account.image == null}">
                                                    style="display: none"
                                                </c:if>
                                                />
                                                <a class="removeimg" href="javascript:"></a>
                                            </div>
                                            <div id="boxchoice">
                                                <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i>
                                                    Chọn ảnh</a>
                                                <p style="clear:both"></p>
                                            </div>
                                        </div>
                                    </div>
                                <input value="${employee.account.id}" name="id" type="hidden">
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Họ và tên</label>
                                            <input name="full_name" id="name" type="text" class="form-control"
                                                   value="${employee.fullName}"
                                                   placeholder="Họ và tên :">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Ngày sinh</label>
                                            <input name="dob" id="name2" type="text" class="form-control"
                                                   value="${employee.dob}"
                                                   placeholder="DD/MM/YYYY">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Email</label>
                                            <input name="email" id="email" type="email" class="form-control"
                                                   value="${employee.account.email}"
                                                   placeholder="Email :">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ</label>
                                            <input name="address" id="address" type="text" class="form-control"
                                                   placeholder="Địa chỉ" value="${employee.address}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Điện thoại</label>
                                            <input name="phone" id="phone" type="text" class="form-control"
                                                   placeholder="Điện thoại" value="${employee.phone}">
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Chức vụ</label>
                                            <select name="position" class="form-select form-control">
                                                <option>Chọn chức vụ</option>
                                                <option value="marketing"
                                                        <c:if test="${employee.account.role == 3}">
                                                            selected
                                                        </c:if>
                                                >Marketing
                                                </option>
                                                <option value="staff"
                                                        <c:if test="${employee.account.role == 4}">
                                                            selected
                                                        </c:if>
                                                >Staff
                                                </option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Giới tính</label>
                                            <select name="gender" class="form-select form-control">
                                                <option value="nam">Nam</option>
                                                <c:if test="${employee.gender == true}">
                                                    selected
                                                </c:if>
                                                <option value="nu">Nữ</option>
                                                <c:if test="${employee.gender == false}">
                                                    selected
                                                </c:if>
                                            </select>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <div class="mb-3">
                                            <label class="form-label">Lương</label>
                                            <input name="salary" id="number" type="text" class="form-control"
                                                    value="${employee.salary}"
                                                   placeholder="VNĐ">
                                        </div>
                                    </div>

                                    <div class="col-md-12">
                                        <div class="mb-3">
                                            <label class="form-label">Mô tả</label>
                                            <textarea name="description" id="comments" rows="3" class="form-control"
                                                      placeholder="Bio :">${employee.description}</textarea>
                                        </div>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary">Lưu</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="../layout/footer.jsp"/>
    </main>
</div>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    function readURL(input, thumbimage) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $("#thumbimage").attr('src', e.target.result);
            }
            reader.readAsDataURL(input.files[0]);
        } else {
            $("#thumbimage").attr('src', input.value);
        }
        $("#thumbimage").show();
        $('.filename').text($("#uploadfile").val());
        $(".Choicefile").hide();
        $(".removeimg").show();
    }

    $(document).ready(function () {
        $(".Choicefile").bind('click', function () {
            $("#uploadfile").click();
        });
        $(".removeimg").click(function () {
            $("#thumbimage").attr('src', '').hide();
            $("#myfileupload").html('<input type="file" id="uploadfile"  onchange="readURL(this);" />');
            $(".removeimg").hide();
            $(".Choicefile").show();
            $(".filename").text("");
        });
    })
</script>
<script src="${pageContext.request.contextPath}/static/libs/simplebar/simplebar.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/feather-icons/feather.min.js"></script>
<script src="${pageContext.request.contextPath}/static/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugins.init.js"></script>
<script src="${pageContext.request.contextPath}/static/js/app.js"></script>
</body>
</html>