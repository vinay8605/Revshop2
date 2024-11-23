<%@ page import="java.util.List" %>
<%@ page import="com.example.entity.Buyer" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Buyers</title>
    <link rel="stylesheet" href="styles.css"> <!-- Assuming styles are saved as styles.css -->
</head>
<body>
    <h1>Buyers</h1>
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
                List<Buyer> buyers = (List<Buyer>) request.getAttribute("buyers");
                for (Buyer buyer : buyers) {
            %>
                <tr>
                    <td><%= buyer.getId() %></td>
                    <td><%= buyer.getName() %></td>
                    <td><%= buyer.getEmail() %></td>
                    <td><%= buyer.getphone_number() %></td>
                    <td><%= buyer.isApproval_status() ? "Active" : "Deactivated" %></td>
                    <td>
                        <form action="/admin/updateBuyerStatus" method="POST">
                            <input type="hidden" name="id" value="<%= buyer.getId() %>">
                            <input type="hidden" name="approval_status" value="<%= buyer.isApproval_status() ? "false" : "true" %>">
                            <button type="submit" class="<%= buyer.isApproval_status() ? "deactivated" : "active" %>">
                                <%= buyer.isApproval_status() ? "Deactivate" : "Activate" %>
                            </button>
                        </form>
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
