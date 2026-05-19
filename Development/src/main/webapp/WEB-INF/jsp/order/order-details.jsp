<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header" style="display: flex; justify-content: space-between; align-items: center;">
    <div>
        <h1>Order #${order.orderId}</h1>
        <p>Placed on ${order.formattedCreatedAt}</p>
    </div>
    <div>
        <c:choose>
            <c:when test="${order.status == 'pending'}">
                <span class="badge" style="background-color: #f39c12; color: white; padding: 6px 12px; border-radius: 4px; font-size: 1rem;">Pending</span>
            </c:when>
            <c:when test="${order.status == 'confirmed'}">
                <span class="badge" style="background-color: #3498db; color: white; padding: 6px 12px; border-radius: 4px; font-size: 1rem;">Confirmed</span>
            </c:when>
            <c:when test="${order.status == 'in-progress'}">
                <span class="badge" style="background-color: #9b59b6; color: white; padding: 6px 12px; border-radius: 4px; font-size: 1rem;">In Progress</span>
            </c:when>
            <c:when test="${order.status == 'ready'}">
                <span class="badge" style="background-color: #2ecc71; color: white; padding: 6px 12px; border-radius: 4px; font-size: 1rem;">Ready</span>
            </c:when>
            <c:when test="${order.status == 'delivered'}">
                <span class="badge" style="background-color: #27ae60; color: white; padding: 6px 12px; border-radius: 4px; font-size: 1rem;">Delivered</span>
            </c:when>
            <c:when test="${order.status == 'cancelled'}">
                <span class="badge" style="background-color: #e74c3c; color: white; padding: 6px 12px; border-radius: 4px; font-size: 1rem;">Cancelled</span>
            </c:when>
        </c:choose>
    </div>
</div>

<div style="display: flex; gap: 20px; flex-wrap: wrap;">
    <div class="card" style="flex: 2; min-width: 300px;">
        <div class="card-header">
            <h2>Order Items</h2>
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
                    <c:set var="total" value="0" />
                    <c:forEach var="item" items="${orderItems}">
                        <tr>
                            <td><strong>${item.productName}</strong></td>
                            <td>${item.productCategory}</td>
                            <td>$${item.price}</td>
                            <td>${item.quantity}</td>
                            <td><strong>$${item.subtotal}</strong></td>
                        </tr>
                        <c:set var="total" value="${total + item.subtotal}" />
                    </c:forEach>
                </tbody>
                <tfoot>
                    <tr style="border-top: 2px solid #333;">
                        <td colspan="4" style="text-align: right;"><strong>Total:</strong></td>
                        <td><strong style="color: #2c3e50; font-size: 1.1rem;">$${total}</strong></td>
                    </tr>
                </tfoot>
            </table>
        </div>
    </div>

    <div class="card" style="flex: 1; min-width: 200px;">
        <div class="card-header">
            <h2>Order Info</h2>
        </div>
        <div style="padding: 15px;">
            <p><strong>Order ID:</strong> #${order.orderId}</p>
            <p><strong>Type:</strong> ${order.orderType}</p>
            <p><strong>Customer:</strong> ${order.customerName}</p>
            <p><strong>Email:</strong> ${order.customerEmail}</p>
            <p><strong>Status:</strong> ${order.statusDisplay}</p>
            <p><strong>Created:</strong> ${order.formattedCreatedAt}</p>
            <p><strong>Last Updated:</strong> ${order.formattedUpdatedAt}</p>
        </div>
    </div>
</div>

<div style="margin-top: 20px; display: flex; gap: 10px;">
    <c:choose>
        <c:when test="${userRole == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-outline">Back to Orders</a>
        </c:when>
        <c:otherwise>
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline">Back to My Orders</a>
            <c:if test="${order.status == 'pending' || order.status == 'confirmed'}">
                <form action="${pageContext.request.contextPath}/orders/${order.orderId}/cancel" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger"
                            onclick="return confirm('Are you sure you want to cancel this order?');">
                        Cancel Order
                    </button>
                </form>
            </c:if>
        </c:otherwise>
    </c:choose>
</div>