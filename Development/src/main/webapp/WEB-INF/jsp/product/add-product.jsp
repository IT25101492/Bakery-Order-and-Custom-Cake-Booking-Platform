<%@ page contentType="text/html;charset=UTF-8" %>
<div class="page-header">
    <h1>Add New Product</h1>
    <p>Create a new bakery product for the catalog.</p>
</div>

<div class="card">
    <div class="card-header">
        <h2>Product Details</h2>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline btn-sm">Back to List</a>
    </div>

    <form action="${pageContext.request.contextPath}/admin/products/save" method="post" style="padding: 15px;">

        <div class="form-row" style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="form-group" style="flex: 1;">
                <label class="form-label">Product Name</label>
                <input type="text" name="name" class="form-control" required>
            </div>

            <div class="form-group" style="flex: 1;">
                <label class="form-label">Product Type</label>
                <select name="productType" class="form-control" required>
                    <option value="StandardCake">Standard Cake</option>
                    <option value="Bread">Bread</option>
                    <option value="Pastry">Pastry</option>
                </select>
            </div>
        </div>

        <div class="form-row" style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="form-group" style="flex: 1;">
                <label class="form-label">Category</label>
                <input type="text" name="category" class="form-control" required>
            </div>

            <div class="form-group" style="flex: 1;">
                <label class="form-label">Price ($)</label>
                <input type="number" step="0.01" name="price" class="form-control" required>
            </div>
        </div>

        <div class="form-row" style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="form-group" style="flex: 1;">
                <label class="form-label">Stock Quantity</label>
                <input type="number" name="stockQuantity" class="form-control" required>
            </div>

            <div class="form-group" style="flex: 1;">
                <label class="form-label">Ingredients</label>
                <input type="text" name="ingredients" class="form-control" placeholder="e.g., flour, butter, sugar, eggs">
            </div>
        </div>

        <div class="form-group" style="margin-bottom: 15px;">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3"></textarea>
        </div>

        <div class="form-group" style="margin-bottom: 15px;">
            <label>
                <input type="checkbox" name="availability" value="true" checked>
                Available in Store
            </label>
        </div>

        <button type="submit" class="btn btn-primary">Save Product</button>
    </form>
</div>