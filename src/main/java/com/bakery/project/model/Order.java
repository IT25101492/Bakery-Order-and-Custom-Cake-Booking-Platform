package com.bakery.project.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "orders")
@Inheritance(strategy = InheritanceType.JOINED) 
public abstract class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId; // Encapsulation: Private field

    private String customerName;
    private Double totalAmount;
    private String status; // Pending, Confirmed, Ready, Delivered[cite: 3]
    private LocalDateTime orderDate;

    // Default Constructor (Required for JPA)
    public Order() {
        this.orderDate = LocalDateTime.now(); // Automatically set the date
    }

    // Getters and Setters[cite: 3]
    public Long getOrderId() { return orderId; }
    public void setOrderId(Long orderId) { this.orderId = orderId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(Double totalAmount) { this.totalAmount = totalAmount; }

    public LocalDateTime getOrderDate() { return orderDate; }
    public void setOrderDate(LocalDateTime orderDate) { this.orderDate = orderDate; }

    // Polymorphism: Abstract method for different processing[cite: 3]
    public abstract void processOrderWorkflow();
}