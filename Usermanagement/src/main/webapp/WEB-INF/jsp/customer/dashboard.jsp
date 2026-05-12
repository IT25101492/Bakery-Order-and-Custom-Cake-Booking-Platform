<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Bakery &amp; Custom Cake Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="app-layout">

    <!-- Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h2>Bakery &amp; Custom Cake Booking</h2>
            <p>Customer Portal</p>
        </div>

        <nav class="sidebar-nav">
            <span class="nav-section-label">Main</span>

            <a href="${pageContext.request.contextPath}/dashboard"
               class="nav-item active">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3"
                    width="7" height="7"/><rect x="14" y="14" width="7"
                    height="7"/><rect x="3" y="14" width="7" height="7"/>
                </svg>
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/profile"
               class="nav-item">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                    <circle cx="12" cy="7" r="4"/>
                </svg>
                My Profile
            </a>

            <a href="${pageContext.request.contextPath}/profile"
               class="nav-item">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0
                             2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3
                             L12 15l-4 1 1-4 9.5-9.5z"/>
                </svg>
                Edit Profile
            </a>

            <a href="${pageContext.request.contextPath}/profile#change-password"
               class="nav-item">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                </svg>
                Change Password
            </a>
        </nav>

        <div class="sidebar-footer">
            <div class="sidebar-user">
                <strong>${sessionScope.customerUsername}</strong>
                Customer Account
            </div>
            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-outline btn-full btn-sm">
                Sign Out
            </a>
        </div>
    </aside>

    <!-- Overlay for mobile -->
    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <!-- Main Content -->
    <div class="main-content">

        <!-- Top Bar -->
        <header class="topbar">
            <button class="burger-btn" id="burgerBtn" aria-label="Toggle menu">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <line x1="3" y1="6"  x2="21" y2="6"/>
                    <line x1="3" y1="12" x2="21" y2="12"/>
                    <line x1="3" y1="18" x2="21" y2="18"/>
                </svg>
            </button>
            <span class="topbar-title">Dashboard</span>
            <div class="topbar-right">
                Welcome, <strong>${sessionScope.customerUsername}</strong>
            </div>
        </header>

        <!-- Page Content -->
        <main class="page-content">

            <div class="page-header">
                <h1>Welcome back, ${sessionScope.customerUsername}</h1>
                <p>Here is an overview of your account.</p>
            </div>

            <!-- Account Summary Card -->
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
                                <c:otherwise>
                                    <span class="text-muted">Not provided</span>
                                </c:otherwise>
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
                                <c:otherwise>
                                    <span class="text-muted">Not provided</span>
                                </c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div>
                        <p class="form-label">Member Since</p>
                        <p>
                            <fmt:formatDate
                                value="${customer.registrationDate}"
                                pattern="dd MMM yyyy"
                                type="date"/>
                        </p>
                    </div>
                </div>

                <div class="mt-3">
                    <a href="${pageContext.request.contextPath}/profile"
                       class="btn btn-primary btn-sm">
                        Edit Profile
                    </a>
                </div>
            </div>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>