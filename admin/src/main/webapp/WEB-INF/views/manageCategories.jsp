<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.example.entity.Category" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Categories</title>
</head>
<body>
    <h1>Manage Categories</h1>

    <table border="1">
        <thead>
            <tr>
                <th>Category ID</th>
                <th>Category Name</th>
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
                        <!-- Remove Category Form with Confirmation -->
                        <form action="/admin/removeCategory" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to remove this category?');">
                            <input type="hidden" name="categoryId" value="<%= category.getId() %>">
                            <button type="submit" class="deactivated">Remove</button>
                        </form>

                        <!-- View Category Form -->
                        <form action="/admin/viewCategory/<%= category.getId() %>" method="GET" style="display:inline;">
                            <button type="submit" class="active">View Subcategories</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

</body>
</html>
