package com.bakery.project.service;

import com.bakery.project.model.Order;
import com.bakery.project.repository.OrderRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    // CREATE: Process and save a new order
    public Order placeOrder(Order order) {
        // Polymorphism: Calls the specific workflow for Standard or Custom orders[cite: 3]
        order.processOrderWorkflow(); 
        return orderRepository.save(order);
    }

    // READ: Get all orders for the Admin Dashboard[cite: 3]
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    // UPDATE: Change the status of an existing order[cite: 3]
    public void updateStatus(Long id, String newStatus) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order != null) {
            order.setStatus(newStatus);
            orderRepository.save(order);
        }
    }
}