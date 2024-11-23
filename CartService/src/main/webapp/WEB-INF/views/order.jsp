<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.CART.entity.Order" %> 
<html>
<head>
    <title>Your Orders</title>
    <style>
        .container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            text-align: left;
            border: 1px solid #ddd;
        }
        th {
            background-color: #f2f2f2;
        }
        .no-orders {
            color: red;
            text-align: center;
        }
        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        .btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Your Orders</h2>

    <!-- Display error or success message -->
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        String message = (String) request.getAttribute("message");

        if (errorMessage != null) {
    %>
        <p style="color: red; text-align: center;"><%= errorMessage %></p>
    <%
        }

        if (message != null) {
    %>
        <p style="color: green; text-align: center;"><%= message %></p>
    <%
        }
    %>

    <!-- Display orders table if orders exist -->
    <%
        List<Order> orders = (List<Order>) request.getAttribute("orders");

        if (orders != null && !orders.isEmpty()) {
    %>
        <table>
            <tr>
                <th>Order ID</th>
                <th>Product</th>
                <th>Quantity</th>
                <th>Status</th>
                <th>Amount</th>
                <th>Order Date</th>
            </tr>
            <%
                for (Order order : orders) {
            %>
            <tr>
                <td><%= order.getId() %></td>
                <td><%= order.getProduct().getName() %></td> <!-- Assuming order has a product with a name -->
                <td><%= order.getQuantity() %></td>
                <td><%= order.getStatus() %></td>
                <td><%= order.getAmount() %></td>
                <td><%= order.getCreatedAt() %></td>
            </tr>
            <%
                }
            %>
        </table>
    <%
        } else {
    %>
        <p class="no-orders">You have no orders placed yet.</p>
    <%
        }
    %>

    <a href="/home" class="btn">Back to Home</a>
</div>

</body>
</html>
