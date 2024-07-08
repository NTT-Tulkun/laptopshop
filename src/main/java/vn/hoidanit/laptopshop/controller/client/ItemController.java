package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.hoidanit.laptopshop.service.ProductService;
import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ItemController {
    private final ProductService productService;

    public ItemController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/product/{id}")
    public String getProductPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductyID(id).get();
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String addProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, session, 1);
        return "redirect:/";
    }

    @PostMapping("/add-product-form-view-detail")
    public String handleAddProductFromViewDetail(@RequestParam("id") long id,
            @RequestParam("quantity") long quantity,
            HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/product/" + id;
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.fetchCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetail();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("cart", cart);

        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id_cartDetail}")
    public String handleDeleteProductInCart(@PathVariable long id_cartDetail, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        this.productService.handleDeleteCartDetail(id_cartDetail, session);
        return "redirect:/cart";
    }

    @PostMapping("/confirm-checkout")
    public String postCheckoutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> ListCartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetail();
        this.productService.handleUpdateCartBeforeCheckout(ListCartDetails);
        return "redirect:/checkout";
    }

    @GetMapping("/checkout")
    public String getCheckoutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.fetchCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetail();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);
        return "client/cart/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {

        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);
        return "redirect:/thankyou";
    }

    @GetMapping("/thankyou")
    public String thankYouPage() {
        return "client/cart/thankyou";
    }

    // @GetMapping("/product")
    // public String getAllProduct(Model model,
    // @RequestParam("page") Optional<String> pageOptional,
    // @RequestParam("name") Optional<String> nameOptional,
    // @RequestParam("price") Optional<String> priceOptional,
    // @RequestParam("min-price") Optional<String> minPriceOptional,
    // @RequestParam("max-price") Optional<String> maxPriceOptional,
    // @RequestParam("factory") Optional<String> factoryOptional) {
    // int page = 1;
    // try {
    // if (pageOptional.isPresent()) {
    // page = Integer.parseInt(pageOptional.get());
    // } else {

    // }
    // } catch (Exception e) {
    // // TODO: handle exception
    // }

    // Pageable pageable = PageRequest.of(page - 1, 60);

    // // String name = nameOptional.isPresent() ? nameOptional.get() : "";
    // // Page<Product> pagelist =
    // this.productService.fetchProductWithSpec(pageable,
    // // name);

    // // double minPrice = minPriceOptional.isPresent() ?
    // // Double.parseDouble(minPriceOptional.get()) : 0;
    // // Page<Product> pagelist =
    // // this.productService.fetchProductWithMinPriceSpec(pageable, minPrice);

    // double maxPrice = maxPriceOptional.isPresent() ?
    // Double.parseDouble(maxPriceOptional.get()) : 0;
    // Page<Product> pagelist =
    // this.productService.fetchProductWithMaxPriceSpec(pageable, maxPrice);

    // // String factory = factoryOptional.isPresent() ? factoryOptional.get() : "";
    // // Page<Product> pagelist =
    // // this.productService.fetchProductWithFactorySpec(pageable, factory);

    // // List<String> factories = Arrays.asList(factoryOptional.get().split(","));
    // // Page<Product> pagelist =
    // // this.productService.fetchProductWithFactoiesSpec(pageable, factories);

    // // String price = priceOptional.isPresent() ? priceOptional.get() : "";
    // // Page<Product> pagelist =
    // // this.productService.fetchProductWithPriceSpec(pageable, price);

    // // List<String> priceMultiple =
    // Arrays.asList(priceOptional.get().split(","));
    // // Page<Product> pagelist =
    // // this.productService.fetchProductWithFactoiesSpec(pageable, priceMultiple);

    // List<Product> list = pagelist.getContent();

    // model.addAttribute("products", list);
    // model.addAttribute("currentPage", page);
    // model.addAttribute("totalPages", pagelist.getTotalPages());
    // return "client/product/show";
    // }

    @GetMapping("/product")
    public String getProductPage(Model model,
            ProductCriteriaDTO productCriteriaDTO) {
        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                // convert from String to int
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            } else {
                // page = 1
            }
        } catch (Exception e) {
            // page = 1
            // TODO: handle exception
        }

        Pageable pageable = PageRequest.of(page - 1, 60);
        Page<Product> prs = this.productService.fetchProductWithSpec(pageable, productCriteriaDTO);

        // String name = nameOptional.isPresent() ? nameOptional.get() : "";
        // Page<Product> prs = this.productService.fetchProductWithSpec(pageable, name);

        // case 1
        // double min = minOptional.isPresent() ? Double.parseDouble(minOptional.get())
        // : 0;
        // Page<Product> prs =
        // this.productService.fetchProductWithMinPriceSpec(pageable, min);

        // case 2
        // double max = minOptional.isPresent() ? Double.parseDouble(minOptional.get())
        // : 0;
        // Page<Product> prs =
        // this.productService.fetchProductWithMaxPriceSpec(pageable, max);

        // case 3
        // String factory = factoryOptional.isPresent() ? factoryOptional.get() : "";
        // Page<Product> prs = this.productService.fetchProductWithFactorySpec(pageable,
        // factory);

        // case 4
        // List<String> factory = Arrays.asList(factoryOptional.get().split(","));
        // Page<Product> prs =
        // this.productService.fetchProductWithFactoiesSpec(pageable, factory);

        // case 5
        // String price = priceOptional.isPresent() ? priceOptional.get() : "";
        // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
        // price);

        // case 6
        // List<String> price = Arrays.asList(priceOptional.get().split(","));
        // Page<Product> prs = this.productService.fetchProductsWithSpec(pageable,
        // price);

        List<Product> products = prs.getContent();

        model.addAttribute("products", products);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", prs.getTotalPages());
        return "client/product/show";
    }

}
