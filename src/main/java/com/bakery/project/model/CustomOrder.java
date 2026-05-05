package com.bakery.project.model;

import jakarta.persistence.Entity;

@Entity
public class CustomOrder extends Order { // Inheritance
    private String cakeDesign;
    private String specialInstructions;

    // Default Constructor required by JPA
    public CustomOrder() {}

    // Getters and Setters (Encapsulation)[cite: 3]
    public String getCakeDesign() { return cakeDesign; }
    public void setCakeDesign(String cakeDesign) { this.cakeDesign = cakeDesign; }

    public String getSpecialInstructions() { return specialInstructions; }
    public void setSpecialInstructions(String specialInstructions) { this.specialInstructions = specialInstructions; }

    @Override
    public void processOrderWorkflow() { // Polymorphism[cite: 3]
        // This ensures a custom cake order follows a unique business logic[cite: 3]
        this.setStatus("AWAITING_DESIGN_APPROVAL"); 
    }
}