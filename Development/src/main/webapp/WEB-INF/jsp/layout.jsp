<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle} - Bakery &amp; Custom Cake Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<c:choose>

    <%-- Auth Pages (login, register) --%>

    <c:when test="${isAuthPage eq true}">
        <div class="auth-wrapper">
            <jsp:include page="${contentPage}" />
        </div>
    </c:when>


    <%-- Main App Pages --%>

    <c:otherwise>
        <div class="app-layout">

            
            <%-- Customer Sidebar --%>
            
            <c:if test="${sessionScope.userRole eq 'CUSTOMER'}">
                <aside class="sidebar" id="sidebar">
                    <div class="sidebar-brand">
                        <h2>Bakery &amp; Custom Cake Booking</h2>
                        <p>Customer Portal</p>
                    </div>
                    <nav class="sidebar-nav">
                        <span class="nav-section-label">Main</span>
                        <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
                                <rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
                            </svg>
                            Dashboard
                        </a>

                        <span class="nav-section-label">Shop</span>
                        <a href="${pageContext.request.contextPath}/products/items" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/>
                                <path d="M16 10a4 4 0 01-8 0"/>
                            </svg>
                            Browse Products
                        </a>
                        <a href="${pageContext.request.contextPath}/custom-cakes" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                            </svg>
                            Custom Cake Booking
                        </a>

                        <span class="nav-section-label">My Account</span>
                        <a href="${pageContext.request.contextPath}/orders" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/>
                                <line x1="16" y1="13" x2="8" y2="13"/><line x1="16" y1="17" x2="8" y2="17"/>
                            </svg>
                            My Orders
                        </a>
                        <a href="${pageContext.request.contextPath}/payments" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/>
                            </svg>
                            My Payments
                        </a>

                        <a href="${pageContext.request.contextPath}/cart" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <circle cx="9" cy="21" r="1"/><circle cx="20" cy="21" r="1"/>
                                <path d="M1 1h4l2.68 13.39a2 2 0 002 1.61h9.72a2 2 0 002-1.61L23 6H6"/>
                            </svg>
                            Shopping Cart
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/reviews" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/>
                            </svg>
                            Browse Reviews
                        </a>
                        
                        <a href="${pageContext.request.contextPath}/reviews/submit" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M11 4H4a2 2 0 00-2 2v14a2 2 0 002 2h14a2 2 0 002-2v-7"/>
                                <path d="M18.5 2.5a2.121 2.121 0 013 3L12 15l-4 1 1-4 9.5-9.5z"/>
                            </svg>
                            Submit Review
                        </a>

                        <a href="${pageContext.request.contextPath}/profile" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M20 21v-2a4 4 0 00-4-4H8a4 4 0 00-4 4v2"/><circle cx="12" cy="7" r="4"/>
                            </svg>
                            My Profile
                        </a>
                    </nav>
                    <div class="sidebar-footer">
                        <div class="sidebar-user">
                            <strong>${sessionScope.customerUsername}</strong>
                            Customer Account
                        </div>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-full btn-sm">Sign Out</a>
                    </div>
                </aside>
            </c:if>

            <%-- Admin Sidebar  --%>
            
            <c:if test="${sessionScope.userRole eq 'ADMIN'}">
                <aside class="sidebar" id="sidebar">
                    <div class="sidebar-brand">
                        <h2>Bakery &amp; Custom Cake Booking</h2>
                        <p>Administration Panel</p>
                    </div>
                    <nav class="sidebar-nav">
                        <span class="nav-section-label">Overview</span>
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3" width="7" height="7"/>
                                <rect x="14" y="14" width="7" height="7"/><rect x="3" y="14" width="7" height="7"/>
                            </svg>
                            Dashboard
                        </a>

                        <span class="nav-section-label">Management</span>
                        <a href="${pageContext.request.contextPath}/admin/customers" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/><circle cx="9" cy="7" r="4"/>
                                <path d="M23 21v-2a4 4 0 00-3-3.87"/><path d="M16 3.13a4 4 0 010 7.75"/>
                            </svg>
                            Customer Management
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/products" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M6 2L3 6v14a2 2 0 002 2h14a2 2 0 002-2V6l-3-4z"/><line x1="3" y1="6" x2="21" y2="6"/>
                                <path d="M16 10a4 4 0 01-8 0"/>
                            </svg>
                            Product Management
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/orders" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M14 2H6a2 2 0 00-2 2v16a2 2 0 002 2h12a2 2 0 002-2V8z"/><polyline points="14 2 14 8 20 8"/>
                            </svg>
                            Order Management
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/custom-cakes" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
                            </svg>
                            Custom Cake Orders
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/payments" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <rect x="1" y="4" width="22" height="16" rx="2" ry="2"/><line x1="1" y1="10" x2="23" y2="10"/>
                            </svg>
                            Payment Management
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/reviews" class="nav-item">
                            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <path d="M21 15a2 2 0 01-2 2H7l-4 4V5a2 2 0 012-2h14a2 2 0 012 2z"/>
                            </svg>
                            Review Moderation
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
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline btn-full btn-sm">Sign Out</a>
                    </div>
                </aside>
            </c:if>

            <div class="sidebar-overlay" id="sidebarOverlay"></div>

            
            <%--  Main Content Area  --%>
            <div class="main-content">
                <header class="topbar">
                    <button class="burger-btn" id="burgerBtn" aria-label="Toggle menu">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <line x1="3" y1="6" x2="21" y2="6"/>
                            <line x1="3" y1="12" x2="21" y2="12"/>
                            <line x1="3" y1="18" x2="21" y2="18"/>
                        </svg>
                    </button>
                    <span class="topbar-title">${pageTitle}</span>
                    <div class="topbar-right">
                        <c:choose>
                            <c:when test="${sessionScope.userRole eq 'CUSTOMER'}">
                                Welcome, <strong>${sessionScope.customerUsername}</strong>
                            </c:when>
                            <c:when test="${sessionScope.userRole eq 'ADMIN'}">
                                <strong>${sessionScope.adminUsername}</strong>
                            </c:when>
                        </c:choose>
                    </div>
                </header>
                <main class="page-content">
                    <jsp:include page="${contentPage}" />
                </main>
            </div>

        </div>
    </c:otherwise>
</c:choose>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
</body>
</html>