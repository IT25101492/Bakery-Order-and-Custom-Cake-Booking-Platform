package com.bakery.Usermanagement.controller;

import com.bakery.Usermanagement.dao.AdminDAO;
import com.bakery.Usermanagement.dao.UserDAO;
import com.bakery.Usermanagement.model.AdminUser;
import com.bakery.Usermanagement.model.RegularCustomer;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthController {

    @Autowired
    private UserDAO userDAO;
    @Autowired
    private AdminDAO adminDAO;

    // Customer Login - Show Form
    @GetMapping("/login")
    public String showCustomerLogin(Model model) {
        model.addAttribute("isAuthPage", true);
        model.addAttribute("contentPage", "customer/login.jsp");
        model.addAttribute("pageTitle", "Sign In");
        return "layout";
    }

    // Home redirect
    @GetMapping("/")
    public String index() {
        return "redirect:/login";
    }

    // Customer Login - Process
    @PostMapping("/login")
    public String handleCustomerLogin(@RequestParam String loginIdentifier,
                                      @RequestParam String password,
                                      HttpSession session, Model model) {
        RegularCustomer customer = userDAO.getCustomerByUsername(loginIdentifier);
        if (customer == null) {
            customer = userDAO.getCustomerByEmail(loginIdentifier);
        }

        if (customer != null && customer.authenticate(password)) {
            if (!customer.isActive()) {
                model.addAttribute("errorMessage", "Account deactivated.");
                model.addAttribute("isAuthPage", true);
                model.addAttribute("contentPage", "customer/login.jsp");
                model.addAttribute("pageTitle", "Sign In");
                return "layout";
            }
            session.setAttribute("customerId", customer.getUserId());
            session.setAttribute("customerUsername", customer.getUsername());
            session.setAttribute("userRole", "CUSTOMER");
            return "redirect:/dashboard";
        }

        model.addAttribute("errorMessage", "Invalid credentials.");
        model.addAttribute("isAuthPage", true);
        model.addAttribute("contentPage", "customer/login.jsp");
        model.addAttribute("pageTitle", "Sign In");
        return "layout";
    }

    // Admin Login - Show Form
    @GetMapping("/admin/login")
    public String showAdminLogin(Model model) {
        model.addAttribute("isAuthPage", true);
        model.addAttribute("contentPage", "admin/login.jsp");
        model.addAttribute("pageTitle", "Admin Sign In");
        return "layout";
    }

    // Admin Login - Process
    @PostMapping("/admin/login")
    public String handleAdminLogin(@RequestParam String loginIdentifier,
                                   @RequestParam String password,
                                   HttpSession session, Model model) {
        AdminUser admin = adminDAO.getAdminByUsername(loginIdentifier);
        if (admin == null) {
            admin = adminDAO.getAdminByEmail(loginIdentifier);
        }

        if (admin != null && admin.authenticate(password)) {
            session.setAttribute("adminId", admin.getUserId());
            session.setAttribute("adminUsername", admin.getUsername());
            session.setAttribute("department", admin.getDepartment());
            session.setAttribute("adminLevel", admin.getAdminLevel());
            session.setAttribute("userRole", "ADMIN");
            return "redirect:/admin/dashboard";
        }

        model.addAttribute("errorMessage", "Access Denied.");
        model.addAttribute("isAuthPage", true);
        model.addAttribute("contentPage", "admin/login.jsp");
        model.addAttribute("pageTitle", "Admin Sign In");
        return "layout";
    }

    // Logout
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}