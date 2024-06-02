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
                <title>Dashboard - Hỏi Dân IT</title>
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
                                <h1 class="mt-4">Manage Product</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Product</li>
                                </ol>
                                <div>
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <form:form action="/admin/product/create" method="post"
                                                modelAttribute="newProduct" class="row" enctype="multipart/form-data">
                                                <h1>Create a Product</h1>
                                                <hr>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="" class="form-label">Name</label>
                                                    <form:input path="name" type="email" class="form-control" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="" class="form-label">Price</label>
                                                    <form:input path="price" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3">
                                                    <label for="" class="form-label">Details description</label>
                                                    <form:textarea type="text" class="form-control" path="detailDesc" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="" class="form-label">Short description</label>
                                                    <form:input path="shortDesc" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label for="" class="form-label">Quantity</label>
                                                    <form:input path="quantity" type="text" class="form-control" />
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Factory</label>
                                                    <form:select class="form-select" path="factory">
                                                        <form:option value="Asus">Asus</form:option>
                                                        <form:option value="Dell">Dell</form:option>
                                                    </form:select>
                                                </div>

                                                <div class="mb-3 col-12 col-md-6">
                                                    <label class="form-label">Target</label>
                                                    <form:select class="form-select" path="target">
                                                        <form:option value="Gaming">Gaming</form:option>
                                                        <form:option value="Nhân viên văn phòng">Nhân viên văn phòng
                                                        </form:option>
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