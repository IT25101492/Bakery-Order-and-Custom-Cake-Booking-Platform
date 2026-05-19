package com.bakery.Reviewmanagement.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

@Entity
@DiscriminatorValue("PRODUCT")
@Data
@EqualsAndHashCode(callSuper = true)
@NoArgsConstructor
@AllArgsConstructor
public class ProductReview extends Review {

    @NotBlank(message = "Product name is required")
    @Column(name = "product_name")
    private String productName;

    @Column(name = "product_id")
    private Long productId;

    @Override
    public String getDisplaySummary() {
        String base = super.getDisplaySummary();
        return "[Product: " + productName + "] " + base;
    }
}