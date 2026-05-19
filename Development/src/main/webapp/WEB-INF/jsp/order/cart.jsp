<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Shopping Cart</h1>
    <p>Review your items before placing an order.</p>
</div>

<c:choose>
    <c:when test="${empty cartItems}">
        <div class="card" style="text-align: center; padding: 40px;">
            <h3>Your cart is empty</h3>
            <p style="color: #666; margin: 15px 0;">Browse our products and add items to your cart.</p>
            <a href="${pageContext.request.contextPath}/products/items" class="btn btn-primary">Browse Products</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card">
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Subtotal</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="grandTotal" value="0" />
                        <c:forEach var="item" items="${cartItems}">
                            <tr>
                                <td><strong>${item.productName}</strong></td>
                                <td>${item.productCategory}</td>
                                <td>$${item.price}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/cart/update" method="post" style="display: flex; align-items: center; gap: 5px;">
                                        <input type="hidden" name="productId" value="${item.productId}">
                                        <input type="number" name="quantity" value="${item.quantity}" min="1" max="99"
                                               style="width: 60px; padding: 4px; border: 1px solid #ccc; border-radius: 4px;">
                                        <button type="submit" class="btn btn-secondary btn-sm">Update</button>
                                    </form>
                                </td>
                                <td><strong>$${item.subtotal}</strong></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/cart/remove?productId=${item.productId}"
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Remove this item from cart?');">
                                       Remove
                                    </a>
                                </td>
                            </tr>
                            <c:set var="grandTotal" value="${grandTotal + item.subtotal}" />
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <div style="padding: 20px; text-align: right; border-top: 1px solid #eee;">
                <h3 style="margin: 0;">Grand Total: <strong style="color: #2c3e50;">$${grandTotal}</strong></h3>
                <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary" style="margin-top: 15px;">Proceed to Checkout</a>
                <a href="${pageContext.request.contextPath}/products/items" class="btn btn-outline" style="margin-top: 15px; margin-left: 10px;">Continue Shopping</a>
            </div>
        </div>
    </c:otherwise>
</c:choose>