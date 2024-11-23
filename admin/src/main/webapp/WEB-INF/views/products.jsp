<%@ page import="java.util.List" %>
<%@ page import="com.example.entity.Product" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Products</title>
    <link rel="stylesheet" href="styles.css"> <!-- Assuming styles are saved as styles.css -->
    <script>
        function confirmRemoval() {
            return confirm("Are you sure you want to remove this product?");
        }
    </script>
</head>
<body>
    <h1>Products</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Product> products = (List<Product>) request.getAttribute("products");
                for (Product product : products) {
            %>
                <tr>
                    <td><%= product.getId() %></td>
                    <td><%= product.getName() %></td>
                    <td><%= product.getDescription() %></td>
                    <td>
                        <!-- Remove Product Form with Confirmation -->
                        <form action="/admin/removeProduct" method="POST" style="display:inline;" onsubmit="return confirmRemoval();">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <button type="submit" class="deactivated">Remove</button>
                        </form>
                        
                        <!-- View Product Form -->
                        <form action="/admin/viewProduct/<%= product.getId() %>" method="GET" style="display:inline;">
                            <button type="submit" class="active">View</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
html>