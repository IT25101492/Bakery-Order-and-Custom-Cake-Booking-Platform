<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>My Orders</h1>
    <p>View your order history and track current orders.</p>
</div>

<c:choose>
    <c:when test="${empty orders}">
        <div class="card" style="text-align: center; padding: 40px;">
            <h3>No orders yet</h3>
            <p style="color: #666; margin: 15px 0;">Start shopping to see your orders here.</p>
            <a href="${pageContext.request.contextPath}/products/items" class="btn btn-primary">Browse Products</a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="card">
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Order ID</th>
                            <th>Type</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td><strong>#${order.orderId}</strong></td>
                                <td>${order.orderType}</td>
                                <td>${order.formattedCreatedAt}</td>
                                <td><strong>$${order.totalPrice}</strong></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${order.status == 'pending'}">
                                            <span class="badge" style="background-color: #f39c12; color: white; padding: 4px 8px; border-radius: 4px;">Pending</span>
                                        </c:when>
                                        <c:when test="${order.status == 'confirmed'}">
                                            <span class="badge" style="background-color: #3498db; color: white; padding: 4px 8px; border-radius: 4px;">Confirmed</span>
                                        </c:when>
                                        <c:when test="${order.status == 'in-progress'}">
                                            <span class="badge" style="background-color: #9b59b6; color: white; padding: 4px 8px; border-radius: 4px;">In Progress</span>
                                        </c:when>
                                        <c:when test="${order.status == 'ready'}">
                                            <span class="badge" style="background-color: #2ecc71; color: white; padding: 4px 8px; border-radius: 4px;">Ready</span>
                                        </c:when>
                                        <c:when test="${order.status == 'delivered'}">
                                            <span class="badge" style="background-color: #27ae60; color: white; padding: 4px 8px; border-radius: 4px;">Delivered</span>
                                        </c:when>
                                        <c:when test="${order.status == 'cancelled'}">
                                            <span class="badge" style="background-color: #e74c3c; color: white; padding: 4px 8px; border-radius: 4px;">Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge" style="background-color: #95a5a6; color: white; padding: 4px 8px; border-radius: 4px;">${order.statusDisplay}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/orders/${order.orderId}" class="btn btn-secondary btn-sm">View Details</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </c:otherwise>
</c:choose>