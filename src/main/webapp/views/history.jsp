<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bakery - Order History</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container mt-5">
    <h2 class="mb-4">Order History</h2>
    
    <table class="table table-striped table-bordered">
        <thead class="table-dark">
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
                        <span class="badge ${order.status == 'CONFIRMED' ? 'bg-success' : 'bg-warning'}">
                            ${order.status}
                        </span>
                    </td>
                    <td>${order.orderDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    <a href="/" class="btn btn-primary">Back to Home</a>
</body>
</html>