package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;

@Controller
public class ProductController {

    private final UploadService uploadService;
    private final ProductService productService;

    public ProductController(UploadService uploadService, ProductService productService) {
        this.uploadService = uploadService;
        this.productService = productService;
    }

    @GetMapping("/admin/product")
    public String getProduct(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<Product> pagelist = this.productService.getListProduct(pageable);
        List<Product> list = pagelist.getContent();
        model.addAttribute("listProduct", list);

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pagelist.getTotalPages());
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getAddProductPage(Model model) {
        model.addAttribute("newProduct", new Product());
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String postAddProductPage(Model model, @ModelAttribute("newProduct") @Valid Product newPro,
            BindingResult newProBindingResult, @RequestParam("avatarFile") MultipartFile file) {

        if (newProBindingResult.hasErrors()) {
            return "admin/product/create";
        }
        String nameAvatarPro = this.uploadService.handleSaveUpLoadFile(file, "product");
        System.out.println(nameAvatarPro);
        newPro.setImage(nameAvatarPro);
        this.productService.handleSaveProduct(newPro);

        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/delete/{idpro}")
    public String getDeleteProductPage(Model model, @PathVariable long idpro) {
        Product deleteProduct = this.productService.getProductyID(idpro).get();
        model.addAttribute("deletePro", deleteProduct);
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete")
    public String postDeleteProduct(Model model, @ModelAttribute("newPro") Product deleteProduct) {
        this.productService.deleteProductyID(deleteProduct.getId());
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/update/{idpro}")
    public String getDeleteProduct(Model model, @PathVariable long idpro) {
        Product updateProduct = this.productService.getProductyID(idpro).get();
        model.addAttribute("updatePro", updateProduct);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update")
    public String postDeleteProduct(
            Model model,
            @ModelAttribute("updatePro") @Valid Product updateProduct,
            BindingResult bindingResult,
            @RequestParam("avatarFile") MultipartFile file) {

        if (bindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Optional<Product> currentPro = this.productService.getProductyID(updateProduct.getId());
        Product currentProduct = currentPro.get();
        if (currentProduct != null) {
            if (!file.isEmpty()) {
                String img = this.uploadService.handleSaveUpLoadFile(file, "product");
                currentProduct.setImage(img);
            }
            currentProduct.setName(updateProduct.getName());
            currentProduct.setPrice(updateProduct.getPrice());
            currentProduct.setDetailDesc(updateProduct.getDetailDesc());
            currentProduct.setShortDesc(updateProduct.getShortDesc());
            currentProduct.setQuantity(updateProduct.getQuantity());
            currentProduct.setFactory(updateProduct.getFactory());
            currentProduct.setTarget(updateProduct.getTarget());
            this.productService.handleSaveProduct(currentProduct);
        }
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{idpro}")
    public String getViewDetailProduct(Model model, @PathVariable long idpro) {
        Product pro = this.productService.getProductyID(idpro).get();
        model.addAttribute("infProduct", pro);
        return "admin/product/detail";
    }

}
