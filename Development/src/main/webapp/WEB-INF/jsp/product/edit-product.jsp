<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Edit Product</h1>
    <p>Update the details of an existing bakery product.</p>
</div>

<div class="card">
    <div class="card-header">
        <h2>Product Details</h2>
        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-outline btn-sm">Back to List</a>
    </div>

    <form action="${pageContext.request.contextPath}/admin/products/update/${product.productId}" method="post" style="padding: 15px;">

        <div class="form-row" style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="form-group" style="flex: 1;">
                <label class="form-label">Product Name</label>
                <input type="text" name="name" value="${product.name}" class="form-control" required>
            </div>

            <div class="form-group" style="flex: 1;">
                <label class="form-label">Product Type</label>
                <input type="text" value="${productTypeName}" class="form-control" readonly 
                       style="background-color: #f5f5f5; cursor: not-allowed;">
            </div>
        </div>

        <div class="form-row" style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="form-group" style="flex: 1;">
                <label class="form-label">Category</label>
                <input type="text" name="category" value="${product.category}" class="form-control" required>
            </div>

            <div class="form-group" style="flex: 1;">
                <label class="form-label">Price ($)</label>
                <input type="number" step="0.01" name="price" value="${product.price}" class="form-control" required>
            </div>
        </div>

        <div class="form-row" style="display: flex; gap: 15px; margin-bottom: 15px;">
            <div class="form-group" style="flex: 1;">
                <label class="form-label">Stock Quantity</label>
                <input type="number" name="stockQuantity" value="${product.stockQuantity}" class="form-control" required>
            </div>

            <div class="form-group" style="flex: 1;">
                <label class="form-label">Ingredients</label>
                <input type="text" name="ingredients" value="${product.ingredients}" class="form-control">
            </div>
        </div>

        <div class="form-group" style="margin-bottom: 15px;">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" rows="3">${product.description}</textarea>
        </div>

        <div class="form-group" style="margin-bottom: 15px;">
            <label>
                <input type="checkbox" name="availability" value="true" <c:if test="${product.availability}">checked</c:if>>
                Available in Store
            </label>
        </div>

        <button type="submit" class="btn btn-primary">Update Product</button>
    </form>
</div>