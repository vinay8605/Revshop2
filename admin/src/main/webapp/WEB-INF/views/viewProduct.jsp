<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.example.entity.Product" %>
<%@ page import="com.example.entity.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Details</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f7fc;
            color: #333;
        }
        .container {
            width: 60%;
            margin: 40px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }
        img {
            max-width: 100%;
            height: auto;
        }
        h1 {
            text-align: center;
        }
        p {
            line-height: 1.6;
        }
        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
            text-decoration: none;
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
        }
        .back-link:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Product Details</h1>

    <!-- Display Product details using JSP expressions -->
    <p><strong>Product ID:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getId() : "" %></p>
    <p><strong>Name:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getName() : "" %></p>
    <p><strong>Description:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getDescription() : "" %></p>
    <p><strong>Color:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getColor() : "" %></p>
    <p><strong>Size:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getSize() : "" %></p>
    <p><strong>Price:</strong> $<%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getPrice() : "" %></p>
    <p><strong>Discount Price:</strong> $<%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getDiscountPrice() : "" %></p>
    <p><strong>Quantity Available:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getQuantity() : "" %></p>
    <p><strong>Category:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getCategory().getName() : "" %></p>
    <p><strong>Subcategory:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getSubcategory().getName() : "" %></p>
    <p><strong>Seller ID:</strong> <%= request.getAttribute("product") != null ? ((Product) request.getAttribute("product")).getSellerId() : "" %></p>

    <!-- Display product image if available -->
    <% 
        Product product = (Product) request.getAttribute("product"); 
        if (product != null && product.getImage() != null && product.getImage().length > 0) {
            String base64Image = java.util.Base64.getEncoder().encodeToString(product.getImage());
    %>
        <img src="data:image/jpeg;base64,<%= base64Image %>" alt="Product Image">
    <% } else { %>
        <p>No image available for this product.</p>
    <% } %>

    

    <a href="/admin/stats" class="back-link">Back to Admin Dashboard</a>
</div>

</body>
</html>
