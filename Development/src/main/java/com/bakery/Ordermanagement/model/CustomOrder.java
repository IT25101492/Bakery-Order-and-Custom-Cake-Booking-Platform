package com.bakery.Ordermanagement.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Custom")
public class CustomOrder extends Order {

    @Override
    public String getOrderDescription() {
        return "Custom Order #" + getOrderId() + " - $" + getTotalPrice();
    }
}