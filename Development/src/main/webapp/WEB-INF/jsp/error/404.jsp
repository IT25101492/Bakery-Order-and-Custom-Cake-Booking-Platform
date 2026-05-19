<%-- 404.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Page Not Found — Bakery &amp; Custom Cake Booking</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<div class="auth-wrapper">
<div class="auth-card text-center">
<div class="auth-brand">
<h1>404</h1>
<p>The page you are looking for does not exist.</p>
</div>
<a href="${pageContext.request.contextPath}/login"
class="btn btn-primary mt-2">Return to Login</a>
</div>
</div>
</body>
</html>