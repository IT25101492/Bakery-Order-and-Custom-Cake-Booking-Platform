<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bakery Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bakery-ui.css">
</head>
<body class="bakery-app">
    <nav class="navbar navbar-expand-lg bakery-navbar navbar-dark">
        <div class="container bakery-shell">
            <a class="navbar-brand bakery-brand" href="/">Bakery Management System</a>
            <div class="d-flex gap-2 flex-wrap">
                <a href="/custom-orders" class="btn btn-sm btn-bakery-primary">Custom Orders</a>
                <a href="/orders/history" class="btn btn-sm btn-bakery-outline">All Orders</a>
            </div>
        </div>
    </nav>

    <main class="container bakery-shell py-4 py-lg-5">
        <section class="bakery-hero mini-fade mb-4">
            <span class="eyebrow">Admin</span>
            <h1 class="mt-3 mb-2">Bakery Dashboard</h1>
            <p>Monitor order volume, custom cake activity, and recent order status in one view.</p>
        </section>

        <div class="row g-3 g-lg-4 mb-4">
            <div class="col-md-6">
                <div class="card bakery-kpi text-white" style="background: linear-gradient(135deg, #1f2937, #c46a2f);">
                    <div class="card-body text-center">
                        <div class="kpi-label mb-2">Total Orders</div>
                        <div class="kpi-value">${orders.size()}</div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card bakery-kpi text-white" style="background: linear-gradient(135deg, #7c3aed, #f59e0b);">
                    <div class="card-body text-center">
                        <div class="kpi-label mb-2">Custom Cake Orders</div>
                        <div class="kpi-value">${customOrderCount}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="bakery-panel p-3 p-lg-4">
            <h3 class="mb-4 fw-bold">Recent Orders</h3>
            <table class="table table-hover table-bakery mb-0 align-middle">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Customer</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>${order.orderId}</td>
                            <td class="fw-semibold">${order.customerName}</td>
                            <td>${order.getClass().simpleName}</td>
                            <td>Rs. ${order.totalAmount}</td>
                            <td><span class="badge text-bg-info text-dark">${order.status}</span></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>