<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- Format price -->
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                    <meta name="author" content="Hỏi Dân IT" />
                    <title>Dashboard - Hỏi Dân IT</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4">Manage Orders</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item"><a href="/admin/order">Order</a></li>
                                        <li class="breadcrumb-item active">Update order</li>
                                    </ol>
                                    <div>
                                        <div class="row">
                                            <div class="col-md-6 col-12 mx-auto">
                                                <form:form action="/admin/order/update" method="post"
                                                    modelAttribute="updateOrder" class="row"
                                                    enctype="multipart/form-data">
                                                    <h1>Update a Product</h1>
                                                    <hr>

                                                    <div class="mb-3 col-12 col-md-6" style="display: none;">
                                                        <label for="" class="form-label">ID</label>
                                                        <form:input path="id" type="text" class="form-control" />
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="" class="form-label">Order ID:
                                                            ${updateOrder.id}</label>
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="" class="form-label">Price:
                                                            <fmt:formatNumber type="number"
                                                                value="${updateOrder.totalPrice}" />đ
                                                        </label>
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label for="" class="form-label">User</label>
                                                        <form:input path="user.fullName" type="text"
                                                            class="form-control" readonly="true" />
                                                    </div>

                                                    <div class="mb-3 col-12 col-md-6">
                                                        <label class="form-label">Status</label>
                                                        <form:select class="form-select" path="status">
                                                            <form:option value="PENDING">PENDING</form:option>
                                                            <form:option value="SHIPPING">SHIPPING</form:option>
                                                            <form:option value="COMPLETED">COMPLETED</form:option>
                                                            <form:option value="CANCEL">CANCEL</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="col-12 mb-5">
                                                        <button type="submit" class="btn btn-primary">Update</button>
                                                    </div>
                                                </form:form>
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