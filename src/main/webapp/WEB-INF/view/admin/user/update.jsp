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
                                <div class="container mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <form:form action="/admin/user/update" method="post"
                                                modelAttribute="updateUser">
                                                <!-- newUser là biến được lấy từ model.addAttribute("newUser", newUser()); nạp vào model bên controller-->
                                                <h1>Update User</h1>
                                                <hr>

                                                <div class="mb-3" style="display: none;">
                                                    <label for="" class="form-label">ID</label>
                                                    <form:input path="id" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <label for="" class="form-label">Email</label>
                                                    <form:input path="email" type="email" class="form-control"
                                                        disabled="true" />
                                                </div>

                                                <div class="mb-3">
                                                    <label for="" class="form-label">Phone number</label>
                                                    <form:input path="phone" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <label for="" class="form-label">Fullname</label>
                                                    <form:input path="fullName" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <label for="" class="form-label">Address</label>
                                                    <form:input path="address" type="text" class="form-control" />
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
                <script src="js/scripts.js"></script>
            </body>

            </html>