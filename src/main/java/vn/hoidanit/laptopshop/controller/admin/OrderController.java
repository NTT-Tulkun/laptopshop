package vn.hoidanit.laptopshop.controller.admin;

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

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.service.OrderService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OrderController {
    private final OrderService orderService;

    public OrderController(OrderService orderService) {
        this.orderService = orderService;
    }

    @GetMapping("/admin/order")
    public String getOrdersPage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if (pageOptional.isPresent()) {
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            // TODO: handle exception
        }
        Pageable pageable = PageRequest.of(page - 1, 5);
        Page<Order> pagelist = this.orderService.getListOrder(pageable);
        List<Order> listOrders = pagelist.getContent();
        model.addAttribute("listOrders", listOrders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", pagelist.getTotalPages());
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getDetailOrderPage(Model model, @PathVariable long id) {
        Optional<Order> order = this.orderService.getOrderById(id);
        if (order != null) {
            Order currentOrder = order.get();
            List<OrderDetail> listOrderDetail = currentOrder.getOrderDetails();
            model.addAttribute("listOD", listOrderDetail);
            model.addAttribute("id_order", id);
        }
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String updateOrderPage(Model model, @PathVariable long id) {
        Optional<Order> order = this.orderService.getOrderById(id);
        if (order != null) {
            Order currentOrder = order.get();
            model.addAttribute("updateOrder", currentOrder);
        }
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update")
    public String handleUpdateOrder(Model model, @ModelAttribute("updateOrder") Order currentOrder) {
        this.orderService.handleUpdateOrder(currentOrder);
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String deleteOrderPage(Model model, @PathVariable long id) {
        Optional<Order> order = this.orderService.getOrderById(id);
        if (order != null) {
            Order currentOrder = order.get();
            model.addAttribute("deleteOrder", currentOrder);
        }
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete")
    public String handleDeleteOrder(Model model, @ModelAttribute("deleteOrder") Order currentOrder) {
        this.orderService.handleDelete(currentOrder);
        return "redirect:/admin/order";
    }

}
