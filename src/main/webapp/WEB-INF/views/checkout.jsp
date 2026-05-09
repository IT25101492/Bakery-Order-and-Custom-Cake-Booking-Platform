<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - Bakery Platform</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/bakery-ui.css">
</head>
<body class="bakery-app">
    <nav class="navbar navbar-expand-lg bakery-navbar navbar-dark">
        <div class="container bakery-shell">
            <a class="navbar-brand bakery-brand" href="/">Bakery Management System</a>
            <div class="d-flex gap-2 flex-wrap">
                <a href="/cart" class="btn btn-sm btn-bakery-outline">Cart</a>
                <a href="/orders/history" class="btn btn-sm btn-outline-light">Order History</a>
            </div>
        </div>
    </nav>

    <main class="container bakery-shell py-4 py-lg-5" style="max-width: 760px;">
        <section class="bakery-hero mini-fade mb-4">
            <span class="eyebrow">Checkout</span>
            <h1 class="mt-3 mb-2">Finalize Order</h1>
            <p>Confirm your details and place the order with a clean, simple checkout flow.</p>
        </section>

        <div class="bakery-card p-4 p-lg-5">
            <form action="/orders/place" method="POST">
                <div class="mb-3">
                    <label class="form-label fw-semibold">Customer Name</label>
                    <input type="text" name="customerName" class="form-control" placeholder="Enter your name" required>
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Contact Number</label>
                    <input type="text" class="form-control" placeholder="07x-xxx-xxxx">
                </div>
                <div class="mb-3">
                    <label class="form-label fw-semibold">Delivery Address</label>
                    <textarea class="form-control" rows="4" placeholder="Street, city, landmark"></textarea>
                </div>
                <button type="submit" class="btn btn-bakery-primary w-100 btn-lg">Place Order</button>
            </form>
        </div>
    </main>
</body>
</html>