<%-- 500.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Server Error — Bakery &amp; Custom Cake Booking</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
    <div class="auth-card text-center">
        <div class="auth-brand">
            <h1>500</h1>
            <p>An internal server error occurred. Please try again later.</p>
        </div>
        <a href="${pageContext.request.contextPath}/login"
           class="btn btn-primary mt-2">Return to Login</a>
    </div>
</div>
</body>
</html>