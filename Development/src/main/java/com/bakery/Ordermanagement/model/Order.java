package com.bakery.Ordermanagement.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
//import java.util.List;

@Entity
@Table(name = "orders")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "order_type", discriminatorType = DiscriminatorType.STRING)
public abstract class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int orderId;

    private int customerId;
    private String customerName;
    private String customerEmail;
    private double totalPrice;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Order() {
        this.status = "pending";
        this.createdAt = LocalDateTime.now();
        this.updatedAt = LocalDateTime.now();
    }

    // Abstract method - each subclass processes differently
    public abstract String getOrderDescription();

    // Encapsulated calculation
    public void calculateTotalPrice(double price, int quantity) {
        this.totalPrice += price * quantity;
    }

    // Status transitions with validation
    public boolean updateStatus(String newStatus) {
        String[] validTransitions = getValidTransitions();
        for (String transition : validTransitions) {
            if (transition.equals(newStatus)) {
                this.status = newStatus;
                this.updatedAt = LocalDateTime.now();
                return true;
            }
        }
        return false;
    }

    private String[] getValidTransitions() {
        return switch (this.status) {
            case "pending" -> new String[]{"confirmed", "cancelled"};
            case "confirmed" -> new String[]{"in-progress", "cancelled"};
            case "in-progress" -> new String[]{"ready"};
            case "ready" -> new String[]{"delivered"};
            default -> new String[]{};
        };
    }

    // Getters and Setters
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public double getTotalPrice() { return totalPrice; }
    public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }
    
    public String getOrderType() {
        return this.getClass().getSimpleName();
    }

    public String getFormattedCreatedAt() {
        return createdAt != null ? createdAt.toString().replace("T", " ") : "";
    }

    public String getFormattedUpdatedAt() {
        return updatedAt != null ? updatedAt.toString().replace("T", " ") : "";
    }

    public String getStatusDisplay() {
        return switch (status) {
            case "pending" -> "Pending";
            case "confirmed" -> "Confirmed";
            case "in-progress" -> "In Progress";
            case "ready" -> "Ready";
            case "delivered" -> "Delivered";
            case "cancelled" -> "Cancelled";
            default -> status;
        };
    }
}