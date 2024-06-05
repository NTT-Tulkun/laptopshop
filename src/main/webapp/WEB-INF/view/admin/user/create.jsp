<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Create user</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <!-- preview avatar -->
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        avatarFile.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });
                        });
                    });
                </script>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage User</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">User</li>
                                </ol>
                                <div>
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <form:form action="/admin/user/create" method="post"
                                                modelAttribute="newUser" class="row" enctype="multipart/form-data">
                                                <!-- newUser là biến được lấy từ model.addAttribute("newUser", newUser()); nạp vào model bên controller-->
                                                <h1>Create a User</h1>
                                                <hr>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <!--nếu như trường email này input lỗi thì biến errorEmailNotValid nhận giá
                                                    trị lỗi, ngược lại errorEmail=null-->
                                                    <c:set var="errorEmail">
                                                        <form:errors path="email" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Email</label>
                                                    <form:input path="email" type="email"
                                                        class="form-control ${not empty errorEmail ? 'is-invalid':''}" />
                                                    ${errorEmail}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <c:set var="errorPass">
                                                        <form:errors path="password" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Password</label>
                                                    <form:input path="password" type="text"
                                                        class="form-control ${not empty errorPass ? 'is-invalid':''}" />
                                                    ${errorPass}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <c:set var="errorPhone">
                                                        <form:errors path="phone" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Phone number</label>
                                                    <form:input path="phone" type="text"
                                                        class="form-control ${not empty errorPhone ? 'is-invalid':''}" />
                                                    ${errorPhone}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <c:set var="errorFullname">
                                                        <form:errors path="fullName" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Fullname</label>
                                                    <form:input path="fullName" type="text"
                                                        class="form-control ${not empty errorFullname ? 'is-invalid':''}" />
                                                    ${errorFullname}
                                                </div>

                                                <div class="mb-3">
                                                    <c:set var="errorAddress">
                                                        <form:errors path="address" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Address</label>
                                                    <form:input path="address" type="text"
                                                        class="form-control ${not empty errorAddress ? 'is-invalid':''}" />
                                                    ${errorAddress}
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Role</label>
                                                    <form:select class="form-select" path="role.name">
                                                        <!--role.name <=> đối tượng role khai báo trong User khi thực hiện nối quan hệ, name là thuộc tính của class Role -->
                                                        <!-- <form:option value="ADMIN">ADMIN</form:option>
                                                        <form:option value="USER">USER</form:option> -->
                                                        <c:forEach var="roles" items="${listRole}">
                                                            <form:option value="${roles.name}">${roles.name}
                                                            </form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="avatarFile" class="form-label">Avatar</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".jpg , .png, .jpeg" name="avatarFile">
                                                </div>

                                                <div class="mb-3 col-12">
                                                    <img alt="Avatar Preview" style="display: none; max-height: 250px;"
                                                        id="avatarPreview">
                                                </div>

                                                <div class="col-12 mb-5">
                                                    <button type="submit" class="btn btn-primary">Create</button>
                                                </div>
                                            </form:form>

                                            <!--
                                        Từng giá trị của path ở trên mỗi thẻ input của form phải đặt trùng với tên biến đã khai báo bên class User
                                        vd: path="fullName" <=> private String fullName;
                                        -->
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="/js/scripts.js"></script>
            </body>

            </html>