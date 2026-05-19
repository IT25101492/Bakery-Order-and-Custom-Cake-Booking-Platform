<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<div class="page-header">
    <h1 class="page-title">Admin <span>Moderation</span></h1>
    <p class="page-subtitle">Review, approve, reject or remove customer submissions</p>
</div>

<c:if test="${not empty successMsg}">
    <div class="flash flash-success">${successMsg}</div>
</c:if>
<c:if test="${not empty errorMsg}">
    <div class="flash flash-error">${errorMsg}</div>
</c:if>

<!-- Stats Row -->
<div class="stats-row">
    <div class="stat-card">
        <div class="stat-number">${fn:length(allReviews)}</div>
        <div class="stat-label">Total Reviews</div>
    </div>
    <div class="stat-card">
        <div class="stat-number" style="color:#b08600;">${pendingCount}</div>
        <div class="stat-label">Awaiting Review</div>
    </div>
    <div class="stat-card">
        <div class="stat-number" style="color:var(--success);">${approvedCount}</div>
        <div class="stat-label">Approved</div>
    </div>
</div>

<!-- Pending Reviews -->
<h2 class="section-heading">⏳ Pending Approval</h2>

<c:choose>
    <c:when test="${empty pendingReviews}">
        <div class="empty-state" style="padding: 2.5rem;">
            <div class="empty-icon">🎉</div>
            <p>All caught up — no pending reviews!</p>
        </div>
    </c:when>
    <c:otherwise>
        <div class="table-wrapper">
            <table class="review-table">
                <thead>
                    <tr>
                        <th>Customer</th>
                        <th>Type</th>
                        <th>Product / Service</th>
                        <th>Rating</th>
                        <th>Comment</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="r" items="${pendingReviews}">
                        <tr>
                            <td>
                                <strong>${r.customerName}</strong><br/>
                                <small style="color:var(--text-muted);">${r.customerEmail}</small>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.reviewType == 'PRODUCT'}">
                                        <span class="badge badge-product">Product</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-service">Service</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${r.reviewType == 'PRODUCT'}">${r.productName}</c:when>
                                    <c:otherwise>${r.serviceType}</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <span class="rating-sm">
                                    <c:forEach begin="1" end="${r.rating}" var="s">★</c:forEach>
                                </span>
                                <small style="color:var(--text-muted);"> ${r.rating}/5</small>
                            </td>
                            <td class="comment-cell" title="${r.comment}">"${r.comment}"</td>
                            <td>
                                <span data-date="${r.createdAt}" style="font-size:0.8rem;color:var(--text-muted);">${r.createdAt}</span>
                            </td>
                            <td>
                                <div class="action-group">
                                    <form action="${pageContext.request.contextPath}/admin/reviews/${r.id}/approve" method="post">
                                        <button type="submit" class="btn btn-success btn-sm">✔ Approve</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/reviews/${r.id}/reject" method="post">
                                        <button type="submit" class="btn btn-warning btn-sm">✘ Reject</button>
                                    </form>
                                    <form action="${pageContext.request.contextPath}/admin/reviews/${r.id}/delete" method="post"
                                          data-confirm="Permanently delete this review?">
                                        <button type="submit" class="btn btn-danger btn-sm">🗑 Delete</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </c:otherwise>
</c:choose>

<!-- All Reviews -->
<div class="all-reviews-section">
    <h2 class="section-heading">📋 All Reviews</h2>
    <c:choose>
        <c:when test="${empty allReviews}">
            <div class="empty-state" style="padding: 2rem;">
                <p>No reviews in the system yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="table-wrapper">
                <table class="review-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Type</th>
                            <th>Product / Service</th>
                            <th>Rating</th>
                            <th>Status</th>
                            <th>Verified</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="r" items="${allReviews}">
                            <tr>
                                <td style="color:var(--text-muted);font-size:0.8rem;">#${r.id}</td>
                                <td><strong>${r.customerName}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.reviewType == 'PRODUCT'}">
                                            <span class="badge badge-product">Product</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-service">Service</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.reviewType == 'PRODUCT'}">${r.productName}</c:when>
                                        <c:otherwise>${r.serviceType}</c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <span class="rating-sm">
                                        <c:forEach begin="1" end="${r.rating}" var="s">★</c:forEach>
                                    </span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.status == 'PENDING'}">
                                            <span class="badge badge-pending">Pending</span>
                                        </c:when>
                                        <c:when test="${r.status == 'APPROVED'}">
                                            <span class="badge badge-approved">Approved</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge badge-rejected">Rejected</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${r.verified}">
                                            <span style="color:var(--success);">✔</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color:var(--text-muted);">—</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="action-group">
                                        <form action="${pageContext.request.contextPath}/admin/reviews/${r.id}/delete" method="post"
                                              data-confirm="Permanently delete review #${r.id}?">
                                            <button type="submit" class="btn btn-danger btn-sm">🗑 Delete</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>
</div>