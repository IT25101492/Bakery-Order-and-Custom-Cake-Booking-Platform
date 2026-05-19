package com.bakery.Productmanagement.model;

import jakarta.persistence.Entity;
import jakarta.persistence.DiscriminatorValue;

@Entity
@DiscriminatorValue("StandardCake")
public class StandardCake extends Product {

    private String flavor;
    private String cakeSize;

    public StandardCake() {
        setCategory("Cake");
    }

    @Override
    public String getDisplayInfo() {
        String info = getName() + " (Standard Cake";
        if (flavor != null && !flavor.isEmpty()) info += " - " + flavor;
        if (cakeSize != null && !cakeSize.isEmpty()) info += ", " + cakeSize;
        info += ") - $" + getPrice();
        return info;
    }

    public String getFlavor() { return flavor; }
    public void setFlavor(String flavor) { this.flavor = flavor; }

    public String getCakeSize() { return cakeSize; }
    public void setCakeSize(String cakeSize) { this.cakeSize = cakeSize; }
}