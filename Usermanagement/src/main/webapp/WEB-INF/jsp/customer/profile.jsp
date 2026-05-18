<%-- customer/profile.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<c:if test="${not empty successMessage}">
    <div class="alert alert-success">${successMessage}</div>
</c:if>
<c:if test="${not empty errorMessage}">
    <div class="alert alert-danger">${errorMessage}</div>
</c:if>

<form action="${pageContext.request.contextPath}/profile" method="post" novalidate id="profileForm">
    <div class="card">
        <div class="card-header"><h2>Personal Information</h2></div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label" for="username">Username</label>
                <input type="text" id="username" name="username" class="form-control"
                       value="<c:out value='${customer.username}'/>" maxlength="50" required>
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Email Address</label>
                <input type="email" id="email" name="email" class="form-control"
                       value="<c:out value='${customer.email}'/>" maxlength="100" required>
            </div>
        </div>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label" for="phoneNumber">Phone Number</label>
                <input type="tel" id="phoneNumber" name="phoneNumber" class="form-control"
                       value="<c:out value='${customer.phoneNumber}'/>" maxlength="20">
            </div>
            <div class="form-group">
                <label class="form-label" for="deliveryAddress">Delivery Address</label>
                <textarea id="deliveryAddress" name="deliveryAddress" class="form-control" rows="2"
                          maxlength="255"><c:out value='${customer.deliveryAddress}'/></textarea>
            </div>
        </div>
    </div>

    <div class="card mt-2" id="change-password">
        <div class="card-header"><h2>Change Password</h2></div>
        <p class="text-muted mb-2">Leave blank if you do not wish to change your password.</p>
        <div class="form-row">
            <div class="form-group">
                <label class="form-label" for="newPassword">New Password</label>
                <input type="password" id="newPassword" name="newPassword" class="form-control"
                       placeholder="Enter new password" maxlength="100">
                <span class="form-hint">Min. 8 chars with uppercase, number &amp; special character.</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="confirmPassword">Confirm New Password</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="form-control"
                       placeholder="Re-enter new password" maxlength="100">
            </div>
        </div>
    </div>

    <div class="d-flex gap-1">
        <button type="submit" class="btn btn-primary">Save Changes</button>
        <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline">Cancel</a>
    </div>
</form>

<script>
    document.getElementById('profileForm').addEventListener('submit', function(e) {
        var newPwd = document.getElementById('newPassword').value;
        var confirm = document.getElementById('confirmPassword').value;
        if (newPwd) {
            var pwdRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$/;
            if (!pwdRegex.test(newPwd)) {
                e.preventDefault();
                alert('Password must be at least 8 characters with uppercase, number, and special character.');
                return;
            }
            if (newPwd !== confirm) {
                e.preventDefault();
                alert('Passwords do not match.');
            }
        }
    });
</script>