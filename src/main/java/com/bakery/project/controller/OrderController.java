package com.bakery.project.controller;

import com.bakery.project.model.Order;
import com.bakery.project.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    // View Order History Page[cite: 3]
    @GetMapping("/history")
    public String viewHistory(Model model) {
        model.addAttribute("orders", orderService.getAllOrders());
        return "history"; // Points to history.jsp[cite: 3]
    }

    // Handle Order Placement[cite: 3]
    @PostMapping("/place")
    public String createOrder(@ModelAttribute Order order) {
        orderService.placeOrder(order);
        return "redirect:/orders/history";
    }
}