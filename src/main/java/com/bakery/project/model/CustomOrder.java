package com.bakery.project.model;

import jakarta.persistence.Entity;

@Entity
public class CustomOrder extends Order { // Inheritance

    // Encapsulation: private fields
    private String cakeDesign;
    private String specialInstructions;
    private String cakeSize;       // SMALL | MEDIUM | LARGE | TIERED
    private String complexity;     // BASIC | STANDARD | ELABORATE
    private String urgency;        // NORMAL | RUSH
    private String flavor;
    private int layers;
    private String deliveryDate;

    public CustomOrder() { /* Required by JPA */ }

    // Abstraction: validates design requirements and computes price
    public double calculatePrice() {
        double base;
        switch (cakeSize == null ? "SMALL" : cakeSize.toUpperCase()) {
            case "MEDIUM":  base = 2500; break;
            case "LARGE":   base = 4000; break;
            case "TIERED":  base = 7000; break;
            default:        base = 1500; break; // SMALL
        }

        double complexityMultiplier;
        switch (complexity == null ? "BASIC" : complexity.toUpperCase()) {
            case "STANDARD":  complexityMultiplier = 1.3; break;
            case "ELABORATE": complexityMultiplier = 1.6; break;
            default:          complexityMultiplier = 1.0; break; // BASIC
        }

        double price = base * complexityMultiplier;

        // Polymorphism: RUSH surcharge applied only when urgency demands it
        if ("RUSH".equalsIgnoreCase(urgency)) {
            price *= 1.2;
        }

        // Extra layers beyond the first
        if (layers > 1) {
            price += (layers - 1) * 300.0;
        }

        return price;
    }

    @Override
    public void processOrderWorkflow() { // Polymorphism
        this.setTotalAmount(calculatePrice());
        this.setStatus("AWAITING_DESIGN_APPROVAL");
    }

    // Getters and Setters (Encapsulation)
    public String getCakeDesign() { return cakeDesign; }
    public void setCakeDesign(String cakeDesign) { this.cakeDesign = cakeDesign; }

    public String getSpecialInstructions() { return specialInstructions; }
    public void setSpecialInstructions(String specialInstructions) { this.specialInstructions = specialInstructions; }

    public String getCakeSize() { return cakeSize; }
    public void setCakeSize(String cakeSize) { this.cakeSize = cakeSize; }

    public String getComplexity() { return complexity; }
    public void setComplexity(String complexity) { this.complexity = complexity; }

    public String getUrgency() { return urgency; }
    public void setUrgency(String urgency) { this.urgency = urgency; }

    public String getFlavor() { return flavor; }
    public void setFlavor(String flavor) { this.flavor = flavor; }

    public int getLayers() { return layers; }
    public void setLayers(int layers) { this.layers = layers; }

    public String getDeliveryDate() { return deliveryDate; }
    public void setDeliveryDate(String deliveryDate) { this.deliveryDate = deliveryDate; }
}
