<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Bakery &amp; Custom Cake Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-card">

        <!-- Brand Header -->
        <div class="auth-brand">
            <h1>Bakery &amp; Custom Cake Booking</h1>
            <p>Create your customer account</p>
        </div>

        <!-- Error Message -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">${errorMessage}</div>
        </c:if>

        <!-- Registration Form -->
        <form action="${pageContext.request.contextPath}/register"
              method="post" novalidate id="registerForm">

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="username">Username *</label>
                    <input type="text" id="username" name="username"
                           class="form-control"
                           value="<c:out value='${username}'/>"
                           placeholder="e.g. john_doe"
                           required maxlength="50">
                </div>
                <div class="form-group">
                    <label class="form-label" for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName"
                           class="form-control"
                           value="<c:out value='${fullName}'/>"
                           placeholder="e.g. John Doe"
                           maxlength="100">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="email">Email Address *</label>
                <input type="email" id="email" name="email"
                       class="form-control"
                       value="<c:out value='${email}'/>"
                       placeholder="e.g. john@example.com"
                       required maxlength="100">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label" for="password">Password *</label>
                    <input type="password" id="password" name="password"
                           class="form-control"
                           placeholder="Min. 8 characters"
                           required maxlength="100">
                    <span class="form-hint">
                        Must include uppercase, number &amp; special character.
                    </span>
                </div>
                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm Password *</label>
                    <input type="password" id="confirmPassword" name="confirmPassword"
                           class="form-control"
                           placeholder="Re-enter password"
                           required maxlength="100">
                </div>
            </div>

            <div class="form-group">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                <input type="tel" id="phoneNumber" name="phoneNumber"
                       class="form-control"
                       value="<c:out value='${phoneNumber}'/>"
                       placeholder="e.g. +1-555-0101"
                       maxlength="20">
            </div>

            <div class="form-group">
                <label class="form-label" for="deliveryAddress">Delivery Address</label>
                <textarea id="deliveryAddress" name="deliveryAddress"
                          class="form-control" rows="2"
                          placeholder="Enter your default delivery address"
                          maxlength="255"><c:out value='${deliveryAddress}'/></textarea>
            </div>

            <button type="submit" class="btn btn-primary btn-full mt-2">
                Create Account
            </button>
        </form>

        <hr class="auth-divider">

        <p class="text-center text-muted">
            Already have an account?
            <a href="${pageContext.request.contextPath}/login">Sign in here</a>
        </p>

    </div>
</div>

<!-- Client-Side Validation -->
<script>
    document.getElementById('registerForm').addEventListener('submit', function(e) {
        const username  = document.getElementById('username').value.trim();
        const email     = document.getElementById('email').value.trim();
        const password  = document.getElementById('password').value;
        const confirm   = document.getElementById('confirmPassword').value;

        if (!username || !email || !password || !confirm) {
            e.preventDefault();
            alert('Please fill in all required fields.');
            return;
        }

        // Password strength check
        const pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
        if (!pwdRegex.test(password)) {
            e.preventDefault();
            alert('Password must be at least 8 characters and include an uppercase letter, a number, and a special character.');
            return;
        }

        if (password !== confirm) {
            e.preventDefault();
            alert('Passwords do not match.');
        }
    });
</script>

</body>
</html>