<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="jakarta.tags.core" %>
        <%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

            <div class="page-header">
                <h1 class="page-title">What Our <span>Customers</span> Say</h1>
                <p class="page-subtitle">
                    <c:choose>
                        <c:when test="${not empty reviews}">
                            ${fn:length(reviews)} verified review<c:if test="${fn:length(reviews) != 1}">s</c:if> from
                            happy customers
                        </c:when>
                        <c:otherwise>No reviews yet — be the first!</c:otherwise>
                    </c:choose>
                </p>
            </div>

            <!-- Flash Messages -->
            <c:if test="${not empty successMsg}">
                <div class="flash flash-success">${successMsg}</div>
            </c:if>

            <!-- Reviews Grid -->
            <c:choose>
                <c:when test="${empty reviews}">
                    <div class="empty-state">
                        <p>No approved reviews yet.</p>
                        <br />
                        <a href="${pageContext.request.contextPath}/reviews/submit" class="btn btn-primary">Be the First
                            to Review</a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="reviews-grid">
                        <c:forEach var="review" items="${reviews}" varStatus="loop">
                            <article class="card review-card animate-up">

                                <div class="review-card-header">
                                    <div class="reviewer-info">
                                        <div class="reviewer-name">${review.customerName}</div>
                                        <div class="reviewer-email">${review.customerEmail}</div>
                                    </div>
                                    <div class="review-meta">
                                        <c:choose>
                                            <c:when test="${review.reviewType == 'PRODUCT'}">
                                                <span class="badge badge-product">Product</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-service">Service</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="stars-display" aria-label="Rating: ${review.rating} out of 5">
                                    <c:forEach begin="1" end="5" var="s">
                                        <c:choose>
                                            <c:when test="${s <= review.rating}">
                                                <span class="star-filled">★</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="star-empty">★</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>

                                <p class="review-comment">"${review.comment}"</p>

                                <div class="review-footer">
                                    <div class="review-extra">
                                        <c:choose>
                                            <c:when test="${review.reviewType == 'PRODUCT'}">
                                                <strong>${review.productName}</strong>
                                            </c:when>
                                            <c:otherwise>
                                                <strong>${review.serviceType}</strong>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <c:if test="${review.verified}">
                                        <span class="verified-badge">✔ Verified</span>
                                    </c:if>
                                </div>

                                <div class="review-date" style="margin-top:0.6rem;">
                                    <span data-date="${review.createdAt}">${review.createdAt}</span>
                                </div>

                            </article>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>

            <div style="text-align:center; margin-top:3rem;">
                <a href="${pageContext.request.contextPath}/reviews/submit" class="btn btn-primary">
                    Write a Review
                </a>
            </div>