package com.bakery.Ordermanagement.controller;

import com.bakery.Ordermanagement.model.*;
import com.bakery.Ordermanagement.repository.OrderRepository;
import com.bakery.Ordermanagement.repository.OrderItemRepository;
import com.bakery.Productmanagement.model.Product;
import com.bakery.Productmanagement.repository.ProductRepository;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Controller
public class OrderController {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private OrderItemRepository orderItemRepository;

    @Autowired
    private ProductRepository productRepository;

    //Customer Checkout

    @SuppressWarnings("unchecked")
    private List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    @PostMapping("/cart/add")
    public String addToCart(@RequestParam int productId,
                            @RequestParam(defaultValue = "1") int quantity,
                            HttpSession session) {
        String role = (String) session.getAttribute("userRole");
        if (role == null || !"CUSTOMER".equals(role)) return "redirect:/login";

        Product product = productRepository.findById(productId).orElse(null);
        if (product == null || !product.isAvailability()) return "redirect:/products/items";

        List<CartItem> cart = getCart(session);
        boolean found = false;

        for (CartItem item : cart) {
            if (item.getProductId() == productId) {
                item.incrementQuantity();
                found = true;
                break;
            }
        }

        if (!found) {
            cart.add(new CartItem(
                    product.getProductId(),
                    product.getName(),
                    product.getCategory(),
                    product.getPrice(),
                    quantity,
                    product.isAvailability()
            ));
        }

        session.setAttribute("cart", cart);
        return "redirect:/products/items";
    }

    @GetMapping("/cart")
    public String viewCart(HttpSession session, Model model) {
        String role = (String) session.getAttribute("userRole");
        if (role == null || !"CUSTOMER".equals(role)) return "redirect:/login";

        List<CartItem> cart = getCart(session);
        model.addAttribute("cartItems", cart);
        model.addAttribute("contentPage", "order/cart.jsp");
        model.addAttribute("pageTitle", "Shopping Cart");
        return "layout";
    }

    @PostMapping("/cart/update")
    public String updateCart(@RequestParam int productId,
                             @RequestParam int quantity,
                             HttpSession session) {
        List<CartItem> cart = getCart(session);

        if (quantity <= 0) {
            cart.removeIf(item -> item.getProductId() == productId);
        } else {
            for (CartItem item : cart) {
                if (item.getProductId() == productId) {
                    item.setQuantity(quantity);
                    break;
                }
            }
        }

        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    @GetMapping("/cart/remove")
    public String removeFromCart(@RequestParam int productId, HttpSession session) {
        List<CartItem> cart = getCart(session);
        cart.removeIf(item -> item.getProductId() == productId);
        session.setAttribute("cart", cart);
        return "redirect:/cart";
    }

    //Customer Checkout

    @GetMapping("/checkout")
    public String showCheckout(HttpSession session, Model model) {
        String role = (String) session.getAttribute("userRole");
        if (role == null || !"CUSTOMER".equals(role)) return "redirect:/login";

        List<CartItem> cart = getCart(session);
        if (cart.isEmpty()) return "redirect:/cart";

        model.addAttribute("cartItems", cart);
        model.addAttribute("contentPage", "order/checkout.jsp");
        model.addAttribute("pageTitle", "Checkout");
        return "layout";
    }

    @SuppressWarnings("unchecked")
    @PostMapping("/orders/place")
    public String placeOrder(HttpSession session) {
        String role = (String) session.getAttribute("userRole");
        if (role == null || !"CUSTOMER".equals(role)) return "redirect:/login";

        List<CartItem> cart = getCart(session);
        if (cart.isEmpty()) return "redirect:/cart";

        // Create order (StandardOrder - Polymorphism)
        Order order = new StandardOrder();
        order.setCustomerId((Integer) session.getAttribute("customerId"));
        order.setCustomerName((String) session.getAttribute("customerUsername"));
        order.setCustomerEmail((String) session.getAttribute("customerEmail"));

        double total = 0;
        for (CartItem item : cart) {
            total += item.getSubtotal();
        }
        order.setTotalPrice(total);
        order = orderRepository.save(order);

        // Save order items
        for (CartItem item : cart) {
            OrderItem orderItem = new OrderItem();
            orderItem.setOrderId(order.getOrderId());
            orderItem.setProductId(item.getProductId());
            orderItem.setProductName(item.getProductName());
            orderItem.setProductCategory(item.getProductCategory());
            orderItem.setPrice(item.getPrice());
            orderItem.setQuantity(item.getQuantity());
            orderItem.calculateSubtotal();
            orderItemRepository.save(orderItem);
        }

        // Clear cart
        session.setAttribute("cart", new ArrayList<>());

        return "redirect:/orders?successMessage=Order+placed+successfully";
    }

    //Customer Order History

    @GetMapping("/orders")
    public String viewOrderHistory(HttpSession session, Model model) {
        String role = (String) session.getAttribute("userRole");
        if (role == null) return "redirect:/login";

        if ("CUSTOMER".equals(role)) {
            int customerId = (Integer) session.getAttribute("customerId");
            List<Order> orders = orderRepository.findByCustomerId(customerId);
            model.addAttribute("orders", orders);
            model.addAttribute("contentPage", "order/order-history.jsp");
            model.addAttribute("pageTitle", "My Orders");
            return "layout";
        }

        return "redirect:/login";
    }

    @GetMapping("/orders/{id}")
    public String viewOrderDetails(@PathVariable int id, HttpSession session, Model model) {
        String role = (String) session.getAttribute("userRole");
        if (role == null) return "redirect:/login";

        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) return "redirect:/orders";

        if ("CUSTOMER".equals(role)) {
            int customerId = (Integer) session.getAttribute("customerId");
            if (order.getCustomerId() != customerId) return "redirect:/orders";
        }

        List<OrderItem> items = orderItemRepository.findByOrderId(id);
        model.addAttribute("order", order);
        model.addAttribute("orderItems", items);
        model.addAttribute("contentPage", "order/order-details.jsp");
        model.addAttribute("pageTitle", "Order #" + id);
        return "layout";
    }

    //Customer Cancel Order

    @PostMapping("/orders/{id}/cancel")
    public String cancelOrder(@PathVariable int id, HttpSession session) {
        String role = (String) session.getAttribute("userRole");
        if (role == null || !"CUSTOMER".equals(role)) return "redirect:/login";

        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) return "redirect:/orders";

        int customerId = (Integer) session.getAttribute("customerId");
        if (order.getCustomerId() != customerId) return "redirect:/orders";

        if ("pending".equals(order.getStatus()) || "confirmed".equals(order.getStatus())) {
            order.setStatus("cancelled");
            order.setUpdatedAt(LocalDateTime.now());
            orderRepository.save(order);
            return "redirect:/orders?successMessage=Order+cancelled+successfully";
        }

        return "redirect:/orders?errorMessage=Cannot+cancel+this+order";
    }

    //Admin - Ordermanagement

    @GetMapping("/admin/orders")
    public String viewAdminOrders(HttpSession session,
                                   @RequestParam(required = false) String filter,
                                   Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        List<Order> orders;
        if (filter != null && !filter.isEmpty()) {
            orders = orderRepository.findByStatus(filter);
        } else {
            orders = orderRepository.findAllByOrderByCreatedAtDesc();
        }

        model.addAttribute("orders", orders);
        model.addAttribute("currentFilter", filter);
        model.addAttribute("contentPage", "order/order-management.jsp");
        model.addAttribute("pageTitle", "Order Management");
        return "layout";
    }

    @PostMapping("/admin/orders/{id}/status")
    public String updateOrderStatus(@PathVariable int id,
                                     @RequestParam String status,
                                     HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) return "redirect:/admin/orders";

        boolean updated = order.updateStatus(status);
        if (updated) {
            orderRepository.save(order);
        }

        return "redirect:/admin/orders?successMessage=Order+status+updated";
    }

    @GetMapping("/admin/orders/{id}")
    public String viewAdminOrderDetails(@PathVariable int id, HttpSession session, Model model) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        Order order = orderRepository.findById(id).orElse(null);
        if (order == null) return "redirect:/admin/orders";

        List<OrderItem> items = orderItemRepository.findByOrderId(id);
        model.addAttribute("order", order);
        model.addAttribute("orderItems", items);
        model.addAttribute("contentPage", "order/order-details.jsp");
        model.addAttribute("pageTitle", "Order #" + id);
        return "layout";
    }

    @Transactional
    @GetMapping("/admin/orders/delete/{id}")
    public String deleteOrder(@PathVariable int id, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) return "redirect:/login";

        Order order = orderRepository.findById(id).orElse(null);
        if (order != null && ("delivered".equals(order.getStatus()) || "cancelled".equals(order.getStatus()))) {
            orderItemRepository.deleteByOrderId(id);
            orderRepository.deleteById(id);
            return "redirect:/admin/orders?successMessage=Order+deleted+successfully";
        }

        return "redirect:/admin/orders?errorMessage=Cannot+delete+an+active+order";
    }
}