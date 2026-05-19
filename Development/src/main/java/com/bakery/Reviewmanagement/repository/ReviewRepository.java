package com.bakery.Reviewmanagement.repository;

import com.bakery.Reviewmanagement.model.Review;
import com.bakery.Reviewmanagement.model.Review.ReviewStatus;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    List<Review> findByStatus(ReviewStatus status);

    List<Review> findByReviewType(String reviewType);

    @Query("SELECT r FROM Review r WHERE r.reviewType = 'PRODUCT' AND r.productName = :productName AND r.status = com.bakery.Reviewmanagement.model.Review.ReviewStatus.APPROVED")
    List<Review> findApprovedByProductName(@Param("productName") String productName);

    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.reviewType = 'PRODUCT' AND r.productName = :productName AND r.status = com.bakery.Reviewmanagement.model.Review.ReviewStatus.APPROVED")
    Double findAverageRatingByProduct(@Param("productName") String productName);

    List<Review> findByCustomerEmail(String customerEmail);

    List<Review> findByStatusOrderByCreatedAtDesc(ReviewStatus status);
}