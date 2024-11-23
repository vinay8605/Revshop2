<%@ page contentType="text/html;charset=UTF-8" language="java" import="java.util.List, com.CART.entity.Cart"%>
<%@ page import="java.util.Base64" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>

    <!-- Include Bootstrap CSS for styling -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- Flipkart-like custom styles -->
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }

        .container {
            max-width: 1200px;
            margin-top: 50px;
        }

        .cart-table th, .cart-table td {
            text-align: center;
            vertical-align: middle;
        }

        .cart-table {
            background-color: white;
            border-radius: 8px;
            overflow: hidden;
            margin-top: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .cart-table th {
            background-color: #f1f1f1;
            color: #333;
        }

        .cart-table td {
            padding: 15px;
        }

        .btn-update {
            background-color: #ff8c00;
            color: white;
            border: none;
            padding: 8px 16px;
            font-size: 14px;
            cursor: pointer;
        }

        .btn-update:hover {
            background-color: #e07b00;
        }

        .btn-remove {
            color: #e60000;
            text-decoration: none;
            font-weight: bold;
        }

        .btn-remove:hover {
            color: #ff1a1a;
        }

        .cart-summary {
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
        }

        .checkout-btn {
            background-color: #ff8c00;
            color: white;
            padding: 12px 24px;
            font-size: 16px;
            text-align: center;
            border-radius: 4px;
            text-decoration: none;
            display: block;
            width: 100%;
        }

        .checkout-btn:hover {
            background-color: #e07b00;
        }

        .empty-cart-message {
            text-align: center;
            margin-top: 50px;
            font-size: 18px;
            color: #333;
        }
        /* General Navbar Styling */
.navbar {
    background-color: #333;
    padding: 10px 20px;
    font-family: 'Arial', sans-serif;
}

.nav-links {
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    justify-content: flex-start;
    align-items: center;
}

.nav-link {
    color: #f1f1f1;
    text-decoration: none;
    margin: 0 15px;
    font-size: 16px;
    padding: 8px 12px;
    transition: color 0.3s ease, background-color 0.3s ease;
}

.nav-link:hover {
    color: #fff;
    background-color: #007BFF;
    border-radius: 5px;
}

.badge {
    background-color: #FF6347;
    color: white;
    border-radius: 50%;
    padding: 2px 8px;
    font-size: 12px;
    vertical-align: middle;
}

/* For mobile responsiveness */
@media (max-width: 768px) {
    .nav-links {
        flex-direction: column;
        align-items: flex-start;
    }

    .nav-link {
        margin: 10px 0;
        font-size: 18px;
    }
}
        
    </style>
</head>
<body>
 <nav class="navbar">
        <ul class="nav-links">
            <li><a href="/products">Products</a></li>
            <%
                String buyerId = (String) request.getAttribute("buyerId"); // Assuming 'buyerId' is passed as a request attribute
                if (buyerId != null) {
            %>
                <li>
                    <a href="/cart/view" class="nav-item">
                        View Cart <span class="badge" id="cart-badge">0</span> <!-- Add JavaScript for dynamic count -->
                    </a>
                </li>
                <li><a href="/products/view">Wishlist</a></li>
                <li><a href="/profile">Profile</a></li>
                <li><a href="/cart/orders">Home</a></li>
            <%
                }
            %>
        </ul>
    </nav>
   

<div class="container">
    <h2 class="text-center">Your Shopping Cart</h2>

    <%-- Display error message if any --%>
    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) { 
    %>
        <p class="alert alert-danger"><%= errorMessage %></p>
    <% } %>

    <%-- Display cart items if available --%>
    <%
        List<Cart> cartItems = (List<Cart>) request.getAttribute("cartItems");
        if (cartItems != null && !cartItems.isEmpty()) { 
    %>
    <div class="cart-table table-responsive">
        <table class="table table-bordered table-striped">
            <thead>
                <tr>
                    <th>Product Name</th>
                    <th>Image<th>
                    <th>Quantity</th>
                    <th>Price</th>
                    <th>Total</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Cart cartItem : cartItems) {
                    double totalPrice = cartItem.getQuantity() * cartItem.getProduct().getPrice(); 
                %>
                <tr>
                    <td><%= cartItem.getProduct().getName() %></td>
                 <%
    // Assuming getImage() returns a byte[] for the image BLOB
    byte[] imageBytes = cartItem.getProduct().getImage(); 
    String base64Image = "";

    if (imageBytes != null) {
        base64Image = Base64.getEncoder().encodeToString(imageBytes);
    }
%>
<td>
    <%-- Use base64 encoding to embed the image data --%>
    <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image" style="width: 100px; height: auto;">
</td>
                    <td>
                        <form action="/cart/update" method="post">
                            <input type="number" name="quantity" value="<%= cartItem.getQuantity() %>" min="1" required class="form-control">
                            <input type="hidden" name="cartId" value="<%= cartItem.getCartId() %>">
                            <button type="submit" class="btn-update">Update</button>
                        </form>
                    </td>
                    <td><%= cartItem.getProduct().getPrice() %></td>
                    <td><%= totalPrice %></td>
                    <td>
                        <a href="/cart/remove?cartId=<%= cartItem.getCartId() %>" class="btn-remove">Remove</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
    
    <div class="cart-summary">
        <h3>Total Price: <%= request.getAttribute("totalPrice") %></h3>
        <a href="/cart/checkout" class="checkout-btn">Proceed to Checkout</a>
    </div>
    <% } else { %>
        <p class="empty-cart-message">Your cart is empty. <a href="/products" class="btn btn-primary">Browse products</a></p>
    <% } %>

</div>

<!-- Include Bootstrap JS for better functionality (like form handling) -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
