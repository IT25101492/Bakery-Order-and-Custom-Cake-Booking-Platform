package com.bakery.Usermanagement.controller;

import com.bakery.Usermanagement.dao.UserDAO;
import com.bakery.Usermanagement.model.RegularCustomer;
import com.bakery.Usermanagement.model.User;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class CustomerController {

    @Autowired
    private UserDAO userDAO;

    //Shows Registration Form
    @GetMapping("/register")
    public String showRegister(Model model) {
        model.addAttribute("isAuthPage", true);
        model.addAttribute("contentPage", "customer/register.jsp");
        model.addAttribute("pageTitle", "Create Account");
        return "layout";
    }

    //Registration Process
    @PostMapping("/register")
    public String register(@ModelAttribute RegularCustomer newCustomer,
                           @RequestParam String confirmPassword, Model model) {
        if (!newCustomer.getPassword().equals(confirmPassword)) {
            model.addAttribute("errorMessage", "Passwords do not match.");
            model.addAttribute("isAuthPage", true);
            model.addAttribute("contentPage", "customer/register.jsp");
            model.addAttribute("pageTitle", "Create Account");
            return "layout";
        }
        if (userDAO.isUsernameExists(newCustomer.getUsername())) {
            model.addAttribute("errorMessage", "Username already taken.");
            model.addAttribute("isAuthPage", true);
            model.addAttribute("contentPage", "customer/register.jsp");
            model.addAttribute("pageTitle", "Create Account");
            return "layout";
        }
        userDAO.registerCustomer(newCustomer);
        return "redirect:/login?registered=true";
    }

    //View Dashboard
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) return "redirect:/login";
        RegularCustomer customer = userDAO.getCustomerById(customerId);
        model.addAttribute("contentPage", "customer/dashboard.jsp");
        model.addAttribute("pageTitle", "Dashboard");
        model.addAttribute("customer", customer);
        return "layout";
    }

    //Shows Profile Update Page
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) return "redirect:/login";
        model.addAttribute("contentPage", "customer/profile.jsp");
        model.addAttribute("pageTitle", "My Profile");
        model.addAttribute("customer", userDAO.getCustomerById(customerId));
        return "layout";
    }

    //Modifying customer details
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute RegularCustomer updatedData,
                                @RequestParam(required = false) String newPassword,
                                HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) return "redirect:/login";
        RegularCustomer existing = userDAO.getCustomerById(customerId);
        if (existing == null) return "redirect:/login";

        existing.setEmail(updatedData.getEmail());
        existing.setPhoneNumber(updatedData.getPhoneNumber());
        existing.setDeliveryAddress(updatedData.getDeliveryAddress());
        if (newPassword != null && !newPassword.isEmpty()) {
            if (User.isValidPassword(newPassword)) {
                existing.setPassword(newPassword);
            } else {
                model.addAttribute("errorMessage", "Weak password.");
                model.addAttribute("contentPage", "customer/profile.jsp");
                model.addAttribute("pageTitle", "My Profile");
                model.addAttribute("customer", existing);
                return "layout";
            }
        }
        userDAO.updateCustomer(existing);
        model.addAttribute("successMessage", "Profile updated!");
        model.addAttribute("contentPage", "customer/profile.jsp");
        model.addAttribute("pageTitle", "My Profile");
        model.addAttribute("customer", existing);
        return "layout";
    }
}
