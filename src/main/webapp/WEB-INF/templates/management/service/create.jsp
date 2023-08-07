<%--
  Created by IntelliJ IDEA.
  User: Huyen Nguyen
  Date: 6/21/2023
  Time: 7:21 PM
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
        <div class="tab-content" >
          <div class="card border-0 shadow overflow-hidden">
            <div class="tab-content p-4" id="pills-tabContent">

              <form  method="POST" action="/management/service/create">
                <div class="row">
                  <div>
                    <p class="text-muted">Cập nhật ảnh Dịch vụ</p>
                    <div id="myfileupload">
                      <input type="file" name="image" id="uploadfile" name="ImageUpload" onchange="readURL(this);" />
                    </div>
                    <div id="thumbbox">
                      <img class="rounded" height="20%" width="30%" alt="Thumb image" id="thumbimage" style="display: none" />
                      <a class="removeimg" href="javascript:"></a>
                    </div>
                    <div id="boxchoice">
                      <a href="javascript:" class="Choicefile"><i class="fas fa-cloud-upload-alt"></i> Chọn ảnh</a>
                      <p style="clear:both"></p>
                    </div>
                  </div>
                  <div class="col-lg-12">
                    <div class="mb-3">
                      <label class="form-label">Tên dịch vụ</label>
                      <input name="name" type="text" class="form-control" >
                    </div>
                  </div>
                  <div class="col-lg-12">
                    <div class="mb-3">
                      <label class="form-label" >Mô tả</label>
                      <br>
                      <textarea class="form-control" id="description" name="description" type="text" rows="5" cols="33" ></textarea>
                    </div>
                  </div>
                </div>

                <div class="row">
                  <div class="col-sm-12">
                    <input type="submit" id="submit" name="send" class="btn btn-primary"
                           value="Thêm mới">
                  </div>
                </div>
              </form>
            </div>
          </div>
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
</body>
<style>
  .Choicefile{
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


