<!DOCTYPE html>
<html>
<head>
    <title>Your Bakery Cart</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="container py-5">
    <h2 class="mb-4">Shopping Cart</h2>
    <div class="card p-4 shadow-sm">
        <p class="text-muted">Review your selected bakery items below:</p>
        <hr>
        <!-- Static example for layout -->
        <div class="d-flex justify-content-between align-items-center mb-3">
            <span><strong>Custom Birthday Cake</strong></span>
            <span>Rs. 4500.00</span>
        </div>
        <div class="d-flex justify-content-between align-items-center border-top pt-3">
            <h4>Total:</h4>
            <h4>Rs. 4500.00</h4>
        </div>
        <div class="mt-4">
            <a href="/orders/checkout" class="btn btn-success w-100 py-2">Proceed to Checkout</a>
            <a href="/" class="btn btn-link w-100 mt-2">Continue Shopping</a>
        </div>
    </div>
</body>
</html>