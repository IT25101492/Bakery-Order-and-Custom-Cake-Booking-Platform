<!DOCTYPE html>
<html>
<head>
    <title>Checkout - Bakery Platform</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light py-5">
    <div class="container" style="max-width: 600px;">
        <div class="card shadow-sm p-4">
            <h2 class="text-center mb-4">Finalize Order</h2>
            <form action="/orders/place" method="POST">
                <div class="mb-3">
                    <label class="form-label">Customer Name</label>
                    <input type="text" name="customerName" class="form-control" placeholder="Enter your name" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Contact Number</label>
                    <input type="text" class="form-control" placeholder="07x-xxx-xxxx">
                </div>
                <div class="mb-3">
                    <label class="form-label">Delivery Address</label>
                    <textarea class="form-control" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary w-100 btn-lg">Place Order</button>
            </form>
        </div>
    </div>
</body>
</html>