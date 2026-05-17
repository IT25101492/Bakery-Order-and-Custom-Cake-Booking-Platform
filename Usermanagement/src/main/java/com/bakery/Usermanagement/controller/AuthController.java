package com.bakery.Usermanagement.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bakery.Usermanagement.dao.AdminDAO;
import com.bakery.Usermanagement.dao.UserDAO;
import com.bakery.Usermanagement.model.AdminUser;
import com.bakery.Usermanagement.model.RegularCustomer;

import jakarta.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private UserDAO userDAO;

    @Autowired
    private AdminDAO adminDAO;

    //Customer Login
    @GetMapping("/login")
    public String showCustomerLogin() {
        return "customer/login";
    }

    //If someone comes to the home address send them to login page
    @GetMapping("/")
    public String index(){
        return "redirect:/login";
    }

    @PostMapping("/login")
    public String handleCustomerLogin(@RequestParam String loginIdentifier, 
                                      @RequestParam String password, 
                                      HttpSession session, Model model) {
        // Search by username first, then email (Requirements: Read/Search)
        RegularCustomer customer = userDAO.getCustomerByUsername(loginIdentifier);
        if (customer == null) {
            customer = userDAO.getCustomerByEmail(loginIdentifier);
        }

        // Polymorphism: authenticate behaves differently for Customers vs Admins
        if (customer != null && customer.authenticate(password)) {
            if (!customer.isActive()) {
                model.addAttribute("errorMessage", "Account deactivated.");
                return "customer/login";
            }
            session.setAttribute("customerId", customer.getUserId());
            session.setAttribute("customerUsername", customer.getUsername());
            session.setAttribute("userRole", "CUSTOMER");
            //System.out.println("Customer Login Success - ID: " + customer.getUserId());
            return "redirect:/dashboard";
            
        }
        
        model.addAttribute("errorMessage", "Invalid credentials.");
        return "customer/login";
    }

    //Admin Login (Hidden URL)
    @GetMapping("/admin/login")
    public String showAdminLogin() {
        return "admin/login";
    }

    @PostMapping("/admin/login")
    public String handleAdminLogin(@RequestParam String loginIdentifier, 
                                   @RequestParam String password, 
                                   HttpSession session, Model model) {
        //Tries to find admin by username
        AdminUser admin = adminDAO.getAdminByUsername(loginIdentifier);

        //If username not found, try email
        if (admin == null){
            admin = adminDAO.getAdminByEmail(loginIdentifier);
        }
        
        //Polymorphism: Admin authentication includes extra checks
        if (admin != null && admin.authenticate(password)) {
            session.setAttribute("adminId", admin.getUserId());
            session.setAttribute("adminUsername", admin.getUsername());
            session.setAttribute("department", admin.getDepartment());
            session.setAttribute("adminLevel", admin.getAdminLevel());
            session.setAttribute("userRole", "ADMIN");
            //System.out.println("Admin Login Success - ID: " + admin.getUserId());
            return "redirect:/admin/dashboard";
        }
        
        model.addAttribute("errorMessage", "Access Denied.");
        return "admin/login";
    }

    //Logout 
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}