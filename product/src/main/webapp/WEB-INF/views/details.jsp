<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Details</title>
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
            background-color: #f8f8f8;
            color: #333;
            line-height: 1.6;
        }

        /* Container */
        .container {
            display: flex;
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        }

        /* Left Side: Product Image */
        .product-image-container {
            flex: 1;
            padding-right: 20px;
        }

        .product-image {
            width: 100%;
            height: auto;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        /* Right Side: Product Info */
        .product-info {
            flex: 2;
        }

        .product-info h3 {
            font-size: 2.5em;
            margin-bottom: 20px;
            color: #0073e6;
        }

        .product-info p {
            font-size: 1.2em;
            margin-bottom: 20px;
            color: #555;
        }

        .product-info .price {
            font-size: 1.6em;
            font-weight: bold;
            color: #e60000;
            margin-bottom: 20px;
        }

        .product-info .stock-status {
            font-size: 1.2em;
            margin-bottom: 20px;
            color: #28a745; /* Green for in-stock */
        }

        /* Buttons */
        .button-container {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 20px;
            font-size: 1.1em;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn.add-to-cart {
            background-color: #ff9900;
        }

        .btn.add-to-cart:hover {
            background-color: #e68a00;
        }

        .btn.add-to-wishlist {
            background-color: #0073e6;
        }

        .btn.add-to-wishlist:hover {
            background-color: #005bb5;
        }

        /* Responsive Layout */
        @media (max-width: 768px) {
            .container {
                flex-direction: column;
                align-items: center;
            }

            .product-image-container {
                padding-right: 0;
                margin-bottom: 20px;
            }

            .product-info {
                text-align: center;
            }
        }
    </style>
</head>
<body>

    <div class="container">
        <!-- Left Side: Product Image -->
        <div class="product-image-container">
            <img src="${product.image}" alt="${product.name}" class="product-image" />
        </div>

        <!-- Right Side: Product Info -->
        <div class="product-info">
            <h3>${product.name}</h3>
            <p class="description">${product.description}</p>
            <p class="price">$${product.price}</p>
            <p class="stock-status">${product.quantity > 0 ? 'In Stock' : 'Out of Stock'}</p>

            <div class="button-container">
                <!-- Add to Cart Button -->
                <form action="/product/${product.id}/add-to-cart" method="post">
                    <button type="submit" class="btn add-to-cart">Add to Cart</button>
                </form>

                <!-- Add to Wishlist Button -->
                <form action="/product/${product.id}/add-to-wishlist" method="post">
                    <button type="submit" class="btn add-to-wishlist">Add to Wishlist</button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
