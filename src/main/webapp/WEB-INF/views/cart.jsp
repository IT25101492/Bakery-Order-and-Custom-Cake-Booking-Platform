<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Bakery Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bakery-ui.css">
</head>
<body class="bakery-app">
    <nav class="navbar navbar-expand-lg bakery-navbar navbar-dark">
        <div class="container bakery-shell">
            <a class="navbar-brand bakery-brand" href="/">Bakery Management System</a>
            <div class="d-flex gap-2 flex-wrap">
                <a href="/custom-orders" class="btn btn-sm btn-bakery-outline">Custom Orders</a>
                <a href="/orders/history" class="btn btn-sm btn-outline-light">Order History</a>
            </div>
        </div>
    </nav>

    <main class="container bakery-shell py-4 py-lg-5" style="max-width: 760px;">
        <section class="bakery-hero mini-fade mb-4">
            <span class="eyebrow">Cart</span>
            <h1 class="mt-3 mb-2">Shopping Cart</h1>
            <p>Review your selected bakery items before continuing to checkout.</p>
        </section>

        <div class="bakery-card p-4 p-lg-5">
            <p class="text-muted">Review your selected bakery items below:</p>
            <hr>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <span><strong>Custom Birthday Cake</strong></span>
                <span>Rs. 4500.00</span>
            </div>
            <div class="d-flex justify-content-between align-items-center border-top pt-3">
                <h4 class="mb-0">Total</h4>
                <h4 class="mb-0">Rs. 4500.00</h4>
            </div>
            <div class="mt-4">
                <a href="/orders/checkout" class="btn btn-bakery-primary w-100 py-2">Proceed to Checkout</a>
                <a href="/" class="btn btn-link w-100 mt-2">Continue Shopping</a>
            </div>
        </div>
    </main>
</body>
</html>