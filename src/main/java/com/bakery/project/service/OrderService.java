package com.bakery.project.service;

import com.bakery.project.model.CustomOrder;
import com.bakery.project.model.Order;
import com.bakery.project.repository.OrderRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class OrderService {

    private static final Logger log = LoggerFactory.getLogger(OrderService.class);
    private static final String FILE_PATH = "custom_orders.txt";

    @Autowired
    private OrderRepository orderRepository;

    // CREATE: Process and save a new order
    public Order placeOrder(Order order) {
        order.processOrderWorkflow(); // Polymorphism: calls Standard or Custom workflow
        Order saved = orderRepository.save(order);
        if (saved instanceof CustomOrder customOrder) {
            appendToFile(customOrder);
        }
        return saved;
    }

    // READ: All orders (admin dashboard)
    public List<Order> getAllOrders() {
        return orderRepository.findAll();
    }

    // READ: Custom orders only
    public List<CustomOrder> getCustomOrders() {
        return orderRepository.findAll().stream()
                .filter(CustomOrder.class::isInstance)
                .map(o -> (CustomOrder) o)
                .collect(Collectors.toList());
    }

    // READ: Single order by ID
    public Order getOrderById(Long id) {
        return orderRepository.findById(id).orElse(null);
    }

    // UPDATE: Change status of an existing order
    public void updateStatus(Long id, String newStatus) {
        Order order = orderRepository.findById(id).orElse(null);
        if (order != null) {
            order.setStatus(newStatus);
            orderRepository.save(order);
            if (order instanceof CustomOrder) {
                rewriteFile();
            }
        }
    }

    // UPDATE: Full update of a custom order's specs
    public void updateCustomOrder(Long id, CustomOrder updated) {
        Optional<Order> existing = orderRepository.findById(id);
        if (existing.isPresent() && existing.get() instanceof CustomOrder order) {
            order.setCustomerName(updated.getCustomerName());
            order.setCakeSize(updated.getCakeSize());
            order.setComplexity(updated.getComplexity());
            order.setUrgency(updated.getUrgency());
            order.setFlavor(updated.getFlavor());
            order.setLayers(updated.getLayers());
            order.setCakeDesign(updated.getCakeDesign());
            order.setSpecialInstructions(updated.getSpecialInstructions());
            order.setDeliveryDate(updated.getDeliveryDate());
            order.setStatus(updated.getStatus());
            order.setTotalAmount(order.calculatePrice());
            orderRepository.save(order);
            rewriteFile();
        }
    }

    // DELETE: Remove a cancelled or completed order
    public void deleteOrder(Long id) {
        orderRepository.deleteById(id);
        rewriteFile();
    }

    // FILE I/O: Append a single custom order record
    private void appendToFile(CustomOrder order) {
        try (PrintWriter pw = new PrintWriter(new FileWriter(FILE_PATH, true))) {
            pw.println(formatRecord(order));
        } catch (IOException e) {
            log.warn("Could not write to {}: {}", FILE_PATH, e.getMessage());
        }
    }

    // FILE I/O: Rebuild file from current DB state after update/delete
    private void rewriteFile() {
        try (PrintWriter pw = new PrintWriter(new FileWriter(FILE_PATH, false))) {
            getCustomOrders().forEach(o -> pw.println(formatRecord(o)));
        } catch (IOException e) {
            log.warn("Could not rewrite {}: {}", FILE_PATH, e.getMessage());
        }
    }

    private String formatRecord(CustomOrder o) {
        return String.join("|",
                String.valueOf(o.getOrderId()),
                nullSafe(o.getCustomerName()),
                nullSafe(o.getCakeSize()),
                nullSafe(o.getComplexity()),
                nullSafe(o.getUrgency()),
                nullSafe(o.getFlavor()),
                String.valueOf(o.getLayers()),
                String.valueOf(o.getTotalAmount()),
                nullSafe(o.getStatus()),
                nullSafe(o.getDeliveryDate()),
                String.valueOf(o.getOrderDate())
        );
    }

    private String nullSafe(String s) {
        return s == null ? "" : s;
    }
}
