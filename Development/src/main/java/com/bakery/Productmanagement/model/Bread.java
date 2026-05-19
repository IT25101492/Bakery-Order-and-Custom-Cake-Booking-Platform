package com.bakery.Productmanagement.model;

import jakarta.persistence.Entity;
import jakarta.persistence.DiscriminatorValue;

@Entity
@DiscriminatorValue("Bread")
public class Bread extends Product {

    private String breadType;

    public Bread() {
        setCategory("Bread");
    }

    @Override
    public String getDisplayInfo() {
        return getName() + " (Bread" +
                (breadType != null && !breadType.isEmpty() ? " - " + breadType : "") +
                ") - $" + getPrice();
    }

    public String getBreadType() { return breadType; }
    public void setBreadType(String breadType) { this.breadType = breadType; }
}