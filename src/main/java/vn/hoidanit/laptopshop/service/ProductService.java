package vn.hoidanit.laptopshop.service;

import java.util.List;
import org.springframework.stereotype.Service;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.repository.ProductRepository;

@Service
public class ProductService {
    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Product handleSaveProduct(Product pro) {
        return this.productRepository.save(pro);
    }

    public List<Product> getListProduct() {
        return this.productRepository.findAll();
    }

    public Product getProductyID(long id) {
        return this.productRepository.findById(id);
    }

    public void deleteProductyID(long id) {
        this.productRepository.deleteById(id);
    }
}
