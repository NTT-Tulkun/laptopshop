package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpSession;
import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.CartDetailRepository;
import vn.hoidanit.laptopshop.repository.CartRepository;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;
    private final CartRepository cartRepository;
    private final CartDetailRepository cartDetailRepository;
    private final UserService userService;

    public ProductService(ProductRepository productRepository, CartRepository cartRepository,
            CartDetailRepository cartDetailRepository, UserService userService) {
        this.productRepository = productRepository;
        this.cartDetailRepository = cartDetailRepository;
        this.cartRepository = cartRepository;
        this.userService = userService;
    }

    public Product handleSaveProduct(Product pro) {
        return this.productRepository.save(pro);
    }

    public List<Product> getListProduct() {
        return this.productRepository.findAll();
    }

    public Optional<Product> getProductyID(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProductyID(long id) {
        this.productRepository.deleteById(id);
    }

    public void handleAddProductToCart(String email, long productId, HttpSession session) {
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
                    newCartDetail.setQuantity(1);
                    this.cartDetailRepository.save(newCartDetail);
                    // update sum cho cart
                    int quantityProductCart = cart.getSum() + 1;
                    cart.setSum(quantityProductCart);
                    this.cartRepository.save(cart);
                    session.setAttribute("sum", quantityProductCart);
                } else {
                    currentDetail.setQuantity(currentDetail.getQuantity() + 1);
                    this.cartDetailRepository.save(currentDetail);
                }

            }

        }
    }

    public Cart fetchCartByUser(User user) {
        return this.cartRepository.findByUser(user);
    }
}
