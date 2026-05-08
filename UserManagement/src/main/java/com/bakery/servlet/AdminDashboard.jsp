<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — Bakery &amp; Custom Cake Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="app-layout">

    <!-- Admin Sidebar -->
    <aside class="sidebar" id="sidebar">
        <div class="sidebar-brand">
            <h2>Bakery &amp; Custom Cake Booking</h2>
            <p>Administration Panel</p>
        </div>

        <nav class="sidebar-nav">
            <span class="nav-section-label">Administration</span>

            <a href="${pageContext.request.contextPath}/admin/dashboard"
               class="nav-item active">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <rect x="3" y="3" width="7" height="7"/>
                    <rect x="14" y="3" width="7" height="7"/>
                    <rect x="14" y="14" width="7" height="7"/>
                    <rect x="3" y="14" width="7" height="7"/>
                </svg>
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/admin/customers"
               class="nav-item">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                    <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                </svg>
                Customer Management
            </a>
        </nav>

        <div class="sidebar-footer">
            <div class="sidebar-user">
                <strong>${sessionScope.adminUsername}</strong>
                ${sessionScope.department} &mdash;
                <c:choose>
                    <c:when test="${sessionScope.adminLevel == 2}">Super Admin</c:when>
                    <c:otherwise>Administrator</c:otherwise>
                </c:choose>
            </div>
            <a href="${pageContext.request.contextPath}/logout"
               class="btn btn-outline btn-full btn-sm">Sign Out</a>
        </div>
    </aside>

    <div class="sidebar-overlay" id="sidebarOverlay"></div>

    <div class="main-content">
        <header class="topbar">
            <button class="burger-btn" id="burgerBtn" aria-label="Toggle menu">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <line x1="3" y1="6"  x2="21" y2="6"/>
                    <line x1="3" y1="12" x2="21" y2="12"/>
                    <line x1="3" y1="18" x2="21" y2="18"/>
                </svg>
            </button>
            <span class="topbar-title">Administration Dashboard</span>
            <div class="topbar-right">
                <strong>${sessionScope.adminUsername}</strong>
            </div>
        </header>

        <main class="page-content">

            <div class="page-header">
                <h1>Dashboard</h1>
                <p>User Management Overview — Bakery &amp; Custom Cake Booking Platform</p>
            </div>

            <!-- Statistics -->
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
                    <p class="stat-value" style="font-size:1.2rem;padding-top:0.4rem;">
                        ${sessionScope.adminUsername}
                    </p>
                    <p class="stat-sub">${sessionScope.department} Department</p>
                </div>
                <div class="stat-card info">
                    <p class="stat-label">Access Level</p>
                    <p class="stat-value" style="font-size:1.2rem;padding-top:0.4rem;">
                        <c:choose>
                            <c:when test="${sessionScope.adminLevel == 2}">
                                Super Admin
                            </c:when>
                            <c:otherwise>Administrator</c:otherwise>
                        </c:choose>
                    </p>
                    <p class="stat-sub">System privileges</p>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card">
                <div class="card-header">
                    <h2>Quick Actions</h2>
                </div>
                <div class="d-flex gap-1 flex-wrap">
                    <a href="${pageContext.request.contextPath}/admin/customers"
                       class="btn btn-primary">
                        View All Customers
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/customers?action=add"
                       class="btn btn-secondary">
                        Add New Customer
                    </a>
                </div>
            </div>

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>