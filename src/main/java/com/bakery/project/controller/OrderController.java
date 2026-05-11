package com.bakery.project.controller;

import com.bakery.project.model.CustomOrder;
import com.bakery.project.model.Order;
import com.bakery.project.model.StandardOrder;
import com.bakery.project.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class OrderController {

    private static final String ATTR_ORDERS = "orders";
    private static final String ATTR_ORDER = "order";
    private static final String REDIRECT_CUSTOM = "redirect:/custom-orders";

    @Autowired
    private OrderService orderService;

    // ── Standard order history ──────────────────────────────────────────────

    @GetMapping("/orders/history")
    public String viewHistory(Model model) {
        model.addAttribute(ATTR_ORDERS, orderService.getAllOrders());
        return "history";
    }

    @PostMapping("/orders/place")
    public String createOrder(@ModelAttribute StandardOrder order) {
        orderService.placeOrder(order);
        return "redirect:/orders/history";
    }

    // ── Custom cake booking ─────────────────────────────────────────────────

    // List all custom orders (customer & admin view)
    @GetMapping("/custom-orders")
    public String listCustomOrders(Model model) {
        model.addAttribute(ATTR_ORDERS, orderService.getCustomOrders());
        return "custom-orders-list";
    }

    // Show Custom Cake Design Form
    @GetMapping("/custom-orders/new")
    public String newCustomOrderForm(Model model) {
        model.addAttribute(ATTR_ORDER, new CustomOrder());
        return "custom-order-form";
    }

    // Submit new custom order
    @PostMapping("/custom-orders/place")
    public String placeCustomOrder(@ModelAttribute CustomOrder order) {
        orderService.placeOrder(order);
        return REDIRECT_CUSTOM;
    }

    // Show pre-filled edit form
    @GetMapping("/custom-orders/edit/{id}")
    public String editCustomOrderForm(@PathVariable Long id, Model model) {
        Order order = orderService.getOrderById(id);
        if (!(order instanceof CustomOrder)) {
            return REDIRECT_CUSTOM;
        }
        model.addAttribute(ATTR_ORDER, order);
        return "custom-order-edit";
    }

    // Save updated order specs / status / delivery date
    @PostMapping("/custom-orders/update/{id}")
    public String updateCustomOrder(@PathVariable Long id, @ModelAttribute CustomOrder updated) {
        orderService.updateCustomOrder(id, updated);
        return REDIRECT_CUSTOM;
    }

    // Delete a cancelled or completed order
    @PostMapping("/custom-orders/delete/{id}")
    public String deleteCustomOrder(@PathVariable Long id) {
        orderService.deleteOrder(id);
        return REDIRECT_CUSTOM;
    }

    // Order Status Tracking Page
    @GetMapping("/custom-orders/track/{id}")
    public String trackCustomOrder(@PathVariable Long id, Model model) {
        Order order = orderService.getOrderById(id);
        if (!(order instanceof CustomOrder)) {
            return REDIRECT_CUSTOM;
        }
        model.addAttribute(ATTR_ORDER, order);
        return "custom-order-track";
    }

    // Admin dashboard
    @GetMapping("/admin-dashboard")
    public String adminDashboard(Model model) {
        model.addAttribute(ATTR_ORDERS, orderService.getAllOrders());
        model.addAttribute("customOrderCount", orderService.getCustomOrders().size());
        return "admin-dashboard";
    }

    // Redirect `/orders` to the orders history page to avoid 404 when users visit
    // /orders
    @GetMapping("/orders")
    public String ordersRoot() {
        return "redirect:/orders/history";
    }
}
