<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bakery - Order History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bakery-ui.css">
</head>
<body class="bakery-app">
    <nav class="navbar navbar-expand-lg bakery-navbar navbar-dark">
        <div class="container bakery-shell">
            <a class="navbar-brand bakery-brand" href="/">Bakery Management System</a>
            <div class="d-flex gap-2 flex-wrap">
                <a href="/custom-orders" class="btn btn-sm btn-bakery-outline">Custom Orders</a>
                <a href="/admin-dashboard" class="btn btn-sm btn-outline-light">Dashboard</a>
                <a href="/" class="btn btn-sm btn-outline-light">Home</a>
            </div>
        </div>
    </nav>

    <main class="container bakery-shell py-4 py-lg-5">
        <section class="bakery-hero mini-fade mb-4">
            <span class="eyebrow">Orders</span>
            <h1 class="mt-3 mb-2">Order History</h1>
            <p>Browse completed and active orders in one place, with amounts and current status at a glance.</p>
        </section>

        <div class="bakery-panel p-3 p-lg-4">
            <table class="table table-hover table-bakery mb-0 align-middle">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Customer Name</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                        <th>Order Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td>${order.customerName}</td>
                            <td>Rs. ${order.totalAmount}</td>
                            <td>
                                <span class="badge ${order.status == 'CONFIRMED' ? 'text-bg-success' : 'text-bg-warning'}">
                                    ${order.status}
                                </span>
                            </td>
                            <td>${order.orderDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>