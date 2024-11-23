<%@ page import="java.util.List" %>
<%@ page import="com.example.entity.Seller" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Sellers</title>
    <link rel="stylesheet" href="styles.css"> <!-- Assuming styles are saved as styles.css -->
</head>
<body>
    <h1>Sellers</h1>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Mobile Number</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <% 
                List<Seller> sellers = (List<Seller>) request.getAttribute("sellers");
                for (Seller seller : sellers) {
            %>
                <tr>
                    <td><%= seller.getId() %></td>
                    <td><%= seller.getName() %></td>
                    <td><%= seller.getEmail() %></td>
                    <td><%= seller.getMobileNumber() %></td>
                    <td><%= seller.isAccountStatus() ? "Active" : "Deactivated" %></td>
                    <td>
                        <form action="/admin/updateSellerStatus" method="POST">
                            <input type="hidden" name="id" value="<%= seller.getId() %>">
                            <input type="hidden" name="accountStatus" value="<%= seller.isAccountStatus() ? "false" : "true" %>">
                            <button type="submit" class="<%= seller.isAccountStatus() ? "deactivated" : "active" %>">
                                <%= seller.isAccountStatus() ? "Deactivate" : "Activate" %>
                            </button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
