package vn.hoidanit.laptopshop.domain;

import java.util.List;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;

@Entity
@Table(name = "carts")
public class Cart {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Min(value = 0)
    private int sum;

    // user_id
    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    // cartDetail_id
    @OneToMany(mappedBy = "cart")
    private List<CartDetail> cartDetail;

    public long getId() {
        return id;
    }

    public int getSum() {
        return sum;
    }

    public User getUser() {
        return user;
    }

    public void setId(long id) {
        this.id = id;
    }

    public void setSum(int sum) {
        this.sum = sum;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<CartDetail> getCartDetail() {
        return cartDetail;
    }

    public void setCartDetail(List<CartDetail> cartDetail) {
        this.cartDetail = cartDetail;
    }

    @Override
    public String toString() {
        return "Cart [id=" + id + ", sum=" + sum + ", user=" + user + ", cartDetail=" + cartDetail + "]";
    }

}
