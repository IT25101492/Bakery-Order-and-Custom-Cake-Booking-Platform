<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Checkout</h1>
    <p>Confirm your order details below.</p>
</div>

<div class="card" style="margin-bottom: 20px;">
    <div class="card-header">
        <h2>Order Summary</h2>
    </div>
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="grandTotal" value="0" />
                <c:forEach var="item" items="${cartItems}">
                    <tr>
                        <td><strong>${item.productName}</strong></td>
                        <td>${item.productCategory}</td>
                        <td>$${item.price}</td>
                        <td>${item.quantity}</td>
                        <td><strong>$${item.subtotal}</strong></td>
                    </tr>
                    <c:set var="grandTotal" value="${grandTotal + item.subtotal}" />
                </c:forEach>
            </tbody>
        </table>
    </div>
    <div style="padding: 20px; text-align: right; border-top: 1px solid #eee;">
        <h3 style="margin: 0;">Total: <strong style="color: #2c3e50;">$${grandTotal}</strong></h3>
    </div>
</div>

<div style="display: flex; gap: 10px;">
    <form action="${pageContext.request.contextPath}/orders/place" method="post">
        <button type="submit" class="btn btn-primary"
                onclick="return confirm('Are you sure you want to place this order?');">
            Place Order
        </button>
    </form>
    <a href="${pageContext.request.contextPath}/cart" class="btn btn-outline">Back to Cart</a>
</div>