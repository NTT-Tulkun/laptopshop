package vn.hoidanit.laptopshop.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UserService;

@Controller
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @RequestMapping("/")
    public String getHomePage(Model model) {
        List<User> arrUser = this.userService.getAllUserByEmail("3@gmail.com");
        System.out.println(arrUser);
        model.addAttribute("eric", "test");
        model.addAttribute("hoidanit", "hello from controller");
        return "hello";
    }

    @RequestMapping("/admin/user")
    public String getUserPage(Model model) {
        List<User> users = this.userService.getAllUsers();
        System.out.println(users);
        model.addAttribute("users1", users);
        return "admin/user/table-user";
    }

    @RequestMapping("/admin/user/create") // mặc định method = RequestMethod.GET
    public String getAddUserPage(Model model) {
        model.addAttribute("newUser", new User()); // new User() là contractor được tạo tự động bên domain
        return "admin/user/create";
    }

    @RequestMapping(value = "/admin/user/create", method = RequestMethod.POST)
    public String createUserPage(Model model, @ModelAttribute("newUser") User hoidanit) {
        // newUser <=> modelAttribute="newUser" trong form
        this.userService.handleSaveUser(hoidanit);
        return "redirect:/admin/user"; // nó sẽ GET mapping lại hàm getUserPage
    }
}
