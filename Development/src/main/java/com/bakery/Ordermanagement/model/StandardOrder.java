package com.bakery.Ordermanagement.model;

import jakarta.persistence.DiscriminatorValue;
import jakarta.persistence.Entity;

@Entity
@DiscriminatorValue("Standard")
public class StandardOrder extends Order {

    @Override
    public String getOrderDescription() {
        return "Standard Order #" + getOrderId() + " - $" + getTotalPrice();
    }
}