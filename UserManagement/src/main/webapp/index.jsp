<%-- Redirects to the customer login page. --%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%  // Redirect to customer login on application start
    response.sendRedirect(request.getContextPath() + "/login"); %>