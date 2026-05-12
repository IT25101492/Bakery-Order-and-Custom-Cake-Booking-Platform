<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Custom Orders - Bakery</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bakery-ui.css">
</head>
<body class="bakery-app">
<nav class="navbar navbar-expand-lg bakery-navbar navbar-dark">
    <div class="container bakery-shell">
        <a class="navbar-brand bakery-brand" href="/">Bakery Management System</a>
        <div class="d-flex gap-2 flex-wrap">
            <a href="/custom-orders/new" class="btn btn-sm btn-bakery-primary">+ New Custom Order</a>
            <a href="/admin-dashboard" class="btn btn-sm btn-bakery-outline">Dashboard</a>
            <a href="/orders/history" class="btn btn-sm btn-outline-light">All Orders</a>
        </div>
    </div>
</nav>

<main class="container bakery-shell py-4 py-lg-5">
    <section class="bakery-hero mini-fade mb-4">
        <span class="eyebrow">Custom Cakes</span>
        <h1 class="mt-3 mb-2">Custom Cake Orders</h1>
        <p>Track the full lifecycle of custom cakes, from design approval to delivery.</p>
    </section>

    <c:choose>
        <c:when test="${empty orders}">
            <div class="bakery-panel p-4 text-center">
                <h4 class="mb-2">No custom orders yet</h4>
                <p class="text-muted mb-3">Create a new order to start building cakes for your customers.</p>
                <a href="/custom-orders/new" class="btn btn-bakery-primary">Place one now</a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="bakery-panel p-3 p-lg-4">
                <table class="table table-hover table-bakery mb-0 align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Size</th>
                            <th>Complexity</th>
                            <th>Urgency</th>
                            <th>Flavor</th>
                            <th>Layers</th>
                            <th>Amount</th>
                            <th>Status</th>
                            <th>Delivery Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td class="fw-semibold">${order.customerName}</td>
                                <td>${order.cakeSize}</td>
                                <td>${order.complexity}</td>
                                <td>
                                    <span class="badge ${order.urgency == 'RUSH' ? 'text-bg-danger' : 'text-bg-secondary'}">
                                        ${order.urgency}
                                    </span>
                                </td>
                                <td>${order.flavor}</td>
                                <td>${order.layers}</td>
                                <td>Rs. ${order.totalAmount}</td>
                                <td>
                                    <span class="badge
                                        ${order.status == 'DELIVERED' ? 'text-bg-success' :
                                          order.status == 'IN_PROGRESS' ? 'text-bg-primary' :
                                          order.status == 'READY' ? 'text-bg-info text-dark' :
                                          order.status == 'CANCELLED' ? 'text-bg-dark' :
                                          'text-bg-warning text-dark'}">
                                        ${order.status}
                                    </span>
                                </td>
                                <td>${order.deliveryDate}</td>
                                <td>
                                    <div class="d-flex gap-2 flex-wrap">
                                        <a href="/custom-orders/edit/${order.orderId}"
                                           class="btn btn-sm btn-outline-primary">Edit</a>
                                        <a href="/custom-orders/track/${order.orderId}"
                                           class="btn btn-sm btn-outline-info">Track</a>
                                        <form action="/custom-orders/delete/${order.orderId}"
                                              method="POST" class="d-inline"
                                              onsubmit="return confirm('Delete this order?')">
                                            <button type="submit" class="btn btn-sm btn-outline-danger">Delete</button>
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
</main>
</body>
</html>
