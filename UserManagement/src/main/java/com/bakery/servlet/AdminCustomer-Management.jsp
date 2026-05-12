<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Management — Bakery &amp; Custom Cake Booking</title>
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
               class="nav-item">
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
               class="nav-item active">
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
            <span class="topbar-title">Customer Management</span>
            <div class="topbar-right">
                <strong>${sessionScope.adminUsername}</strong>
            </div>
        </header>

        <main class="page-content">

            <div class="page-header">
                <h1>Customer Management</h1>
                <p>Create, view, update and delete customer accounts.</p>
            </div>

            <!-- Alerts -->
            <c:if test="${not empty param.successMessage}">
                <div class="alert alert-success">${param.successMessage}</div>
            </c:if>
            <c:if test="${not empty param.errorMessage}">
                <div class="alert alert-danger">${param.errorMessage}</div>
            </c:if>
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger">${errorMessage}</div>
            </c:if>

            <!-- Add Customer Form -->
            <c:if test="${action == 'add'}">
                <div class="card">
                    <div class="card-header">
                        <h2>Add New Customer</h2>
                        <a href="${pageContext.request.contextPath}/admin/customers"
                           class="btn btn-outline btn-sm">Back to List</a>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/customers"
                          method="post" novalidate id="addForm">
                        <input type="hidden" name="action" value="add">

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="addUsername">
                                    Username *
                                </label>
                                <input type="text" id="addUsername" name="username"
                                       class="form-control"
                                       placeholder="e.g. john_doe"
                                       required maxlength="50">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="addEmail">
                                    Email Address *
                                </label>
                                <input type="email" id="addEmail" name="email"
                                       class="form-control"
                                       placeholder="e.g. john@example.com"
                                       required maxlength="100">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="addPassword">
                                    Password *
                                </label>
                                <input type="password" id="addPassword" name="password"
                                       class="form-control"
                                       placeholder="Min. 8 chars, uppercase, number, special char"
                                       required maxlength="100">
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="addPhone">Phone Number</label>
                                <input type="tel" id="addPhone" name="phoneNumber"
                                       class="form-control"
                                       placeholder="e.g. +1-555-0101"
                                       maxlength="20">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="addAddress">
                                Delivery Address
                            </label>
                            <textarea id="addAddress" name="deliveryAddress"
                                      class="form-control" rows="2"
                                      placeholder="Enter delivery address"
                                      maxlength="255"></textarea>
                        </div>

                        <div class="d-flex gap-1">
                            <button type="submit" class="btn btn-primary">
                                Add Customer
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/customers"
                               class="btn btn-outline">Cancel</a>
                        </div>
                    </form>
                </div>
            </c:if>

            <!-- Edit Customer Form -->
            <c:if test="${action == 'edit' and not empty editCustomer}">
                <div class="card">
                    <div class="card-header">
                        <h2>Edit Customer — #${editCustomer.userId}</h2>
                        <a href="${pageContext.request.contextPath}/admin/customers"
                           class="btn btn-outline btn-sm">Back to List</a>
                    </div>

                    <form action="${pageContext.request.contextPath}/admin/customers"
                          method="post" novalidate id="editForm">
                        <input type="hidden" name="action"     value="update">
                        <input type="hidden" name="customerId" value="${editCustomer.userId}">

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="editUsername">Username</label>
                                <input type="text" id="editUsername" name="username"
                                       class="form-control"
                                       value="<c:out value='${editCustomer.username}'/>"
                                       maxlength="50" required>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="editEmail">Email Address</label>
                                <input type="email" id="editEmail" name="email"
                                       class="form-control"
                                       value="<c:out value='${editCustomer.email}'/>"
                                       maxlength="100" required>
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label class="form-label" for="editPassword">
                                    New Password
                                </label>
                                <input type="password" id="editPassword" name="password"
                                       class="form-control"
                                       placeholder="Leave blank to keep current password"
                                       maxlength="100">
                                <span class="form-hint">
                                    Leave blank to keep the existing password.
                                </span>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="editPhone">Phone Number</label>
                                <input type="tel" id="editPhone" name="phoneNumber"
                                       class="form-control"
                                       value="<c:out value='${editCustomer.phoneNumber}'/>"
                                       maxlength="20">
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="editAddress">
                                Delivery Address
                            </label>
                            <textarea id="editAddress" name="deliveryAddress"
                                      class="form-control" rows="2"
                                      maxlength="255"><c:out value='${editCustomer.deliveryAddress}'/></textarea>
                        </div>

                        <div class="d-flex gap-1">
                            <button type="submit" class="btn btn-primary">
                                Save Changes
                            </button>
                            <a href="${pageContext.request.contextPath}/admin/customers"
                               class="btn btn-outline">Cancel</a>
                        </div>
                    </form>
                </div>
            </c:if>

            <!-- Customer List Table -->
            <div class="card">
                <div class="card-header">
                    <h2>
                        Customer List
                        <c:if test="${not empty searchTerm}">
                            — Results for "<c:out value='${searchTerm}'/>"
                        </c:if>
                    </h2>

                    <div class="d-flex gap-1 align-center flex-wrap">
                        <!-- Search Form -->
                        <form action="${pageContext.request.contextPath}/admin/customers"
                              method="get" class="search-bar">
                            <input type="text" name="search" class="form-control"
                                   placeholder="Search by username or email"
                                   value="<c:out value='${searchTerm}'/>">
                            <button type="submit" class="btn btn-outline btn-sm">
                                Search
                            </button>
                            <c:if test="${not empty searchTerm}">
                                <a href="${pageContext.request.contextPath}/admin/customers"
                                   class="btn btn-outline btn-sm">Clear</a>
                            </c:if>
                        </form>

                        <a href="${pageContext.request.contextPath}/admin/customers?action=add"
                           class="btn btn-primary btn-sm">
                            Add Customer
                        </a>
                    </div>
                </div>

                <c:choose>
                    <c:when test="${empty customers}">
                        <p class="text-muted text-center" style="padding: 2rem 0;">
                            No customers found.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-wrapper">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Username</th>
                                        <th>Email</th>
                                        <th>Phone</th>
                                        <th>Delivery Address</th>
                                        <th>Loyalty Pts</th>
                                        <th>Registered</th>
                                        <th>Status</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="cust" items="${customers}">
                                        <tr>
                                            <td class="td-muted">#${cust.userId}</td>
                                            <td><strong><c:out value="${cust.username}"/></strong></td>
                                            <td><c:out value="${cust.email}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty cust.phoneNumber}">
                                                        <c:out value="${cust.phoneNumber}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="td-muted">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="max-width:180px; white-space:nowrap;
                                                       overflow:hidden; text-overflow:ellipsis;">
                                                <c:choose>
                                                    <c:when test="${not empty cust.deliveryAddress}">
                                                        <c:out value="${cust.deliveryAddress}"/>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="td-muted">—</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>${cust.loyaltyPoints}</td>
                                            <td class="td-muted">
                                                <fmt:formatDate
                                                    value="${cust.registrationDate}"
                                                    pattern="dd MMM yyyy"/>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${cust.active}">
                                                        <span class="badge badge-active">Active</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge badge-inactive">
                                                            Inactive
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div class="d-flex gap-1">
                                                    <!-- EDIT action -->
                                                    <a href="${pageContext.request.contextPath}/admin/customers?action=edit&id=${cust.userId}"
                                                       class="btn btn-secondary btn-sm">
                                                        Edit
                                                    </a>
                                                    <!-- DELETE action with confirmation -->
                                                    <a href="${pageContext.request.contextPath}/admin/customers?action=delete&id=${cust.userId}"
                                                       class="btn btn-danger btn-sm"
                                                       onclick="return confirm('Are you sure you want to permanently delete this customer account? This action cannot be undone.');">
                                                        Delete
                                                    </a>
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

        </main>
    </div>
</div>

<script src="${pageContext.request.contextPath}/js/sidebar.js"></script>
<script>
    // Client-side validation for Add Customer form
    const addForm = document.getElementById('addForm');
    if (addForm) {
        addForm.addEventListener('submit', function(e) {
            const pwd = document.getElementById('addPassword').value;
            const pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
            if (!pwdRegex.test(pwd)) {
                e.preventDefault();
                alert('Password must be 8+ characters with uppercase, number, and special character.');
            }
        });
    }

    // Client-side validation for Edit Customer form
    const editForm = document.getElementById('editForm');
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            const pwd = document.getElementById('editPassword').value;
            if (pwd) {
                const pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
                if (!pwdRegex.test(pwd)) {
                    e.preventDefault();
                    alert('Password must be 8+ characters with uppercase, number, and special character.');
                }
            }
        });
    }
</script>

</body>
</html>