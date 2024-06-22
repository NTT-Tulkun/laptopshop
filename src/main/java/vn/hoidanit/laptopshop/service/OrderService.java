package vn.hoidanit.laptopshop.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.repository.OrderDetailRepository;
import vn.hoidanit.laptopshop.repository.OrderRepository;

@Service
public class OrderService {
    private final OrderRepository orderRepository;
    private final OrderDetailRepository orderDetailRepository;

    public OrderService(OrderRepository orderRepository, OrderDetailRepository orderDetailRepository) {
        this.orderRepository = orderRepository;
        this.orderDetailRepository = orderDetailRepository;
    }

    public Page<Order> getListOrder(Pageable pageable) {
        return this.orderRepository.findAll(pageable);
    }

    public Optional<Order> getOrderById(long id) {
        return this.orderRepository.findById(id);
    }

    public List<Order> fetchListOrder(User uer) {
        return this.orderRepository.findByUser(uer);
    }

    public void handleUpdateOrder(Order updateOrder) {
        Optional<Order> orderOptional = this.orderRepository.findById(updateOrder.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            currentOrder.setStatus(updateOrder.getStatus());
            this.orderRepository.save(currentOrder);
        }
    }

    public void handleDelete(Order order) {
        Optional<Order> orderOptional = this.orderRepository.findById(order.getId());
        if (orderOptional.isPresent()) {
            Order currentOrder = orderOptional.get();
            List<OrderDetail> listOD = currentOrder.getOrderDetails();
            for (OrderDetail od : listOD) {
                this.orderDetailRepository.deleteById(od.getId());
            }
            this.orderRepository.deleteById(currentOrder.getId());
        }
    }
}
