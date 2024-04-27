package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        String test = this.userService.handleHello();
        model.addAttribute("eric", test);
        model.addAttribute("hoidanit", "hello from controller");

        return "hello";
    }

    @RequestMapping("admin/user")
    public String getAddUserPage(Model model) {
        model.addAttribute("newUser", new User()); // new User() là contractor được tọa tự động bên domain
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUserPage(Model model, @ModelAttribute("newUser") User hoidanit) {
        // newUser <=> modelAttribute="newUser" trong form
        System.out.println("run here" + hoidanit);
        return "hello";
    }
}
