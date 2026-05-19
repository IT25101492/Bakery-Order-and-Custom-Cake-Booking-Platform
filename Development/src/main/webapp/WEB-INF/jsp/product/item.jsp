<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="page-header" style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px;">
    <div>
        <h1 style="margin-bottom: 5px;">Bakery Items</h1>
        <p style="margin: 0;">Browse our delicious selection of bakery products.</p>
    </div>
    <form action="${pageContext.request.contextPath}/products/items" method="get" style="display: flex; gap: 10px; align-items: center;">
        <input type="text" name="keyword" class="form-control" placeholder="Search items..." value="${param.keyword}" style="padding: 8px 12px; border: 1px solid #ccc; border-radius: 4px; outline: none; min-width: 200px;">
        <button type="submit" class="btn btn-primary" style="padding: 8px 15px; border: none; border-radius: 4px; cursor: pointer;">Search</button>
        <c:if test="${not empty param.keyword}">
            <a href="${pageContext.request.contextPath}/products/items" class="btn btn-secondary" style="padding: 8px 15px; text-decoration: none; border: 1px solid #ccc; border-radius: 4px; background: #f9f9f9; color: #333; cursor: pointer;">Clear</a>
        </c:if>
    </form>
</div>

<div class="items-grid" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; padding: 20px 0;">
    <c:forEach var="product" items="${products}">
        <div class="card" style="display: flex; flex-direction: column; justify-content: space-between; height: 100%;">
            <div class="card-header" style="border-bottom: 1px solid #eee; padding-bottom: 10px;">
                <h3 style="margin: 0; color: #333; font-size: 1.2rem;">${product.name}</h3>
                <span style="font-size: 0.85rem; color: #666; display: block; margin-top: 5px;">${product.category}</span>
            </div>
            
            <div style="padding: 15px; flex-grow: 1;">
                <p style="margin: 0 0 10px 0; color: #555; line-height: 1.5;">${product.description}</p>
                <div style="margin-bottom: 10px;">
                    <strong>Ingredients:</strong> 
                    <span style="color: #666;">${product.ingredients}</span>
                </div>
                
                <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 15px;">
                    <span style="font-size: 1.25rem; font-weight: bold; color: #2c3e50;">$${product.price}</span>
                    <c:choose>
                        <c:when test="${product.availability}">
                            <span class="badge badge-active" style="background-color: #2ecc71; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.85rem;">Available</span>
                        </c:when>    
                        <c:otherwise>
                            <span class="badge badge-inactive" style="background-color: #e74c3c; color: white; padding: 4px 8px; border-radius: 4px; font-size: 0.85rem;">Out of Stock</span>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <c:if test="${product.availability}">
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" style="margin-top: 10px;">
                        <input type="hidden" name="productId" value="${product.productId}">
                        <button type="submit" class="btn btn-primary" style="width: 100%; padding: 8px;">Add to Cart</button>
                    </form>
                </c:if>
            </div>
        </div>
        
    </c:forEach>
    <c:if test="${empty products}">
        <div style="grid-column: 1 / -1; text-align: center; padding: 40px; background: #f9f9f9; border-radius: 8px; color: #666;">
            <p>No bakery items found. Please check back later!</p>
        </div>
    </c:if>
</div>