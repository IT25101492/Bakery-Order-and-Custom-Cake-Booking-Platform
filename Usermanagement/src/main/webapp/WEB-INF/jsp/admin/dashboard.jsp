<%-- admin/dashboard.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Dashboard</h1>
    <p>User Management Overview - Bakery &amp; Custom Cake Booking Platform</p>
</div>

<div class="stats-grid">
    <div class="stat-card accent">
        <p class="stat-label">Total Registered Customers</p>
        <p class="stat-value">${totalCustomers}</p>
        <p class="stat-sub">Active accounts in the system</p>
    </div>
    <div class="stat-card success">
        <p class="stat-label">New Registrations Today</p>
        <p class="stat-value">${newCustomersToday}</p>
        <p class="stat-sub">Registered in the last 24 hours</p>
    </div>
    <div class="stat-card">
        <p class="stat-label">Admin Account</p>
        <p class="stat-value" style="font-size:1.2rem;padding-top:0.4rem;">${sessionScope.adminUsername}</p>
        <p class="stat-sub">${sessionScope.department} Department</p>
    </div>
    <div class="stat-card info">
        <p class="stat-label">Access Level</p>
        <p class="stat-value" style="font-size:1.2rem;padding-top:0.4rem;">
            <c:choose>
                <c:when test="${sessionScope.adminLevel == 2}">Super Admin</c:when>
                <c:otherwise>Administrator</c:otherwise>
            </c:choose>
        </p>
        <p class="stat-sub">System privileges</p>
    </div>
</div>

<div class="card">
    <div class="card-header"><h2>Quick Actions</h2></div>
    <div class="d-flex gap-1 flex-wrap">
        <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-primary">View All Customers</a>
        <a href="${pageContext.request.contextPath}/admin/customers?action=add" class="btn btn-secondary">Add New Customer</a>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">Manage Products</a>
    </div>
</div>