package com.bakery.reviews.model;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;
import lombok.*;
import java.time.LocalDateTime;

/**
 * Base Review entity — Encapsulation: all fields private with controlled access.
 * ProductReview and ServiceReview inherit from this class (Inheritance).
 */
@Entity
@Table(name = "reviews")
@Inheritance(strategy = InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(name = "review_type", discriminatorType = DiscriminatorType.STRING)
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Review {

    // Nested enum for review moderation status
    public enum ReviewStatus {
        PENDING, APPROVED, REJECTED
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "Customer name is required")
    @Column(nullable = false)
    private String customerName;

    @NotBlank(message = "Customer email is required")
    @Email(message = "Invalid email format")
    @Column(nullable = false)
    private String customerEmail;

    @NotBlank(message = "Comment cannot be empty")
    @Column(nullable = false, columnDefinition = "TEXT")
    private String comment;

    @Min(1) @Max(5)
    @Column(nullable = false)
    private int rating;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20)
    private ReviewStatus status;

    @Column(nullable = false)
    private boolean verified;

    @Column(nullable = false, updatable = false)
    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    @Column(name = "review_type", insertable = false, updatable = false)
    private String reviewType;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
        updatedAt = LocalDateTime.now();
        if (status == null) status = ReviewStatus.PENDING;
    }

    @PreUpdate
    protected void onUpdate() {
        updatedAt = LocalDateTime.now();
    }

    // Polymorphism: overridden by subclasses for different display logic
    public String getDisplaySummary() {
        String verifiedLabel = verified ? "[Verified]" : "[Unverified]";
        return verifiedLabel + " " + customerName + " rated " + rating + "/5 — " + comment;
    }
}
