package com.bakery.project.model;

import jakarta.persistence.Entity;

@Entity
public class StandardOrder extends Order { // Inheritance
    private String productCategory; // e.g., Bread, Pastry[cite: 3]

    // Default Constructor
    public StandardOrder() {}

    // Getters and Setters (Encapsulation)[cite: 3]
    public String getProductCategory() { return productCategory; }
    public void setProductCategory(String productCategory) { this.productCategory = productCategory; }

    @Override
    public void processOrderWorkflow() { // Polymorphism[cite: 3]
        this.setStatus("CONFIRMED"); // Standard items are confirmed immediately[cite: 3]
    }
}