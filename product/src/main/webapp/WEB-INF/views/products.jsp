<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.pro.entity.Category" %>
<%@ page import="com.example.pro.entity.SubCategory" %>
<%@ page import="com.example.pro.entity.Product" %>

<html>
<head>
    <title>Products</title>
    <link rel="stylesheet" href="styles.css" />
    <style>
        /* General Reset */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            background-color: #f8f8f8;
        }

        /* Container */
        .container {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            margin-right: 20px;
            background-color: #f4f4f4;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        }

        .sidebar h3 {
            font-size: 1.5em;
            margin-bottom: 15px;
            color: #333;
        }

        .sidebar ul {
            list-style-type: none;
        }

        .sidebar ul li {
            margin: 10px 0;
        }

        .sidebar ul li a {
            text-decoration: none;
            color: #007bff;
            font-size: 1em;
        }

        .sidebar ul li a:hover {
            text-decoration: underline;
        }

        /* Search Bar */
        .search-bar {
            width: 100%;
            padding: 10px;
            font-size: 1em;
            margin-bottom: 20px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

        /* Product List */
        .product-list {
            flex-grow: 1;
        }

        .product-list h3 {
            font-size: 2em;
            margin-bottom: 20px;
            color: #333;
        }

        .product-container {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 20px;
        }

        /* Product Item */
        .product-item {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .product-item:hover {
            transform: translateY(-5px); /* Lift effect */
        }

        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 15px;
        }

        h4 {
            font-size: 1.2em;
            margin-bottom: 10px;
        }

        .description {
            font-size: 0.9em;
            color: #555;
            margin-bottom: 10px;
        }

        .price {
            font-size: 1.1em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .stock-status {
            font-size: 1em;
            color: #007bff;
            margin-bottom: 15px;
        }

        /* Button Styling */
        .btn {
            display: inline-block;
            padding: 10px 15px;
            font-size: 1em;
            text-decoration: none;
            border-radius: 5px;
            transition: background-color 0.3s ease;
        }

        .view-details {
            background-color: #007bff;
            color: #fff;
            margin-right: 10px;
        }

        .view-details:hover {
            background-color: #0056b3;
        }

        .add-to-cart {
            background-color: #28a745;
            color: #fff;
        }

        .add-to-cart:hover {
            background-color: #218838;
        }

        .add-to-wishlist {
            background-color: #ffc107;
            color: #fff;
        }

        .add-to-wishlist:hover {
            background-color: #e0a800;
        }

        /* Form buttons inside forms */
        .btn-form {
            margin-top: 10px;
        }

        /* Filters Section */
        .filter-section {
            margin-bottom: 30px;
        }

        .filter-section select,
        .filter-section input[type="range"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }

    </style>
</head>
<body>
    <div class="container">
        <!-- Left Side: Filters -->
        <div class="sidebar">
            <h3>Categories</h3>
            <input type="text" placeholder="Search Categories..." class="search-bar" id="categorySearch" oninput="filterCategories()" />
            <ul id="categoryList">
                <!-- Loop through categories passed from the model -->
                <%
                    List<Category> categories = (List<Category>) request.getAttribute("categories");
                    for (Category category : categories) {
                %>
                    <li>
                        <a href="/products?category=<%= category.getName() %>"><%= category.getName() %></a>
                        <ul>
                            <!-- Loop through subcategories for each category -->
                            <%
                                List<SubCategory> subcategories = (List<SubCategory>) request.getAttribute("subcategories");
                                for (SubCategory subcategory : subcategories) {
                                    if (subcategory.getCategory().getName().equals(category.getName())) {
                            %>
                                        <li><a href="/products?subcategory=<%= subcategory.getName() %>"><%= subcategory.getName() %></a></li>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </li>
                <%
                    }
                %>
            </ul>

            <!-- Price Range Filter -->
            <div class="filter-section">
                <h4>Filter by Price</h4>
                <input type="range" min="0" max="5000" value="5000" id="priceFilter" onchange="filterByPrice()" />
                <p>Max Price: $<span id="priceValue">5000</span></p>
            </div>

        </div>

        <!-- Right Side: Products -->
        <div class="product-list">
            <h3>All Products</h3>
            <div class="product-container">
                <!-- Loop through products passed from the model -->
                <%
                    List<Product> products = (List<Product>) request.getAttribute("products");
                    for (Product product : products) {
                %>
                    <div class="product-item">
                        <img src="<%= product.getImage() %>" alt="<%= product.getName() %>" class="product-image"/>
                        <h4><%= product.getName() %></h4>
                        <p class="description"><%= product.getDescription() %></p>
                        <p class="price">Price: $<%= product.getPrice() %></p>
                        <p class="stock-status">In stock: <%= product.getQuantity() > 0 ? "Yes" : "No" %></p>
                        <a href="/products/product/<%= product.getId() %>" class="btn view-details">View Details</a>
                        <form action="/product/<%= product.getId() %>/add-to-cart" method="post" class="btn-form">
                            <button type="submit" class="btn add-to-cart">Add to Cart</button>
                        </form>
                        <form action="/product/<%= product.getId() %>/add-to-wishlist" method="post" class="btn-form">
                            <button type="submit" class="btn add-to-wishlist">Add to Wishlist</button>
                        </form>
                    </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>

    <script>
        function filterCategories() {
            var input = document.getElementById("categorySearch");
            var filter = input.value.toLowerCase();
            var ul = document.getElementById("categoryList");
            var li = ul.getElementsByTagName("li");

            for (var i = 0; i < li.length; i++) {
                var a = li[i].getElementsByTagName("a")[0];
                if (a.innerHTML.toLowerCase().indexOf(filter) > -1) {
                    li[i].style.display = "";
                } else {
                    li[i].style.display = "none";
                }
            }
        }

        function filterByPrice() {
            var price = document.getElementById("priceFilter").value;
            document.getElementById("priceValue").innerText = price;
            // Apply price filter logic here to update the displayed products
        }
    </script>
</body>
</html>
