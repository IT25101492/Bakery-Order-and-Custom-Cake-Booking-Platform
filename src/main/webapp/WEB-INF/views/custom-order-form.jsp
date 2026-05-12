<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Custom Cake Order - Bakery</title>
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
        <span class="eyebrow">Design Studio</span>
        <h1 class="mt-3 mb-2">Custom Cake Design Form</h1>
        <p>Shape the cake, choose the size, and see a live price estimate as you fill the form.</p>
    </section>

    <div class="bakery-card p-4 p-lg-5">
        <form action="/custom-orders/place" method="POST">

            <div class="mb-3">
                <label class="form-label fw-semibold">Customer Name</label>
                <input type="text" name="customerName" class="form-control" placeholder="Your full name" required>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Cake Size</label>
                    <select name="cakeSize" id="cakeSize" class="form-select" onchange="updatePrice()" required>
                        <option value="SMALL">Small (serves ~8)</option>
                        <option value="MEDIUM" selected>Medium (serves ~16)</option>
                        <option value="LARGE">Large (serves ~30)</option>
                        <option value="TIERED">Tiered (serves ~50+)</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Design Complexity</label>
                    <select name="complexity" id="complexity" class="form-select" onchange="updatePrice()" required>
                        <option value="BASIC">Basic</option>
                        <option value="STANDARD" selected>Standard</option>
                        <option value="ELABORATE">Elaborate</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Urgency</label>
                <div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="urgency" id="urgNormal"
                               value="NORMAL" checked onchange="updatePrice()">
                        <label class="form-check-label" for="urgNormal">Normal</label>
                    </div>
                    <div class="form-check form-check-inline">
                        <input class="form-check-input" type="radio" name="urgency" id="urgRush"
                               value="RUSH" onchange="updatePrice()">
                        <label class="form-check-label" for="urgRush">Rush (+20%)</label>
                    </div>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Flavor</label>
                    <input type="text" name="flavor" class="form-control" placeholder="e.g. Chocolate, Vanilla" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-semibold">Number of Layers</label>
                    <input type="number" name="layers" id="layers" class="form-control"
                           value="1" min="1" max="10" onchange="updatePrice()" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Cake Design / Theme</label>
                <input type="text" name="cakeDesign" class="form-control" placeholder="e.g. Vintage Ghibli, Floral Garden" required>
            </div>

            <div class="mb-3">
                <label class="form-label fw-semibold">Special Instructions</label>
                <textarea name="specialInstructions" class="form-control" rows="3"
                          placeholder="Dietary restrictions, message on cake, etc."></textarea>
            </div>

            <div class="mb-4">
                <label class="form-label fw-semibold">Requested Delivery Date</label>
                <input type="date" name="deliveryDate" class="form-control" required>
            </div>

            <div class="price-chip d-flex justify-content-between align-items-center mb-4">
                <span class="fw-semibold">Estimated Price:</span>
                <span class="fs-5 fw-bold" id="priceDisplay">Rs. 3,250.00</span>
            </div>

            <button type="submit" class="btn btn-bakery-primary w-100 btn-lg">Place Custom Order</button>
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

    updatePrice();
</script>
</body>
</html>
