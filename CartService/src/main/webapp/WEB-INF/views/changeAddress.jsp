<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.demo.entity.Buyer" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Change Address</title>
    <!-- Add necessary styles and Bootstrap -->
</head>
<body>
    <div class="container">
        <h2>Change Address</h2>

        <% 
            // Retrieve buyer details (including address) from the session
            Buyer buyer = (Buyer) request.getAttribute("buyer");
            if (buyer != null) {
        %>
        <form action="/checkout/updateAddress" method="post">
            <div class="form-group">
                <label for="address">Address</label>
                <input type="text" class="form-control" id="address" name="address" value="<%= buyer.getAddress() %>" required>
            </div>
            <div class="form-group">
                <label for="city">City</label>
                <input type="text" class="form-control" id="city" name="city" value="<%= buyer.getCity() %>" required>
            </div>
            <div class="form-group">
                <label for="state">State</label>
                <input type="text" class="form-control" id="state" name="state" value="<%= buyer.getState() %>" required>
            </div>
            <div class="form-group">
                <label for="pincode">Pincode</label>
                <input type="text" class="form-control" id="pincode" name="pincode" value="<%= buyer.getPincode() %>" required>
            </div>
            <div class="form-group">
                <label for="phoneNumber">Phone Number</label>
                <input type="text" class="form-control" id="phoneNumber" name="phoneNumber" value="<%= buyer.getPhoneNumber() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Address</button>
        </form>
        <% } else { %>
            <p>Error: Buyer details not found.</p>
        <% } %>
    </div>
</body>
</html>
