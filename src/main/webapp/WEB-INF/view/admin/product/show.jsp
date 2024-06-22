<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- Format price -->
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

            <body class="sb-nav-fixed d-flex flex-column min-vh-100">
                <jsp:include page="../layout/header.jsp" />
                <div id="layoutSidenav" class="d-flex">
                    <jsp:include page="../layout/sidebar.jsp" />
                    <div id="layoutSidenav_content" class="flex-grow-1 d-flex flex-column">
                        <main class="flex-grow-1">
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Product</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Product</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <div class="d-flex justify-content-between">
                                                <h3>Table Products</h3>
                                                <a href="/admin/product/create" class="btn btn-primary">Create new
                                                    product</a>
                                            </div>
                                            <hr>
                                            <table class="table table-bordered table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Name</th>
                                                        <th>Price</th>
                                                        <th>Factory</th>
                                                        <th>Acion</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="pro" items="${listProduct}">
                                                        <tr>
                                                            <td>${pro.id}</td>
                                                            <td>${pro.name}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number" value="${pro.price}" />đ
                                                            </td>
                                                            <td>${pro.factory}</td>
                                                            <td>
                                                                <a href="/admin/product/${pro.id}"
                                                                    class="btn btn-success">View</a>
                                                                <a href="/admin/product/update/${pro.id}"
                                                                    class="btn btn-warning">Update</a>
                                                                <a href="/admin/product/delete/${pro.id}"
                                                                    class="btn btn-danger">Delete</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <nav aria-label="Page navigation example">
                            <ul class="pagination justify-content-center">
                                <li class="page-item">
                                    <a class="${1 == currentPage ? 'disabled page-link':'page-link'}"
                                        href="/admin/product?page=${currentPage-1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="0" end="${totalPages-1}" varStatus="loop">
                                    <li class="page-item"><a
                                            class="${(loop.index+1) == currentPage ? 'active page-link':'page-link'}"
                                            href="/admin/product?page=${loop.index+1}">${loop.index+1}</a>
                                    </li>
                                </c:forEach>
                                <li class="page-item">
                                    <a class="${totalPages == currentPage ? 'disabled page-link':'page-link'}"
                                        href="/admin/product?page=${currentPage+1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                        <jsp:include page="../layout/footer.jsp" />
                    </div>
                </div>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                    crossorigin="anonymous"></script>
                <script src="js/scripts.js"></script>
            </body>

            </html>