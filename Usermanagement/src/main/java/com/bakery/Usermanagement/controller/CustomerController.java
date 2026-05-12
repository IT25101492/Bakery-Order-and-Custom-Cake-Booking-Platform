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

    // CREATE: Show Registration Form
    @GetMapping("/register")
    public String showRegister() {
        return "customer/register";
    }

    // CREATE: Process Registration
    @PostMapping("/register")
    public String register(@ModelAttribute RegularCustomer newCustomer, 
                           @RequestParam String confirmPassword, Model model) {
        // Validation (Encapsulation logic inside Model/DAO)
        if (!newCustomer.getPassword().equals(confirmPassword)) {
            model.addAttribute("errorMessage", "Passwords do not match.");
            return "customer/register";
        }
        if (userDAO.isUsernameExists(newCustomer.getUsername())) {
            model.addAttribute("errorMessage", "Username already taken.");
            return "customer/register";
        }

        userDAO.registerCustomer(newCustomer);
        return "redirect:/login?registered=true";
    }

    // READ: View Dashboard
    @GetMapping("/dashboard")
    public String showDashboard(HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) return "redirect:/login";

        RegularCustomer customer = userDAO.getCustomerById(customerId);
        model.addAttribute("customer", customer);
        return "customer/dashboard";
    }

    // READ: Show Profile Update Page
    @GetMapping("/profile")
    public String showProfile(HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        if (customerId == null) return "redirect:/login";

        model.addAttribute("customer", userDAO.getCustomerById(customerId));
        return "customer/profile";
    }

    // UPDATE: Modify customer details
    @PostMapping("/profile")
    public String updateProfile(@ModelAttribute RegularCustomer updatedData, 
                                @RequestParam(required = false) String newPassword,
                                HttpSession session, Model model) {
        Integer customerId = (Integer) session.getAttribute("customerId");
        RegularCustomer existing = userDAO.getCustomerById(customerId);

        // Encapsulation: update only allowed fields
        existing.setEmail(updatedData.getEmail());
        existing.setPhoneNumber(updatedData.getPhoneNumber());
        existing.setDeliveryAddress(updatedData.getDeliveryAddress());

        if (newPassword != null && !newPassword.isEmpty()) {
            if (User.isValidPassword(newPassword)) {
                existing.setPassword(newPassword);
            } else {
                model.addAttribute("errorMessage", "Weak password.");
                model.addAttribute("customer", existing);
                return "customer/profile";
            }
        }

        userDAO.updateCustomer(existing);
        model.addAttribute("successMessage", "Profile updated!");
        model.addAttribute("customer", existing);
        return "customer/profile";
    }
}