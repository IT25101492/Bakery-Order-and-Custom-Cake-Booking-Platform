package com.bakery.Productmanagement.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.bakery.Productmanagement.model.Bread;
import com.bakery.Productmanagement.model.Pastry;
import com.bakery.Productmanagement.model.Product;
import com.bakery.Productmanagement.model.StandardCake;
import com.bakery.Productmanagement.repository.ProductRepository;

import jakarta.servlet.http.HttpSession;

@Controller
public class ProductController {

    @Autowired
    private ProductRepository repository;

    
    //Customer Routes
    @GetMapping("/products/items")
    public String viewItemsPage(HttpSession session,
                                @RequestParam(required = false, defaultValue = "") String keyword,
                                Model model) {
        String role = (String) session.getAttribute("userRole");
        if (role == null) return "redirect:/login";
        if (!"CUSTOMER".equals(role)) return "redirect:/login";

        List<Product> items = keyword.isEmpty()
                ? repository.findByAvailabilityTrue()
                : repository.findByNameContainingAndAvailabilityTrue(keyword);

        model.addAttribute("products", items);
        model.addAttribute("contentPage", "product/item.jsp");
        model.addAttribute("pageTitle", "Browse Products");
        return "layout";
    }

    
     //Admin Routes   
    @GetMapping("/admin/products")
    public String viewAdminDashboard(HttpSession session,
                                     @RequestParam(required = false) String action,
                                     @RequestParam(required = false) Integer id,
                                     Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

       
        if ("add".equals(action)) {
            model.addAttribute("contentPage", "product/add-product.jsp");
            model.addAttribute("pageTitle", "Add New Product");
            return "layout";
        }

        if ("edit".equals(action) && id != null) {
            Product product = repository.findById(id).orElseThrow(() -> new RuntimeException("Product not found"));
            model.addAttribute("product", product);
            model.addAttribute("productTypeName", product.getClass().getSimpleName());
            model.addAttribute("contentPage", "product/edit-product.jsp");
            model.addAttribute("pageTitle", "Edit Product");
            return "layout";
        }

        model.addAttribute("products", repository.findAll());
        model.addAttribute("contentPage", "product/product-dashboard.jsp");
        model.addAttribute("pageTitle", "Product Management");
        return "layout";
    }

    @PostMapping("/admin/products/save")
    public String saveProduct(@RequestParam String productType,
                              @RequestParam String name,
                              @RequestParam String category,
                              @RequestParam double price,
                              @RequestParam(required = false) String ingredients,
                              @RequestParam int stockQuantity,
                              @RequestParam(required = false, defaultValue = "true") boolean availability,
                              @RequestParam(required = false) String description,
                              HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        Product product = createProductByType(productType);
        product.setName(name);
        product.setCategory(category);
        product.setPrice(price);
        product.setIngredients(ingredients);
        product.setStockQuantity(stockQuantity);
        product.setAvailability(availability);
        product.setDescription(description);
        repository.save(product);

        return "redirect:/admin/products?successMessage=Product+added+successfully";
    }

    @PostMapping("/admin/products/update/{id}")
    public String updateProduct(@PathVariable int id,
                                @RequestParam String name,
                                @RequestParam String category,
                                @RequestParam double price,
                                @RequestParam(required = false) String ingredients,
                                @RequestParam int stockQuantity,
                                @RequestParam(required = false, defaultValue = "true") boolean availability,
                                @RequestParam(required = false) String description,
                                HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        Product existing = repository.findById(id)
                .orElseThrow(() -> new RuntimeException("Product not found"));

        existing.setName(name);
        existing.setCategory(category);
        existing.setPrice(price);
        existing.setIngredients(ingredients);
        existing.setStockQuantity(stockQuantity);
        existing.setAvailability(availability);
        existing.setDescription(description);
        repository.save(existing);

        return "redirect:/admin/products?successMessage=Product+updated+successfully";
    }

    @GetMapping("/admin/products/delete/{id}")
    public String deleteProduct(@PathVariable int id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";
        repository.deleteById(id);
        return "redirect:/admin/products?successMessage=Product+deleted+successfully";
    }

    @GetMapping("/admin/products/search")
    public String search(@RequestParam(required = false, defaultValue = "") String keyword,
                         HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        List<Product> results = keyword.isEmpty()
                ? repository.findAll()
                : repository.findByNameContaining(keyword);

        model.addAttribute("products", results);
        model.addAttribute("contentPage", "product/product-dashboard.jsp");
        model.addAttribute("pageTitle", "Product Management");
        return "layout";
    }

    private Product createProductByType(String productType) {
        return switch (productType) {
            case "Bread" -> new Bread();
            case "Pastry" -> new Pastry();
            default -> new StandardCake();
        };
    }
}