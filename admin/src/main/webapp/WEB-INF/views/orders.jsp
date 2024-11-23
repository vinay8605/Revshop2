<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<meta charset="UTF-8">

<%@ page import="java.util.List" %>

<%@ page import="com.example.entity.Orders" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Orders</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            color: #333;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
            color: #4CAF50;
            padding: 20px 0;
        }

        .container {
            width: 80%;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        form {
            display: flex;
            justify-content: space-between;
            margin-bottom: 30px;
        }

        label {
            font-size: 16px;
            margin-right: 10px;
        }

        input, select {
            padding: 8px;
            font-size: 14px;
            margin-right: 20px;
            width: 200px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button {
            padding: 10px 15px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #f2f2f2;
            color: #333;
        }

        td {
            background-color: #fff;
        }

        select {
            font-size: 14px;
        }

        .actions form {
            display: inline-block;
        }

        .load-more-btn {
            display: block;
            width: 200px;
            margin: 20px auto;
            background-color: #008CBA;
            border-radius: 4px;
            padding: 10px 0;
            text-align: center;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .load-more-btn:hover {
            background-color: #007b8f;
        }

        /* Style for the emoji */
        .emoji-link {
            font-size: 30px;
            text-decoration: none;
            color: inherit;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .emoji-link:hover {
            transform: scale(1.2);
            color: #4CAF50;
        }
    </style>
</head>
<body>
    <h1>Order Management</h1>

    <div class="container">
        <!-- Filter Form -->
        <h2>Filter Orders</h2>
        <form action="/admin/orders/filter" method="get">
            <label for="date">Date:</label>
            <input type="date" id="date" name="date">

            <label for="productName">Product Name:</label>
            <input type="text" id="productName" name="productName">

            <label for="buyerName">Buyer Name:</label>
            <input type="text" id="buyerName" name="buyerName">

            <button type="submit">Filter</button>
        </form>

        <!-- Display Orders Table -->
        <h2>All Orders</h2>

        <!-- Emoji with clickable link -->
        <a href="/admin/orders" class="emoji-link">
            🚚
        </a>

        <table border="1">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Buyer Name</th>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Order Date</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="ordersTable">
                <%-- Iterate over orders list and display them --%>
                <% 
                    List<Orders> orders = (List<Orders>) request.getAttribute("orders");
                    if (orders != null && !orders.isEmpty()) {
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                        for (Orders order : orders) {
                %>
                    <tr>
                        <td><%= order.getId() %></td>
                        <td><%= order.getBuyer().getName() %></td> <!-- Assuming Order has Buyer -->
                        <td><%= order.getProduct().getName() %></td> <!-- Assuming Order has Product -->
                        <td><%= order.getQuantity() %></td>
                        <td><%= sdf.format(order.getCreatedAt()) %></td>
                        <td><%= order.getStatus() %></td>
                        <td class="actions">
                            <!-- Form to update order status -->
                            <form action="/admin/orders/<%= order.getId() %>/status" method="post">
                                <select name="status" required>
                                    <option value="Processing" <%= order.getStatus().equals("Processing") ? "selected" : "" %>>Processing</option>
                                    <option value="Shipped" <%= order.getStatus().equals("Shipped") ? "selected" : "" %>>Shipped</option>
                                    <option value="Delivered" <%= order.getStatus().equals("Delivered") ? "selected" : "" %>>Delivered</option>
                                    <option value="Canceled" <%= order.getStatus().equals("Canceled") ? "selected" : "" %>>Canceled</option>
                                </select>
                                <button type="submit">Update Status</button>
                            </form>
                        </td>
                    </tr>
                <% 
                        }
                    } else { 
                %>
                    <tr>
                        <td colspan="7">No orders found for the given filters.</td>
                    </tr>
                <% 
                    }
                %>
            </tbody>
        </table>

        <!-- Load More Button -->
        <div class="load-more-btn">
            <a href="/admin/stats" class="load-more-link">
                <button type="button">Back to Dashboard</button>
            </a>
        </div>
    </div>

</body>
</html>
