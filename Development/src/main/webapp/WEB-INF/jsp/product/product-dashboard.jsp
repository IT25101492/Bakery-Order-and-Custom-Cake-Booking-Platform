<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header">
    <h1>Product Management</h1>
    <p>Add, update, or remove bakery products.</p>
</div>

<div class="card" style="margin-bottom: 20px;">
    <div class="card-header">
        <h2>Search Products</h2>
    </div>
    <form action="${pageContext.request.contextPath}/admin/products/search" method="get" class="search-bar" style="padding: 15px; display: flex; gap: 10px;">
        <input type="text" name="keyword" class="form-control"
               placeholder="Enter product name..." value="${param.keyword}" style="flex: 1;">
        <button type="submit" class="btn btn-outline btn-sm" style="color: black; border-color: black;">Search</button>
        <c:if test="${not empty param.keyword}">
            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary" style="display: flex; align-items: center;">Clear</a>
        </c:if>
    </form>
</div>

<div class="card">
    <div class="card-header">
        <h2>Product Catalog</h2>
        <a href="${pageContext.request.contextPath}/admin/products?action=add" class="btn btn-primary btn-sm">Add Product</a>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Stock</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>#${product.productId}</td>
                        <td><strong>${product.name}</strong></td>
                        <td>${product.category}</td>
                        <td>$${product.price}</td>
                        <td>${product.stockQuantity}</td>
                        <td>
                            <c:choose>
                                <c:when test="${product.availability}">
                                    <span class="badge badge-active">Available</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge badge-inactive">Out of Stock</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/products?action=edit&id=${product.productId}" class="btn btn-secondary btn-sm">Edit</a>
                            <a href="${pageContext.request.contextPath}/admin/products/delete/${product.productId}" class="btn btn-danger btn-sm"
                               onclick="return confirm('Are you sure you want to delete this product?');">
                               Delete
                            </a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>