<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1 class="page-title">Share Your <span>Experience</span></h1>
    <p class="page-subtitle">Your feedback helps us serve you better — thank you!</p>
</div>

<c:if test="${not empty successMsg}">
    <div class="flash flash-success">${successMsg}</div>
</c:if>
<c:if test="${not empty errorMsg}">
    <div class="flash flash-error">${errorMsg}</div>
</c:if>

<div class="tabs">
    <button class="tab-btn active" data-tab="tab-product" id="btn-product">Product Review</button>
    <button class="tab-btn" data-tab="tab-service" id="btn-service">Service Review</button>
</div>

<!-- Product Review Tab -->
<div id="tab-product" class="tab-pane active">
    <div class="form-card">
        <h2 class="section-heading">Product Review</h2>
        <form id="form-product" action="${pageContext.request.contextPath}/reviews/submit/product" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="pCustomerName">Your Name</label>
                    <input id="pCustomerName" class="form-control" type="text"
                           name="customerName" placeholder="e.g. Alice Fernando" required/>
                </div>
                <div class="form-group">
                    <label class="form-label" for="pCustomerEmail">Email Address</label>
                    <input id="pCustomerEmail" class="form-control" type="email"
                           name="customerEmail" placeholder="you@example.com" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="pProductName">Product Name</label>
                <input id="pProductName" class="form-control" type="text"
                       name="productName" placeholder="e.g. Chocolate Fudge Cake" required/>
            </div>
            <div class="form-group">
                <label class="form-label">Your Rating</label>
                <div class="star-rating-input" id="star-product">
                    <input type="radio" name="rating" id="ps5" value="5"/><label for="ps5" title="Excellent">★</label>
                    <input type="radio" name="rating" id="ps4" value="4"/><label for="ps4" title="Very Good">★</label>
                    <input type="radio" name="rating" id="ps3" value="3"/><label for="ps3" title="Good">★</label>
                    <input type="radio" name="rating" id="ps2" value="2"/><label for="ps2" title="Fair">★</label>
                    <input type="radio" name="rating" id="ps1" value="1"/><label for="ps1" title="Poor">★</label>
                </div>
                <p class="rating-hint">Click a star to rate</p>
            </div>
            <div class="form-group">
                <label class="form-label" for="pComment">Your Review</label>
                <textarea id="pComment" class="form-control" name="comment"
                          placeholder="Tell us what you loved about this product…" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-full">Submit Product Review →</button>
        </form>
    </div>
</div>

<!-- Service Review Tab -->
<div id="tab-service" class="tab-pane">
    <div class="form-card">
        <h2 class="section-heading">Service Review</h2>
        <form id="form-service" action="${pageContext.request.contextPath}/reviews/submit/service" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="sCustomerName">Your Name</label>
                    <input id="sCustomerName" class="form-control" type="text"
                           name="customerName" placeholder="e.g. Kasun Bandara" required/>
                </div>
                <div class="form-group">
                    <label class="form-label" for="sCustomerEmail">Email Address</label>
                    <input id="sCustomerEmail" class="form-control" type="email"
                           name="customerEmail" placeholder="you@example.com" required/>
                </div>
            </div>
            <div class="form-group">
                <label class="form-label" for="sServiceType">Service Type</label>
                <select id="sServiceType" class="form-control" name="serviceType" required>
                    <option value="" disabled selected>Select a service…</option>
                    <option value="DELIVERY">Delivery</option>
                    <option value="CUSTOM_CAKE">Custom Cake Order</option>
                    <option value="IN_STORE">In-Store Experience</option>
                </select>
            </div>
            <div class="form-group">
                <label class="form-label">Your Rating</label>
                <div class="star-rating-input" id="star-service">
                    <input type="radio" name="rating" id="ss5" value="5"/><label for="ss5" title="Excellent">★</label>
                    <input type="radio" name="rating" id="ss4" value="4"/><label for="ss4" title="Very Good">★</label>
                    <input type="radio" name="rating" id="ss3" value="3"/><label for="ss3" title="Good">★</label>
                    <input type="radio" name="rating" id="ss2" value="2"/><label for="ss2" title="Fair">★</label>
                    <input type="radio" name="rating" id="ss1" value="1"/><label for="ss1" title="Poor">★</label>
                </div>
                <p class="rating-hint">Click a star to rate</p>
            </div>
            <div class="form-group">
                <label class="form-label" for="sComment">Your Review</label>
                <textarea id="sComment" class="form-control" name="comment"
                          placeholder="How was your experience with this service…" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary btn-full">Submit Service Review →</button>
        </form>
    </div>
</div>