package com.bakery.Usermanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bakery.Usermanagement.dao.AdminDAO;
import com.bakery.Usermanagement.dao.UserDAO;
import com.bakery.Usermanagement.model.RegularCustomer;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin") 
public class AdminController {

    @Autowired
    private AdminDAO adminDAO; // DAO abstraction for admin-related database operations

    @Autowired
    private UserDAO userDAO;


    //Admin Dashboard Stats
    @GetMapping("/dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {

        // Role-based access control using session
        if (!"ADMIN".equals(session.getAttribute("userRole")))
            return "redirect:/admin/login";

        // Retrieve aggregated statistics using DAO abstraction
        model.addAttribute("totalCustomers", adminDAO.getTotalCustomerCount());
        model.addAttribute("newCustomersToday", adminDAO.getNewCustomersToday());

        return "admin/dashboard";
    }


    //Customer Management Page
    @GetMapping("/customers")
    public String manageCustomers(
            @RequestParam(required = false) String action,   
            @RequestParam(required = false) Integer id,      
            @RequestParam(required = false) String search,   
            HttpSession session,
            Model model) {

        // Role-based access validation
        if (!"ADMIN".equals(session.getAttribute("userRole")))
            return "redirect:/admin/login";


        //Permanently remove a customer
        if ("delete".equals(action) && id != null) {
            userDAO.deleteCustomer(id);
            return "redirect:/admin/customers?successMessage=Customer deleted successfully";
        }


        //Load selected customer data into form
        if ("edit".equals(action) && id != null) {
            model.addAttribute("action", "edit");
            model.addAttribute("editCustomer", userDAO.getCustomerById(id));
        }


        //Display Add Customer form
        if ("add".equals(action)) {
            model.addAttribute("action", "add");
        }


        //Retrieve filtered results using DAO search method
        if (search != null && !search.isEmpty()) {
            model.addAttribute("customers", userDAO.searchCustomers(search));
            model.addAttribute("searchTerm", search);
        }
        else {
            //Retrieve all customers for admin view
            model.addAttribute("customers", userDAO.getAllCustomers());
        }

        return "admin/customer-management";
    }


    //Process Add or Edit Customer Form Submission
    @PostMapping("/customers")
    public String handleCustomerAction(
            @RequestParam String action,
            @RequestParam(required = false) Integer customerId,
            @RequestParam String username,
            @RequestParam String email,
            @RequestParam(required = false) String password,
            @RequestParam(required = false) String phoneNumber,
            @RequestParam(required = false) String deliveryAddress,
            HttpSession session) {

        // Role validation to ensure only admins perform CRUD
        if (!"ADMIN".equals(session.getAttribute("userRole")))
            return "redirect:/admin/login";


        //Register a new customer account
        if ("add".equals(action)) {

            RegularCustomer customer = new RegularCustomer();

            //Data validation handled inside model setters
            customer.setUsername(username);
            customer.setEmail(email);
            customer.setPassword(password);
            customer.setPhoneNumber(phoneNumber);
            customer.setDeliveryAddress(deliveryAddress);

            userDAO.registerCustomer(customer);

            return "redirect:/admin/customers?successMessage=Customer added successfully";
        }


        //Modify existing customer details
        if ("update".equals(action) && customerId != null) {

            // Retrieve existing object using DAO abstraction
            RegularCustomer existing = userDAO.getCustomerById(customerId);

            //Update allowed fields only
            existing.setUsername(username);
            existing.setEmail(email);
            existing.setPhoneNumber(phoneNumber);
            existing.setDeliveryAddress(deliveryAddress);

            // Only update password if new password provided
            if (password != null && !password.isEmpty()) {
                existing.setPassword(password);
            }

            userDAO.updateCustomer(existing);

            return "redirect:/admin/customers?successMessage=Customer updated successfully";
        }

        return "redirect:/admin/customers";
    }
}