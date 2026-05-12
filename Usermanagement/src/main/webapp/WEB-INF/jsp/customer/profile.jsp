<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — Bakery &amp; Custom Cake Booking</title>
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
            <a href="${pageContext.request.contextPath}/dashboard" class="nav-item">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <rect x="3" y="3" width="7" height="7"/><rect x="14" y="3"
                    width="7" height="7"/><rect x="14" y="14" width="7"
                    height="7"/><rect x="3" y="14" width="7" height="7"/>
                </svg>
                Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/profile"
               class="nav-item active">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
                    <circle cx="12" cy="7" r="4"/>
                </svg>
                My Profile
            </a>
            <a href="${pageContext.request.contextPath}/profile" class="nav-item">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none"
                     stroke="currentColor" stroke-width="2">
                    <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0
                             2-2v-7"/><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3
                             L12 15l-4 1 1-4 9.5-9.5z"/>
                </svg>
                Edit Profile
            </a>
            <a href="#change-password" class="nav-item">
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
            <span class="topbar-title">My Profile</span>
            <div class="topbar-right">
                <strong>${sessionScope.customerUsername}</strong>
            </div>
        </header>

        <main class="page-content">

            <div class="page-header">
                <h1>My Profile</h1>
                <p>Manage your personal information and account settings.</p>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success">${successMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <!-- Profile Update Form -->
            <form action="${pageContext.request.contextPath}/profile"
                  method="post" novalidate id="profileForm">

                <!-- Personal Info -->
                <div class="card">
                    <div class="card-header">
                        <h2>Personal Information</h2>
                    </div>

                    <p class="form-section-title">Account Details</p>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="username">Username</label>
                            <input type="text" id="username" name="username"
                                   class="form-control"
                                   value="<c:out value='${customer.username}'/>"
                                   maxlength="50" required>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="email">Email Address</label>
                            <input type="email" id="email" name="email"
                                   class="form-control"
                                   value="<c:out value='${customer.email}'/>"
                                   maxlength="100" required>
                        </div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="phoneNumber">Phone Number</label>
                            <input type="tel" id="phoneNumber" name="phoneNumber"
                                   class="form-control"
                                   value="<c:out value='${customer.phoneNumber}'/>"
                                   maxlength="20">
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="deliveryAddress">
                                Delivery Address
                            </label>
                            <textarea id="deliveryAddress" name="deliveryAddress"
                                      class="form-control" rows="2"
                                      maxlength="255"><c:out value='${customer.deliveryAddress}'/></textarea>
                        </div>
                    </div>
                </div>

                <!-- Change Password -->
                <div class="card" id="change-password">
                    <div class="card-header">
                        <h2>Change Password</h2>
                    </div>
                    <p class="text-muted mb-2">
                        Leave blank if you do not wish to change your password.
                    </p>

                    <div class="form-row">
                        <div class="form-group">
                            <label class="form-label" for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword"
                                   class="form-control"
                                   placeholder="Enter new password"
                                   maxlength="100">
                            <span class="form-hint">
                                Min. 8 chars with uppercase, number &amp; special character.
                            </span>
                        </div>
                        <div class="form-group">
                            <label class="form-label" for="confirmPassword">
                                Confirm New Password
                            </label>
                            <input type="password" id="confirmPassword"
                                   name="confirmPassword"
                                   class="form-control"
                                   placeholder="Re-enter new password"
                                   maxlength="100">
                        </div>
                    </div>
                </div>

                <div class="d-flex gap-1">
                    <button type="submit" class="btn btn-primary">
                        Save Changes
                    </button>
                    <a href="${pageContext.request.contextPath}/dashboard"
                       class="btn btn-outline">
                        Cancel
                    </a>
                </div>

            </form>
        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
<script>
    document.getElementById('profileForm').addEventListener('submit', function(e) {
        const newPwd = document.getElementById('newPassword').value;
        const confirm= document.getElementById('confirmPassword').value;

        if (newPwd) {
            const pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
            if (!pwdRegex.test(newPwd)) {
                e.preventDefault();
                alert('Password must be at least 8 characters with an uppercase letter, number, and special character.');
                return;
            }
            if (newPwd !== confirm) {
                e.preventDefault();
                alert('Passwords do not match.');
            }
        }
    });
</script>

</body>
</html>