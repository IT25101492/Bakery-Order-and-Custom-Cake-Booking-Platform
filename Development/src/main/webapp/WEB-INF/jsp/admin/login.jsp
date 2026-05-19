<%-- admin/login.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="auth-card">
    <div class="auth-brand">
        <h1>Administration Panel</h1>
        <p>Bakery &amp; Custom Cake Booking Platform</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/admin/login" method="post" novalidate id="adminLoginForm">
        <div class="form-group">
            <label class="form-label" for="loginIdentifier">Username or Email *</label>
            <input type="text" id="loginIdentifier" name="loginIdentifier" class="form-control"
                   value="<c:out value='${loginIdentifier}'/>"
                   placeholder="Admin username or email" required autofocus>
        </div>
        <div class="form-group">
            <label class="form-label" for="password">Password *</label>
            <input type="password" id="password" name="password" class="form-control"
                   placeholder="Admin password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-full mt-2">Access Administration Panel</button>
    </form>
</div>