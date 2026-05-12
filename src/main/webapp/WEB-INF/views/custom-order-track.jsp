<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Track Order #${order.orderId} - Bakery</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bakery-ui.css">
</head>
<body class="bakery-app">
<nav class="navbar navbar-expand-lg bakery-navbar navbar-dark">
    <div class="container bakery-shell">
        <a class="navbar-brand bakery-brand" href="/">Bakery Management System</a>
        <div class="d-flex gap-2 flex-wrap">
            <a href="/custom-orders" class="btn btn-sm btn-bakery-outline">All Custom Orders</a>
            <a href="/orders/history" class="btn btn-sm btn-outline-light">Order History</a>
        </div>
    </div>
</nav>

<main class="container bakery-shell py-4 py-lg-5" style="max-width: 760px;">

    <%-- Determine numeric progress for the timeline --%>
    <c:set var="s" value="${order.status}" />
    <c:choose>
        <c:when test="${s == 'AWAITING_DESIGN_APPROVAL'}"><c:set var="step" value="1"/></c:when>
        <c:when test="${s == 'IN_PROGRESS'}">             <c:set var="step" value="2"/></c:when>
        <c:when test="${s == 'READY'}">                   <c:set var="step" value="3"/></c:when>
        <c:when test="${s == 'DELIVERED'}">               <c:set var="step" value="4"/></c:when>
        <c:when test="${s == 'CANCELLED'}">               <c:set var="step" value="0"/></c:when>
        <c:otherwise>                                     <c:set var="step" value="1"/></c:otherwise>
    </c:choose>

    <section class="bakery-hero mini-fade mb-4">
        <span class="eyebrow">Tracking</span>
        <h1 class="mt-3 mb-2">Order Tracking</h1>
        <p>Order #${order.orderId} &mdash; ${order.customerName}</p>
    </section>

    <div class="bakery-card p-4 p-lg-5 timeline-card mb-4">

        <c:choose>
            <c:when test="${step == 0}">
                <div class="alert alert-danger fw-semibold text-center">This order has been CANCELLED.</div>
            </c:when>
            <c:otherwise>
                <%-- Step 1: Submitted --%>
                <div class="step">
                    <div class="step-circle ${step >= 1 ? (step == 1 ? 'active' : 'done') : ''}">1</div>
                    <div class="step-label">
                        <p class="title">Submitted &amp; Awaiting Design Approval</p>
                        <p class="sub">Your order has been received and is pending design review.</p>
                    </div>
                </div>
                <div class="step-line ${step > 1 ? 'done' : ''}"></div>

                <%-- Step 2: In Progress --%>
                <div class="step">
                    <div class="step-circle ${step >= 2 ? (step == 2 ? 'active' : 'done') : ''}">2</div>
                    <div class="step-label">
                        <p class="title">In Progress</p>
                        <p class="sub">Design approved — our bakers are crafting your cake.</p>
                    </div>
                </div>
                <div class="step-line ${step > 2 ? 'done' : ''}"></div>

                <%-- Step 3: Ready --%>
                <div class="step">
                    <div class="step-circle ${step >= 3 ? (step == 3 ? 'active' : 'done') : ''}">3</div>
                    <div class="step-label">
                        <p class="title">Ready for Pickup / Delivery</p>
                        <p class="sub">Your cake is finished and ready!</p>
                    </div>
                </div>
                <div class="step-line ${step > 3 ? 'done' : ''}"></div>

                <%-- Step 4: Delivered --%>
                <div class="step">
                    <div class="step-circle ${step >= 4 ? 'done' : ''}">4</div>
                    <div class="step-label">
                        <p class="title">Delivered</p>
                        <p class="sub">Order complete. Enjoy your cake!</p>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- Order spec card --%>
    <div class="bakery-card p-4 p-lg-5">
        <h5 class="mb-3 fw-bold">Order Details</h5>
        <table class="table table-sm table-bordered mb-0">
            <tr><th>Size</th>         <td>${order.cakeSize}</td></tr>
            <tr><th>Complexity</th>   <td>${order.complexity}</td></tr>
            <tr><th>Urgency</th>      <td>${order.urgency}</td></tr>
            <tr><th>Flavor</th>       <td>${order.flavor}</td></tr>
            <tr><th>Layers</th>       <td>${order.layers}</td></tr>
            <tr><th>Design</th>       <td>${order.cakeDesign}</td></tr>
            <tr><th>Instructions</th> <td>${order.specialInstructions}</td></tr>
            <tr><th>Delivery Date</th><td>${order.deliveryDate}</td></tr>
            <tr><th>Total Amount</th> <td class="fw-bold">Rs. ${order.totalAmount}</td></tr>
        </table>
    </div>

    <div class="mt-3 text-center">
        <a href="/custom-orders" class="btn btn-outline-secondary">Back to Orders</a>
    </div>
</main>
</body>
</html>
