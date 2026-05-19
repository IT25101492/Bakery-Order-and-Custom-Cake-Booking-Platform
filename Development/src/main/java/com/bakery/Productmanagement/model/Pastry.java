package com.bakery.Productmanagement.model;

import jakarta.persistence.Entity;
import jakarta.persistence.DiscriminatorValue;

@Entity
@DiscriminatorValue("Pastry")
public class Pastry extends Product {

    private boolean isSweet;

    public Pastry() {
        setCategory("Pastry");
    }

    @Override
    public String getDisplayInfo() {
        return getName() + " (" + (isSweet ? "Sweet" : "Savory") + " Pastry) - $" + getPrice();
    }

    public boolean isSweet() { return isSweet; }
    public void setSweet(boolean sweet) { isSweet = sweet; }
}