<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Order Management</h1>
    <p>View and manage all customer orders.</p>
</div>

<div class="card" style="margin-bottom: 20px;">
    <div class="card-header">
        <h2>Filter Orders</h2>
    </div>
    <form action="${pageContext.request.contextPath}/admin/orders" method="get" style="padding: 15px; display: flex; gap: 10px; flex-wrap: wrap;">
        <select name="filter" class="form-control" style="flex: 1; min-width: 150px;">
            <option value="" ${empty currentFilter ? 'selected' : ''}>All Orders</option>
            <option value="pending" ${currentFilter == 'pending' ? 'selected' : ''}>Pending</option>
            <option value="confirmed" ${currentFilter == 'confirmed' ? 'selected' : ''}>Confirmed</option>
            <option value="in-progress" ${currentFilter == 'in-progress' ? 'selected' : ''}>In Progress</option>
            <option value="ready" ${currentFilter == 'ready' ? 'selected' : ''}>Ready</option>
            <option value="delivered" ${currentFilter == 'delivered' ? 'selected' : ''}>Delivered</option>
            <option value="cancelled" ${currentFilter == 'cancelled' ? 'selected' : ''}>Cancelled</option>
        </select>
        <button type="submit" class="btn btn-outline btn-sm">Filter</button>
        <c:if test="${not empty currentFilter}">
            <a href="${pageContext.request.contextPath}/admin/orders" class="btn btn-secondary">Clear Filter</a>
        </c:if>
    </form>
</div>

<div class="card">
    <div class="card-header">
        <h2>All Orders</h2>
    </div>
    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Type</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Total</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${empty orders}">
                        <tr>
                            <td colspan="7" style="text-align: center; padding: 30px; color: #666;">
                                No orders found.
                            </td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="order" items="${orders}">
                            <tr>
                                <td><strong>#${order.orderId}</strong></td>
                                <td>${order.orderType}</td>
                                <td>${order.customerName}</td>
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
                                    <a href="${pageContext.request.contextPath}/admin/orders/${order.orderId}" class="btn btn-secondary btn-sm">View</a>

                                    <c:if test="${order.status != 'delivered' && order.status != 'cancelled'}">
                                        <form action="${pageContext.request.contextPath}/admin/orders/${order.orderId}/status" method="post" style="display: inline;">
                                            <select name="status" style="padding: 4px; border: 1px solid #ccc; border-radius: 4px; margin-right: 4px;">
                                                <c:choose>
                                                    <c:when test="${order.status == 'pending'}">
                                                        <option value="confirmed">Confirmed</option>
                                                        <option value="cancelled">Cancelled</option>
                                                    </c:when>
                                                    <c:when test="${order.status == 'confirmed'}">
                                                        <option value="in-progress">In Progress</option>
                                                        <option value="cancelled">Cancelled</option>
                                                    </c:when>
                                                    <c:when test="${order.status == 'in-progress'}">
                                                        <option value="ready">Ready</option>
                                                    </c:when>
                                                    <c:when test="${order.status == 'ready'}">
                                                        <option value="delivered">Delivered</option>
                                                    </c:when>
                                                </c:choose>
                                            </select>
                                            <button type="submit" class="btn btn-primary btn-sm">Update</button>
                                        </form>
                                    </c:if>

                                    <c:if test="${order.status == 'delivered' || order.status == 'cancelled'}">
                                        <a href="${pageContext.request.contextPath}/admin/orders/delete/${order.orderId}"
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Delete this order permanently?');">
                                           Delete
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>