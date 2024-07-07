package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;
import vn.hoidanit.laptopshop.service.specification.ProductSpecs;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService,
            OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.productRepository = productRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.userService = userService;
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Product handleSaveProduct(Product pro) {
        return this.productRepository.save(pro);
    }

    public Page<Product> getListProduct(Pageable page) {
        return this.productRepository.findAll(page);
    }

    public Page<Product> fetchProductWithSpec(Pageable page, String name) {
        return this.productRepository.findAll(ProductSpecs.nameLike(name), page);
    }

    public Page<Product> fetchProductWithMinPriceSpec(Pageable page, double min_price) {
        return this.productRepository.findAll(ProductSpecs.minPrice(min_price), page);
    }

    public Page<Product> fetchProductWithMaxPriceSpec(Pageable page, double max_price) {
        return this.productRepository.findAll(ProductSpecs.maxPrice(max_price), page);
    }

    public Page<Product> fetchProductWithFactorySpec(Pageable page, String factory) {
        return this.productRepository.findAll(ProductSpecs.matchFactory(factory), page);
    }

    public Page<Product> fetchProductWithFactoiesSpec(Pageable page, List<String> factory) {
        return this.productRepository.findAll(ProductSpecs.matchFactories(factory), page);
    }

    public Page<Product> fetchProductWithPriceSpec(Pageable page, String price) {
        switch (price) {
            case "10-toi-15-trieu": {
                double min = 10000000;
                double max = 15000000;
                return this.productRepository.findAll(ProductSpecs.matchPrice(min, max), page);
            }

            case "15-toi-30-trieu": {
                double min = 15000000;
                double max = 30000000;
                return this.productRepository.findAll(ProductSpecs.matchPrice(min, max), page);
            }

            default:
                return this.productRepository.findAll(page);
        }
    }

    public Page<Product> fetchProductWithMultiplePriceSpec(Pageable page, List<String> price) {
        Specification<Product> combinedSpec = (root, query, criteriaBuilder) -> criteriaBuilder.disjunction();
        int count = 0;
        for (String p : price) {
            double min = 0;
            double max = 0;

            switch (p) {
                case "10-toi-15-trieu": {
                    min = 10000000;
                    max = 15000000;
                    count++;
                    break;
                }

                case "15-toi-30-trieu": {
                    min = 15000000;
                    max = 30000000;
                    count++;
                    break;
                }

                case "20-toi-30-trieu": {
                    min = 20000000;
                    max = 30000000;
                    count++;
                    break;
                }
            }
            if (min != 0 && max != 0) {
                Specification<Product> rangeSpec = ProductSpecs.matchMultiplePrice(min, max);
                combinedSpec = combinedSpec.or(rangeSpec);
            }
        }

        if (count == 0) {
            return this.productRepository.findAll(page);
        }

        return this.productRepository.findAll(combinedSpec, page);
    }

    public Optional<Product> getProductyID(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProductyID(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session, long quantity) {
        User user = this.userService.getUserByEmail(email);
        if (user != null) {
            Cart cart = this.cartRepository.findByUser(user);
            if (cart == null) {
                // Tạo mới
                Cart newCart = new Cart();
                newCart.setUser(user);
                newCart.setSum(0);
                cart = this.cartRepository.save(newCart);
            }

            // Lưu cart_Detail
            // Tìm product by id
            Optional<Product> pro = this.productRepository.findById(productId);
            if (pro.isPresent()) {
                Product realProduct = pro.get();
                // check sản phẩm đã từng thêm vào giỏ hàng trước đây chưa:
                CartDetail currentDetail = this.cartDetailRepository.findByCartAndProduct(cart, realProduct);
                if (currentDetail == null) {
                    CartDetail newCartDetail = new CartDetail();
                    newCartDetail.setCart(cart);
                    newCartDetail.setProduct(realProduct);
                    newCartDetail.setPrice(realProduct.getPrice());
                    newCartDetail.setQuantity(quantity);
                    this.cartDetailRepository.save(newCartDetail);
                    // update sum cho cart
                    int quantityProductCart = cart.getSum() + 1;
                    cart.setSum(quantityProductCart);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", quantityProductCart);
                } else {
                    currentDetail.setQuantity(currentDetail.getQuantity() + quantity);
                    this.cartDetailRepository.save(currentDetail);
                }

            }

        }
    }

    public Cart fetchCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }

    public void handleDeleteCartDetail(long id_cartDetail, HttpSession session) {
        Optional<CartDetail> cartDetailOptional = this.cartDetailRepository.findById(id_cartDetail);
        if (cartDetailOptional.isPresent()) {
            CartDetail cartDetail = cartDetailOptional.get();

            Cart currentCart = cartDetail.getCart();

            this.cartDetailRepository.deleteById(id_cartDetail);

            if (currentCart.getSum() > 1) {
                int sum = currentCart.getSum() - 1;
                currentCart.setSum(sum);
                session.setAttribute("sum", sum);
                this.cartRepository.save(currentCart);
            } else {
                // xoa cart (sum=1)
                this.cartRepository.deleteById(currentCart.getId());
                session.setAttribute("sum", 0);
            }
        }
    }

    public void handleUpdateCartBeforeCheckout(List<CartDetail> ListCartDetails) {
        for (CartDetail cartDetail : ListCartDetails) {
            Optional<CartDetail> cdOptional = this.cartDetailRepository.findById(cartDetail.getId());
            if (cdOptional.isPresent()) {
                CartDetail currentCartDetail = cdOptional.get();
                currentCartDetail.setQuantity(cartDetail.getQuantity());
                this.cartDetailRepository.save(currentCartDetail);
            }
        }
    }

    public void handlePlaceOrder(
            User user, HttpSession session,
            String receiverName, String receiverAddress, String receiverPhone) {

        // Bước 1: Lấy cart dựa vào user
        Cart cart = this.cartRepository.findByUser(user);
        if (cart != null) {
            List<CartDetail> listCartDetails = cart.getCartDetail();
            if (listCartDetails != null) {
                // Tạo 1 order
                Order order = new Order();
                order.setUser(user);
                order.setReceiverName(receiverName);
                order.setReceiverAddress(receiverAddress);
                order.setReceiverPhone(receiverPhone);
                order.setStatus("PENDING");

                double sumTotal = 0;
                for (CartDetail cartDetail : listCartDetails) {
                    sumTotal += cartDetail.getPrice() * cartDetail.getQuantity();
                }
                order.setTotalPrice(sumTotal);
                order = this.orderRepository.save(order);

                // Tạo 1 orderDetail
                for (CartDetail cartDetail : listCartDetails) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder(order);
                    orderDetail.setProduct(cartDetail.getProduct());
                    orderDetail.setQuantity(cartDetail.getQuantity());
                    orderDetail.setPrice(cartDetail.getPrice());
                    this.orderDetailRepository.save(orderDetail);
                }

                // Bước 2: xóa cartdetail and cart
                for (CartDetail cartDetail : listCartDetails) {
                    this.cartDetailRepository.deleteById(cartDetail.getId());
                }
                this.cartRepository.deleteById(cart.getId());

                // Bước 3: update session
                session.setAttribute("sum", 0);
            }

        }
    }
}
