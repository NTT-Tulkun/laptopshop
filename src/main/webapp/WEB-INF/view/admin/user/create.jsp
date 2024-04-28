<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Add User</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            </head>

            <body>
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <form:form action="/admin/user/create" method="post" modelAttribute="newUser">
                                <!-- newUser là biến được lấy từ model.addAttribute("newUser", newUser()); nạp vào model bên controller-->
                                <h1>Create a User</h1>
                                <hr>

                                <div class="mb-3">
                                    <label for="" class="form-label">Email</label>
                                    <form:input path="email" type="email" class="form-control" />
                                </div>

                                <div class="mb-3">
                                    <label for="" class="form-label">Password</label>
                                    <form:input path="password" type="text" class="form-control" />
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

                                <button type="submit" class="btn btn-primary">Create</button>
                            </form:form>

                            <!-- 
                            Từng giá trị của path ở trên mỗi thẻ input của form phải đặt trùng với tên biến đã khai báo bên class User
                            vd: path="fullName" <=> private String fullName;
                            -->
                        </div>
                    </div>
                </div>
            </body>

            </html>