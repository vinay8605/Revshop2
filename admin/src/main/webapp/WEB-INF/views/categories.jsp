
<%@ page import="java.util.List" %>
<%@ page import="com.example.entity.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
    <link rel="stylesheet" href="styles.css"> <!-- Assuming styles are saved as styles.css -->
</head>
<body>
    <h1>Categories</h1>
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
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                for (Category category : categories) {
            %>
                <tr>
                    <td><%= category.getId() %></td>
                    <td><%= category.getName() %></td>
                    <td>
                        <!-- Remove Category Form -->
                        <form action="/admin/removeCategory" method="POST" style="display:inline;">
                            <input type="hidden" name="categoryId" value="<%= category.getId() %>">
                            <button type="submit" class="deactivated">Remove</button>
                        </form>
                        
                        <!-- View Category Form -->
                        <form action="/admin/viewCategory/<%= category.getId() %>" method="GET" style="display:inline;">
                            <button type="submit" class="active">View</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
