<%-- customer/dashboard.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Welcome back, ${sessionScope.customerUsername}</h1>
    <p>Here is an overview of your account.</p>
</div>

<div class="card">
    <div class="card-header">
        <h2>Account Summary</h2>
        <span class="badge badge-active">Active</span>
    </div>

    <div class="form-row">
        <div>
            <p class="form-label">Username</p>
            <p><c:out value="${customer.username}"/></p>
        </div>
        <div>
            <p class="form-label">Email Address</p>
            <p><c:out value="${customer.email}"/></p>
        </div>
    </div>

    <div class="form-row mt-2">
        <div>
            <p class="form-label">Phone Number</p>
            <p>
                <c:choose>
                    <c:when test="${not empty customer.phoneNumber}">
                        <c:out value="${customer.phoneNumber}"/>
                    </c:when>
                    <c:otherwise><span class="text-muted">Not provided</span></c:otherwise>
                </c:choose>
            </p>
        </div>
        <div>
            <p class="form-label">Loyalty Points</p>
            <p><strong>${customer.loyaltyPoints}</strong> pts</p>
        </div>
    </div>

    <div class="form-row mt-2">
        <div>
            <p class="form-label">Delivery Address</p>
            <p>
                <c:choose>
                    <c:when test="${not empty customer.deliveryAddress}">
                        <c:out value="${customer.deliveryAddress}"/>
                    </c:when>
                    <c:otherwise><span class="text-muted">Not provided</span></c:otherwise>
                </c:choose>
            </p>
        </div>
        <div>
            <p class="form-label">Member Since</p>
            <p>${customer.formattedRegistrationDate}</p>
        </div>
    </div>

    <div class="mt-3">
        <a href="${pageContext.request.contextPath}/profile" class="btn btn-primary btn-sm">Edit Profile</a>
    </div>
</div>