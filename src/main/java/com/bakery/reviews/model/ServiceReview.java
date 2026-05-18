package com.bakery.reviews.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

/**
 * Inheritance: ServiceReview extends Review.
 * Polymorphism: overrides getDisplaySummary() for service-specific display.
 */
@Entity
@DiscriminatorValue("SERVICE")
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
public class ServiceReview extends Review {

    @NotBlank(message = "Service type is required")
    @Column(name = "service_type")
    private String serviceType; // e.g. DELIVERY, CUSTOM_CAKE, IN_STORE

    @Override
    public String getDisplaySummary() {
        String base = super.getDisplaySummary();
        return "[Service: " + serviceType + "] " + base;
    }
}
