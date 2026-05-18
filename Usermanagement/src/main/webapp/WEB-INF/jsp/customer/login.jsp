<%-- customer/login.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="auth-card">
    <div class="auth-brand">
        <h1>Bakery &amp; Custom Cake Booking</h1>
        <p>Sign in to your account</p>
    </div>

    <c:if test="${param.registered == 'true'}">
        <div class="alert alert-success">Account created successfully. Please sign in.</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/login" method="post" novalidate id="loginForm">
        <div class="form-group">
            <label class="form-label" for="loginIdentifier">Username or Email Address *</label>
            <input type="text" id="loginIdentifier" name="loginIdentifier" class="form-control"
                   value="<c:out value='${loginIdentifier}'/>"
                   placeholder="Enter username or email" required autofocus>
        </div>
        <div class="form-group">
            <label class="form-label" for="password">Password *</label>
            <input type="password" id="password" name="password" class="form-control"
                   placeholder="Enter your password" required>
        </div>
        <button type="submit" class="btn btn-primary btn-full mt-2">Sign In</button>
    </form>

    <hr class="auth-divider">
    <p class="text-center text-muted">
        Don't have an account?
        <a href="${pageContext.request.contextPath}/register">Register here</a>
    </p>
</div>