package com.bakery.Usermanagement.controller;

import com.bakery.Usermanagement.dao.UserDAO;
import com.bakery.Usermanagement.dao.AdminDAO;
import com.bakery.Usermanagement.model.RegularCustomer;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private AdminDAO adminDAO;
    @Autowired
    private UserDAO userDAO;

    //Admin Dashboard
    @GetMapping("/dashboard")
    public String showAdminDashboard(HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";
        model.addAttribute("contentPage", "admin/dashboard.jsp");
        model.addAttribute("pageTitle", "Admin Dashboard");
        model.addAttribute("totalCustomers", adminDAO.getTotalCustomerCount());
        model.addAttribute("newCustomersToday", adminDAO.getNewCustomersToday());
        return "layout";
    }

    //Customer List with Search
    @GetMapping("/customers")
    public String listCustomers(@RequestParam(required = false) String search,
                                @RequestParam(required = false) String action,
                                @RequestParam(required = false) Integer id,
                                HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";

        //Handles Add/Edit form display
        if ("add".equals(action)) {
            model.addAttribute("action", "add");
            model.addAttribute("customers", userDAO.getAllCustomers());
            model.addAttribute("contentPage", "admin/customer-management.jsp");
            model.addAttribute("pageTitle", "Customer Management");
            return "layout";
        }

        if ("edit".equals(action) && id != null) {
            model.addAttribute("action", "edit");
            model.addAttribute("editCustomer", userDAO.getCustomerById(id));
            model.addAttribute("customers", userDAO.getAllCustomers());
            model.addAttribute("contentPage", "admin/customer-management.jsp");
            model.addAttribute("pageTitle", "Customer Management");
            return "layout";
        }

        //Handles Delete
        if ("delete".equals(action) && id != null) {
            userDAO.deleteCustomer(id);
            return "redirect:/admin/customers?successMessage=Customer+deleted+successfully";
        }

        //Shows customer list with optional search
        if (search != null && !search.isEmpty()) {
            model.addAttribute("customers", userDAO.searchCustomers(search));
            model.addAttribute("searchTerm", search);
        } else {
            model.addAttribute("customers", userDAO.getAllCustomers());
        }
        model.addAttribute("contentPage", "admin/customer-management.jsp");
        model.addAttribute("pageTitle", "Customer Management");
        return "layout";
    }

    //Admin Add Customer
    @PostMapping("/customers")
    public String addCustomer(@ModelAttribute RegularCustomer newCustomer,
                              HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";

        if (userDAO.isUsernameExists(newCustomer.getUsername())) {
            model.addAttribute("errorMessage", "Username already taken.");
            model.addAttribute("action", "add");
            model.addAttribute("customers", userDAO.getAllCustomers());
            model.addAttribute("contentPage", "admin/customer-management.jsp");
            model.addAttribute("pageTitle", "Customer Management");
            return "layout";
        }
        userDAO.registerCustomer(newCustomer);
        return "redirect:/admin/customers?successMessage=Customer+added+successfully";
    }

    //Admin Edit Customer
    @PostMapping("/customers/update")
    public String updateCustomer(@ModelAttribute RegularCustomer updatedData,
                                 @RequestParam int customerId,
                                 @RequestParam(required = false) String password,
                                 HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";

        RegularCustomer existing = userDAO.getCustomerById(customerId);
        if (existing != null) {
            existing.setUsername(updatedData.getUsername());
            existing.setEmail(updatedData.getEmail());
            existing.setPhoneNumber(updatedData.getPhoneNumber());
            existing.setDeliveryAddress(updatedData.getDeliveryAddress());
            if (password != null && !password.isEmpty()) {
                existing.setPassword(password);
            }
            userDAO.updateCustomer(existing);
        }
        return "redirect:/admin/customers?successMessage=Customer+updated+successfully";
    }

    //Removes customer 
    @GetMapping("/customers/delete/{id}")
    public String deleteCustomer(@PathVariable int id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/admin/login";
        userDAO.deleteCustomer(id);
        return "redirect:/admin/customers?successMessage=Customer+deleted+successfully";
    }
}
