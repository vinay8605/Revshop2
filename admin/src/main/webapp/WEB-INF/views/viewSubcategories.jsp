<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.entity.Subcategory" %>
<%@ page import="com.example.entity.Category" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Subcategories</title>
</head>
<style>
    body {
        font-family: 'Arial', sans-serif;
        background-color: #f4f7fc;
        margin: 0;
        padding: 0;
    }

    h1 {
        text-align: center;
        color: #333;
        margin-top: 20px;
    }

    table {
        width: 80%;
        margin: 30px auto;
        border-collapse: collapse;
        background-color: #ffffff;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    th, td {
        padding: 12px 20px;
        text-align: left;
        border-bottom: 1px solid #ddd;
    }

    th {
        background-color: #4CAF50;
        color: white;
        font-size: 16px;
    }

    td {
        font-size: 14px;
        color: #555;
    }

    tr:hover {
        background-color: #f1f1f1;
    }

    .deactivated {
        background-color: #e74c3c;
        color: white;
        border: none;
        padding: 8px 16px;
        cursor: pointer;
        font-size: 14px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .deactivated:hover {
        background-color: #c0392b;
    }

    .deactivated:active {
        background-color: #b03a2e;
    }

    a {
        text-decoration: none;
        color: #3498db;
        font-size: 14px;
        display: inline-block;
        margin-top: 20px;
        text-align: center;
    }

    a:hover {
        color: #2980b9;
    }
</style>

<body>
    <%
        Category category = (Category) request.getAttribute("category");  // Cast to Category
    %>
    <h1>Subcategories for <%= category.getName() %></h1>

    <table border="1">
        <thead>
            <tr>
                <th>Subcategory ID</th>
                <th>Subcategory Name</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Subcategory> subcategories = (List<Subcategory>) request.getAttribute("subcategories");
                for (Subcategory subcategory : subcategories) {
            %>
                <tr>
                    <td><%= subcategory.getId() %></td>
                    <td><%= subcategory.getName() %></td>
                    <td>
                        <!-- Remove Subcategory Form with Confirmation -->
                        <form action="/admin/removeSubcategory" method="POST" style="display:inline;" onsubmit="return confirm('Are you sure you want to remove this subcategory?');">
                            <input type="hidden" name="subcategoryId" value="<%= subcategory.getId() %>">
                            <button type="submit" class="deactivated">Remove</button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>

    <br>
    <a href="/admin/stats">Back to Categories</a>
</body>
</html>
