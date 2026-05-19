package com.bakery.Reviewmanagement.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Entity
@DiscriminatorValue("SERVICE")
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
public class ServiceReview extends Review {

    @NotBlank(message = "Service type is required")
    @Column(name = "service_type")
    private String serviceType;

    @Override
    public String getDisplaySummary() {
        String base = super.getDisplaySummary();
        return "[Service: " + serviceType + "] " + base;
    }
}