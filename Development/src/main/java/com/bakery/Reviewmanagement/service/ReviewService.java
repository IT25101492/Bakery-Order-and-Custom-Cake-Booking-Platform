package com.bakery.Reviewmanagement.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.bakery.Reviewmanagement.model.ProductReview;
import com.bakery.Reviewmanagement.model.Review;
import com.bakery.Reviewmanagement.model.Review.ReviewStatus;
import com.bakery.Reviewmanagement.model.ServiceReview;
import com.bakery.Reviewmanagement.repository.ReviewRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewRepository reviewRepository;

    //Create

    public Review submitProductReview(ProductReview review) {
        review.setStatus(ReviewStatus.PENDING);
        review.setVerified(false);
        return reviewRepository.save(review);
    }

    public Review submitServiceReview(ServiceReview review) {
        review.setStatus(ReviewStatus.PENDING);
        review.setVerified(false);
        return reviewRepository.save(review);
    }

    //Read
    public List<Review> getAllReviews() {
        return reviewRepository.findAll();
    }

    public Review getReviewById(Long id) {
        return reviewRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Review not found with id: " + id));
    }

    public List<Review> getApprovedReviews() {
        return reviewRepository.findByStatusOrderByCreatedAtDesc(ReviewStatus.APPROVED);
    }

    public List<Review> getPendingReviews() {
        return reviewRepository.findByStatusOrderByCreatedAtDesc(ReviewStatus.PENDING);
    }

    public List<Review> getReviewsByProduct(String productName) {
        return reviewRepository.findApprovedByProductName(productName);
    }

    public List<Review> getReviewsByCustomer(String email) {
        return reviewRepository.findByCustomerEmail(email);
    }

    public Double getAverageRatingForProduct(String productName) {
        Double avg = reviewRepository.findAverageRatingByProduct(productName);
        return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
    }

    //Update

    public Review updateReview(Long id, Map<String, Object> updates) {
        Review existing = getReviewById(id);
        if (updates.containsKey("comment")) existing.setComment((String) updates.get("comment"));
        if (updates.containsKey("rating"))  existing.setRating((Integer) updates.get("rating"));
        return reviewRepository.save(existing);
    }

    public Review moderateReview(Long id, ReviewStatus status) {
        Review review = getReviewById(id);
        review.setStatus(status);
        if (status == ReviewStatus.APPROVED) review.setVerified(true);
        return reviewRepository.save(review);
    }

    //Delete
    public void deleteReview(Long id) {
        Review review = getReviewById(id);
        reviewRepository.delete(review);
    }
}