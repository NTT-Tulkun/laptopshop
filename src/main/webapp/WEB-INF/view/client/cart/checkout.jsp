<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <!-- Format price -->
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <title>Cart details</title>
                    <meta content="width=device-width, initial-scale=1.0" name="viewport">
                    <meta content="" name="keywords">
                    <meta content="" name="description">

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">
                </head>

                <body>

                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />
                    <!-- Modal Search Start -->
                    <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel"
                        aria-hidden="true">
                        <div class="modal-dialog modal-fullscreen">
                            <div class="modal-content rounded-0">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button>
                                </div>
                                <div class="modal-body d-flex align-items-center">
                                    <div class="input-group w-75 mx-auto d-flex">
                                        <input type="search" class="form-control p-3" placeholder="keywords"
                                            aria-describedby="search-icon-1">
                                        <span id="search-icon-1" class="input-group-text p-3"><i
                                                class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </div>
                        </div>Search by keyword
                    </div>
                    <!-- Modal Search End -->

                    <!-- Cart Page Start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="mb-3">
                                <nav aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/">Home</a></li>
                                        <li class="breadcrumb-item active" aria-current="page">Payment information</li>
                                    </ol>
                                </nav>
                            </div>
                            <div class="table-responsive">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th scope="col">Products</th>
                                            <th scope="col">Name</th>
                                            <th scope="col">Price</th>
                                            <th scope="col">Quantity</th>
                                            <th scope="col">Total</th>
                                            <th scope="col">Handle</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${empty cartDetails}">
                                            <tr class="text-center mt-4">
                                                <td colspan="6" class="text-success fs-4">You don't have any products in
                                                    your cart yet!</td>
                                            </tr>
                                        </c:if>
                                        <c:if test="${not empty cartDetails}">
                                            <c:forEach var="cartDetail" items="${cartDetails}" varStatus="status">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="d-flex align-items-center">
                                                            <a href="/product/${cartDetail.product.id}" target="_blank">
                                                                <img src="/images/product/${cartDetail.product.image}"
                                                                    class="img-fluid me-5 rounded-circle"
                                                                    style="width: 80px; height: 80px;" alt="">
                                                            </a>
                                                        </div>
                                                    </th>
                                                    <td>
                                                        <a href="/product/${cartDetail.product.id}" target="_blank">
                                                            <p class="mb-0 mt-4">${cartDetail.product.name}</p>
                                                        </a>

                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber type="number"
                                                                value="${cartDetail.price}" />đ
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <div class="input-group quantity mt-4" style="width: 100px;">
                                                            <input type="text"
                                                                class="form-control form-control-sm text-center border-0"
                                                                value="${cartDetail.quantity}"
                                                                data-cart-detail-id="${cartDetail.id}"
                                                                data-cart-detail-price="${cartDetail.price}"
                                                                data-cart-detail-index="${status.index}">
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4" data-cart-detail-id="${cartDetail.id}">
                                                            <fmt:formatNumber type="number"
                                                                value="${cartDetail.quantity * cartDetail.price}" />đ
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <form action="/delete-cart-product/${cartDetail.id}"
                                                            method="post">
                                                            <div>
                                                                <input type="hidden" name="${_csrf.parameterName}"
                                                                    value="${_csrf.token}" />
                                                            </div>
                                                            <button
                                                                class="btn btn-md rounded-circle bg-light border mt-4">
                                                                <i class="fa fa-times text-danger"></i>
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <!-- Cart Page End -->


                    <!-- Checkout Page Start -->
                    <div class="container-fluid py-3">
                        <div class="container py-3">
                            <form:form action="/place-order" method="post" modelAttribute="cart">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <div class="row g-4 justify-content-start">
                                    <div class="col-md-6 col-12">
                                        <h1 class="mb-4">Receiver's information</h1>
                                        <div class="form-item">
                                            <label class="form-label my-3">Recipient's full name<sup>*</sup></label>
                                            <input class="form-control" name="receiverName" required />
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Recipient's address <sup>*</sup></label>
                                            <input class="form-control" name="receiverAddress" required />
                                        </div>
                                        <div class="form-item">
                                            <label class="form-label my-3">Recipient's phone number <sup>*</sup></label>
                                            <input class="form-control" name="receiverPhone" required />
                                        </div>
                                        <div class="mt-4">
                                            <i class="fas fa-arrow-left"></i>
                                            <a href="/cart">Return to cart</a>
                                        </div>
                                    </div>
                                    <div class="col-md-6 col-12">
                                        <h1 class="mb-4">Receiver's information</h1>
                                        <div class="table-responsive">
                                            <table class="table">
                                                <tbody>
                                                    <tr>
                                                        <th scope="row">
                                                        </th>
                                                        <td>
                                                            <p class="mb-0 text-dark text-uppercase py-3">Transport fee
                                                            </p>
                                                        </td>

                                                        <td class="py-5"></td>
                                                        <td>
                                                            <div class="py-3">
                                                                <p class="mb-0 text-dark">0đ</p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                        </th>
                                                        <td>
                                                            <p class="mb-0 text-dark text-uppercase py-3">form of
                                                                transportation</p>
                                                        </td>

                                                        <td class="py-5"></td>
                                                        <td>
                                                            <div class="py-3">
                                                                <p class="mb-0 text-dark">Payment on delivery (COD)</p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <th scope="row">
                                                        </th>
                                                        <td>
                                                            <p class="mb-0 text-dark text-uppercase py-3">TOTAL</p>
                                                        </td>

                                                        <td class="py-5"></td>
                                                        <td>
                                                            <div class="py-3">
                                                                <p class="mb-0 text-dark">
                                                                    <fmt:formatNumber type="number"
                                                                        value="${totalPrice}" />đ
                                                                </p>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <button
                                                class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">
                                                Payment confirmation
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form:form>
                        </div>
                    </div>
                    <!-- Checkout Page End -->

                    <jsp:include page="../layout/footer.jsp" />

                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                </body>

                </html>