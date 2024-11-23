<%@ page contentType="text/html;charset=UTF-8" language="java" import="com.demo.entity.Buyer, com.CART.entity.Cart, java.util.List" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <!-- Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            background-color: #ffffff;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        h2, h4 {
            color: #333;
            margin-bottom: 20px;
        }
        .table {
            margin-bottom: 20px;
        }
        .table th, .table td {
            vertical-align: middle;
        }
        .btn-primary, .btn-success {
            margin-top: 15px;
            border-radius: 25px;
            padding: 10px 20px;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-success {
            background-color: #28a745;
            border: none;
        }
        select {
            width: 100%;
            padding: 8px;
            margin-top: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Checkout</h2>

        <% 
            // Retrieve buyer details (including address) from the model
            Buyer buyer = (Buyer) request.getAttribute("buyer");  // Assuming 'buyer' is passed as model attribute
            if (buyer != null) {
        %>
            <h4>Billing Address:</h4>
            <div class="mb-3">
                <p><strong>Name:</strong> <%= buyer.getName() %></p>
                <p><strong>Address:</strong> <%= buyer.getAddress() %></p>
                <p><strong>City:</strong> <%= buyer.getCity() %></p>
                <p><strong>State:</strong> <%= buyer.getState() %> <strong>Pincode:</strong> <%= buyer.getPincode() %></p>
                <button class="btn btn-primary" id="changeAddressBtn">Change Address</button>
                <div id="addressForm" style="display: none; margin-top: 20px;">
                    <form action="/cart/updateAddress" method="post">

                        <div class="form-group">
                            <label for="address">Address:</label>
                            <input type="text" id="address" name="address" value="<%= buyer.getAddress() %>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="city">City:</label>
                            <input type="text" id="city" name="city" value="<%= buyer.getCity() %>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="state">State:</label>
                            <input type="text" id="state" name="state" value="<%= buyer.getState() %>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="pincode">Pincode:</label>
                            <input type="text" id="pincode" name="pincode" value="<%= buyer.getPincode() %>" class="form-control" required>
                        </div>
                        <div class="form-group">
                            <label for="phoneNumber">Phone Number:</label>
                            <input type="text" id="phoneNumber" name="phoneNumber" value="<%= buyer.getPhoneNumber() %>" class="form-control" required>
                        </div>
                        <button type="submit" class="btn btn-success">Update Address</button>
                    </form>
                </div>
            </div>
        <% } %>

        <!-- Cart Items -->
        <h4>Your Order Summary</h4>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    // Display cart items from the model
                    List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");  // Assuming 'cartItems' is passed as model attribute
                    double totalPrice = 0;
                    for (Cart cartItem : cartItems) {
                        double itemTotal = cartItem.getQuantity() * cartItem.getProduct().getPrice();
                        totalPrice += itemTotal;
                %>
                <tr>
                    <td><%= cartItem.getProduct().getName() %></td>
                    <td><%= cartItem.getQuantity() %></td>
                    <td>&#8377; <%= cartItem.getProduct().getPrice() %></td>
                    <td>&#8377; <%= itemTotal %></td>
                </tr>
                <% } %>
            </tbody>
        </table>

        <h4>Total: &#8377; <%= totalPrice %></h4>

        <!-- Payment Option -->
        <form action="/cart/placeOrder" method="post">
            <!-- Include total price, and buyer address details -->
            <input type="hidden" name="totalPrice" value="<%= totalPrice %>">
            <input type="hidden" name="address" value="<%= buyer.getAddress() %>">
            <input type="hidden" name="city" value="<%= buyer.getCity() %>">
            <input type="hidden" name="state" value="<%= buyer.getState() %>">
            <input type="hidden" name="pincode" value="<%= buyer.getPincode() %>">
            <input type="hidden" name="phoneNumber" value="<%= buyer.getPhoneNumber() %>">

            <!-- Choose payment method -->
            <label for="paymentMethod">Payment Method:</label>
            <select name="paymentMethod" id="paymentMethod">
                <option value="Credit Card">Credit Card</option>
                <option value="Debit Card">Debit Card</option>
                <option value="PayPal">PayPal</option>
                <option value="Cash On Delivery">Cash On Delivery</option>
            </select>

            <button type="submit" class="btn btn-success">Proceed to Pay</button>
        </form>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle visibility of the address form
        document.getElementById('changeAddressBtn').addEventListener('click', function() {
            var form = document.getElementById('addressForm');
            form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
        });
    </script>
</body>
</html>
