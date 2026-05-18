<%-- customer/register.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<div class="auth-card">
    <div class="auth-brand">
        <h1>Bakery &amp; Custom Cake Booking</h1>
        <p>Create your account</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="post" novalidate id="registerForm">
        <div class="form-group">
            <label class="form-label" for="username">Username *</label>
            <input type="text" id="username" name="username" class="form-control"
                   placeholder="Choose a username" required maxlength="50">
        </div>
        <div class="form-group">
            <label class="form-label" for="email">Email Address *</label>
            <input type="email" id="email" name="email" class="form-control"
                   placeholder="e.g. john@example.com" required maxlength="100">
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label" for="password">Password *</label>
                <input type="password" id="password" name="password" class="form-control"
                       placeholder="Min. 8 chars, uppercase, number, special char" required maxlength="100">
            </div>
            <div class="form-group">
                <label class="form-label" for="confirmPassword">Confirm Password *</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                       placeholder="Re-enter password" required maxlength="100">
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control"
                       placeholder="e.g. +1-555-0101" maxlength="20">
            </div>
            <div class="form-group">
                <label class="form-label" for="deliveryAddress">Delivery Address *</label>
                <input type="text" id="deliveryAddress" name="deliveryAddress" class="form-control"
                       placeholder="Enter delivery address" required maxlength="200">
            </div>
        </div>
        <button type="submit" class="btn btn-primary btn-full mt-2">Create Account</button>
    </form>

    <hr class="auth-divider">
    <p class="text-center text-muted">
        Already have an account?
        <a href="${pageContext.request.contextPath}/login">Sign in</a>
    </p>
</div>

<script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        var pwd = document.getElementById('password').value;
        var confirm = document.getElementById('confirmPassword').value;
        var pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
        if (!pwdRegex.test(pwd)) {
            e.preventDefault();
            alert('Password must be at least 8 characters with an uppercase letter, number, and special character.');
        }
        if (pwd !== confirm) {
            e.preventDefault();
            alert('Passwords do not match.');
        }
    });
</script>