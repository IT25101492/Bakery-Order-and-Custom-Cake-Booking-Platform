<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bakery Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
    <nav class="navbar navbar-dark bg-dark mb-4">
        <div class="container">
            <span class="navbar-brand">Bakery Management System</span>
        </div>
    </nav>

    <div class="container">
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card text-white bg-primary">
                    <div class="card-body text-center">
                        <h5>Total Orders</h5>
                        <h2>${orders.size()}</h2>
                    </div>
                </div>
            </div>
        </div>

        <h3>Recent Orders</h3>
        <table class="table table-hover bg-white shadow-sm">
            <thead class="table-secondary">
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
                        <td>${order.customerName}</td>
                        <td>${order.getClass().simpleName}</td>
                        <td>Rs. ${order.totalAmount}</td>
                        <td><span class="badge bg-info text-dark">${order.status}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>