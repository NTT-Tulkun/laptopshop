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
                <title>Update user</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const avatarFile = $("#avatarFile");
                        const orgAvatar = "${updateUser.avatar}";
                        if (orgAvatar) {
                            const urlAvatar = "/images/avatar/" + orgAvatar;
                            $("#avatarPreview").attr("src", urlAvatar);
                            $("#avatarPreview").css({ "display": "block" });
                        }

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
                                    <li class="breadcrumb-item active"><a href="/admin/user">User</a></li>
                                    <li class="breadcrumb-item active">Update</li>
                                </ol>
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <form:form action="/admin/user/update" method="post"
                                                modelAttribute="updateUser" enctype="multipart/form-data">
                                                <h1>Update User</h1>
                                                <hr>

                                                <div class="mb-3" style="display: none;">
                                                    <label for="" class="form-label">ID</label>
                                                    <form:input path="id" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <c:set var="errorEmail">
                                                        <form:errors path="email" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Email</label>
                                                    <form:input path="email" type="email"
                                                        class="form-control ${not empty errorEmail ? 'is-invalid':''}"
                                                        disabled="true" />
                                                    ${errorEmail}
                                                </div>

                                                <div class="mb-3">
                                                    <c:set var="errorPhone">
                                                        <form:errors path="phone" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label for="" class="form-label">Phone number</label>
                                                    <form:input path="phone" type="text"
                                                        class="form-control ${not empty errorPhone ? 'is-invalid':''}" />
                                                    ${errorPhone}
                                                </div>

                                                <div class="mb-3">
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

                                                <div class="mb-3">
                                                    <label class="form-label">Role</label>
                                                    <form:select class="form-select" path="role.name">
                                                        <!--role.name <=> đối tượng role khai báo trong User khi thực hiện nối quan hệ, name là thuộc tính của class Role -->
                                                        <form:option value="ADMIN">ADMIN</form:option>
                                                        <form:option value="USER">USER</form:option>
                                                    </form:select>
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="avatarFile" class="form-label">Avatar update</label>
                                                    <input class="form-control" type="file" id="avatarFile"
                                                        accept=".jpg , .png, .jpeg" name="avatarFile">
                                                    <form:input path="avatar" type="text" style="display: none;" />
                                                </div>

                                                <div class="mb-3 col-12">
                                                    <img alt="Avatar Preview" style="display: none; max-height: 250px;"
                                                        id="avatarPreview">
                                                </div>

                                                <button type="submit" class="btn btn-warning">Update</button>
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