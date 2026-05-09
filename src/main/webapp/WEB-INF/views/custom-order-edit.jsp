<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Custom Order #${order.orderId} - Bakery</title>
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

<main class="container bakery-shell py-4 py-lg-5" style="max-width: 820px;">
    <section class="bakery-hero mini-fade mb-4">
        <span class="eyebrow">Editing</span>
        <h1 class="mt-3 mb-2">Edit Custom Order <span class="opacity-75">#${order.orderId}</span></h1>
        <p>Update specifications, delivery date, urgency, or order status in one place.</p>
    </section>

    <div class="bakery-card p-4 p-lg-5">
        <form action="/custom-orders/update/${order.orderId}" method="POST">

            <div class="mb-3">
                <label class="form-label fw-semibold">Customer Name</label>
                <input type="text" name="customerName" class="form-control"
                       value="${order.customerName}" required>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Cake Size</label>
                    <select name="cakeSize" id="cakeSize" class="form-select" onchange="updatePrice()" required>
                        <c:forEach var="s" items="${['SMALL','MEDIUM','LARGE','TIERED']}">
                            <option value="${s}" ${order.cakeSize == s ? 'selected' : ''}>${s}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Design Complexity</label>
                    <select name="complexity" id="complexity" class="form-select" onchange="updatePrice()" required>
                        <c:forEach var="c" items="${['BASIC','STANDARD','ELABORATE']}">
                            <option value="${c}" ${order.complexity == c ? 'selected' : ''}>${c}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Urgency</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="urgency" id="urgNormal"
                               value="NORMAL" ${order.urgency == 'NORMAL' ? 'checked' : ''} onchange="updatePrice()">
                        <label class="form-check-label" for="urgNormal">Normal</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="urgency" id="urgRush"
                               value="RUSH" ${order.urgency == 'RUSH' ? 'checked' : ''} onchange="updatePrice()">
                        <label class="form-check-label" for="urgRush">Rush (+20%)</label>
                    </div>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Flavor</label>
                    <input type="text" name="flavor" class="form-control" value="${order.flavor}" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Number of Layers</label>
                    <input type="number" name="layers" id="layers" class="form-control"
                           value="${order.layers}" min="1" max="10" onchange="updatePrice()" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Cake Design / Theme</label>
                <input type="text" name="cakeDesign" class="form-control" value="${order.cakeDesign}" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Special Instructions</label>
                <textarea name="specialInstructions" class="form-control" rows="3">${order.specialInstructions}</textarea>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Requested Delivery Date</label>
                <input type="date" name="deliveryDate" class="form-control" value="${order.deliveryDate}" required>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Order Status</label>
                <select name="status" class="form-select" required>
                    <c:forEach var="st" items="${['AWAITING_DESIGN_APPROVAL','IN_PROGRESS','READY','DELIVERED','CANCELLED']}">
                        <option value="${st}" ${order.status == st ? 'selected' : ''}>${st}</option>
                    </c:forEach>
                </select>
            </div>

            <div class="price-chip d-flex justify-content-between align-items-center mb-4">
                <span class="fw-semibold">Recalculated Price:</span>
                <span class="fs-5 fw-bold" id="priceDisplay">Rs. ${order.totalAmount}</span>
            </div>

            <button type="submit" class="btn btn-bakery-primary w-100 btn-lg">Save Changes</button>
            <a href="/custom-orders" class="btn btn-outline-secondary w-100 mt-2">Cancel</a>
        </form>
    </div>
</main>

<script>
    const BASE = { SMALL: 1500, MEDIUM: 2500, LARGE: 4000, TIERED: 7000 };
    const MULT = { BASIC: 1.0, STANDARD: 1.3, ELABORATE: 1.6 };

    function updatePrice() {
        const size       = document.getElementById('cakeSize').value;
        const complexity = document.getElementById('complexity').value;
        const rush       = document.getElementById('urgRush').checked;
        const layers     = parseInt(document.getElementById('layers').value) || 1;

        let price = BASE[size] * MULT[complexity];
        if (rush) price *= 1.2;
        if (layers > 1) price += (layers - 1) * 300;

        document.getElementById('priceDisplay').textContent =
            'Rs. ' + price.toLocaleString('en-LK', { minimumFractionDigits: 2 });
    }
</script>
</body>
</html>
