package com.bakery.Reviewmanagement.controller;

import com.bakery.Reviewmanagement.model.ProductReview;
import com.bakery.Reviewmanagement.model.Review;
import com.bakery.Reviewmanagement.model.ServiceReview;
import com.bakery.Reviewmanagement.service.ReviewService;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
public class ReviewController {

    private final ReviewService reviewService;

    //View Approved Reviews (Customer + Admin)

    @GetMapping("/reviews")
    public String viewReviews(Model model, HttpSession session) {
        if (session.getAttribute("userRole") == null) {
            return "redirect:/login";
        }
        model.addAttribute("contentPage", "/WEB-INF/jsp/review/view-reviews.jsp");
        model.addAttribute("pageTitle", "Browse Reviews");
        model.addAttribute("reviews", reviewService.getApprovedReviews());
        return "layout";
    }

    //Submit Review Form (Customer Only)

    @GetMapping("/reviews/submit")
    public String submitReviewForm(Model model, HttpSession session) {
        if (!"CUSTOMER".equals(session.getAttribute("userRole"))) {
            return "redirect:/login";
        }
        model.addAttribute("contentPage", "/WEB-INF/jsp/review/submit-review.jsp");
        model.addAttribute("pageTitle", "Submit a Review");
        model.addAttribute("productReview", new ProductReview());
        model.addAttribute("serviceReview", new ServiceReview());
        return "layout";
    }

    @PostMapping("/reviews/submit/product")
    public String submitProductReview(@ModelAttribute ProductReview review,
                                      RedirectAttributes redirectAttrs) {
        try {
            reviewService.submitProductReview(review);
            redirectAttrs.addFlashAttribute("successMsg",
                    "Your product review has been submitted and is pending approval!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMsg",
                    "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/reviews/submit";
    }

    @PostMapping("/reviews/submit/service")
    public String submitServiceReview(@ModelAttribute ServiceReview review,
                                      RedirectAttributes redirectAttrs) {
        try {
            reviewService.submitServiceReview(review);
            redirectAttrs.addFlashAttribute("successMsg",
                    "Your service review has been submitted and is pending approval!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMsg",
                    "Failed to submit review: " + e.getMessage());
        }
        return "redirect:/reviews/submit";
    }

    //Admin Moderation (Admin Only)

    @GetMapping("/admin/reviews")
    public String adminModeration(Model model, HttpSession session) {
        if (!"ADMIN".equals(session.getAttribute("userRole"))) {
            return "redirect:/login";
        }
        model.addAttribute("contentPage", "/WEB-INF/jsp/review/review-moderation.jsp");
        model.addAttribute("pageTitle", "Review Moderation");
        model.addAttribute("pendingReviews", reviewService.getPendingReviews());
        model.addAttribute("allReviews", reviewService.getAllReviews());
        model.addAttribute("approvedCount", reviewService.getApprovedReviews().size());
        model.addAttribute("pendingCount", reviewService.getPendingReviews().size());
        return "layout";
    }

    @PostMapping("/admin/reviews/{id}/approve")
    public String approveReview(@PathVariable Long id,
                                RedirectAttributes redirectAttrs) {
        try {
            reviewService.moderateReview(id, Review.ReviewStatus.APPROVED);
            redirectAttrs.addFlashAttribute("successMsg", "Review approved successfully!");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMsg", e.getMessage());
        }
        return "redirect:/admin/reviews";
    }

    @PostMapping("/admin/reviews/{id}/reject")
    public String rejectReview(@PathVariable Long id,
                               RedirectAttributes redirectAttrs) {
        try {
            reviewService.moderateReview(id, Review.ReviewStatus.REJECTED);
            redirectAttrs.addFlashAttribute("successMsg", "Review rejected.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMsg", e.getMessage());
        }
        return "redirect:/admin/reviews";
    }

    @PostMapping("/admin/reviews/{id}/delete")
    public String deleteReview(@PathVariable Long id,
                               RedirectAttributes redirectAttrs) {
        try {
            reviewService.deleteReview(id);
            redirectAttrs.addFlashAttribute("successMsg", "Review deleted.");
        } catch (Exception e) {
            redirectAttrs.addFlashAttribute("errorMsg", e.getMessage());
        }
        return "redirect:/admin/reviews";
    }
}