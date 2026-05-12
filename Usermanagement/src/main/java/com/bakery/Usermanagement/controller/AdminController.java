package com.bakery.Usermanagement.controller;

import com.bakery.Usermanagement.dao.UserDAO;
import com.bakery.Usermanagement.dao.AdminDAO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin") // All routes start with /admin
public class AdminController {

    @Autowired
    private AdminDAO adminDAO;

    @Autowired
    private UserDAO userDAO;

    // READ: Admin Dashboard Stats
    @GetMapping("/dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";

        model.addAttribute("totalCustomers", adminDAO.getTotalCustomerCount());
        model.addAttribute("newCustomersToday", adminDAO.getNewCustomersToday());
        return "admin/dashboard";
    }

    // READ: Customer List with Search functionality
    @GetMapping("/customers")
    public String listCustomers(@RequestParam(required = false) String search, 
                                HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";

        if (search != null && !search.isEmpty()) {
            model.addAttribute("customers", userDAO.searchCustomers(search));
            model.addAttribute("searchTerm", search);
        } else {
            model.addAttribute("customers", userDAO.getAllCustomers());
        }
        return "admin/customer-management";
    }

    // DELETE: Remove customer account
    @GetMapping("/customers/delete/{id}")
    public String deleteCustomer(@PathVariable int id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";

        userDAO.deleteCustomer(id);
        return "redirect:/admin/customers?successMessage=Customer deleted successfully";
    }
}