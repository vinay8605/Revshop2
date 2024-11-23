<%@ page import="java.util.List" %>
<%@ page import="com.example.entity.Buyer" %>
<%@ page import="com.example.entity.Seller" %>
<%@ page import="com.example.entity.Product" %>
<%@ page import="com.example.entity.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
/* Reset and base styles */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

:root {
    --primary-color: #2563eb;
    --primary-hover: #1d4ed8;
    --success-color: #059669;
    --danger-color: #dc2626;
    --text-primary: #1e293b;
    --text-secondary: #475569;
    --border-color: #e2e8f0;
    --background-primary: #f8fafc;
    --background-secondary: #ffffff;
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background-color: var(--background-primary);
    color: var(--text-primary);
    line-height: 1.5;
    padding: 1.5rem;
    min-height: 100vh;
}

/* Typography */
h1 {
    font-size: 1.875rem;
    font-weight: 600;
    text-align: center;
    margin: 2rem 0;
    color: var(--text-primary);
    letter-spacing: -0.025em;
}

h2 {
    font-size: 1.25rem;
    font-weight: 600;
    color: var(--text-primary);
    margin: 2.5rem 0 1.5rem;
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

h2::before {
    content: '';
    width: 4px;
    height: 1.25rem;
    background: var(--primary-color);
    border-radius: 2px;
}

/* Container */
.dashboard-container {
    max-width: 1440px;
    margin: 0 auto;
}

/* Table Container */
.table-container {
    background: var(--background-secondary);
    border-radius: 8px;
    box-shadow: var(--shadow-sm);
    overflow: hidden;
    margin-bottom: 2rem;
}

/* Table Styles */
table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    font-size: 0.875rem;
}

/* Table Header */
thead {
    background-color: var(--background-primary);
    border-bottom: 2px solid var(--border-color);
}

th {
    padding: 1rem 1.5rem;
    text-align: left;
    font-weight: 600;
    color: var(--text-secondary);
    text-transform: uppercase;
    font-size: 0.75rem;
    letter-spacing: 0.05em;
    white-space: nowrap;
}

/* Table Body */
td {
    padding: 1rem 1.5rem;
    color: var(--text-primary);
    border-bottom: 1px solid var(--border-color);
    vertical-align: middle;
}

tbody tr:last-child td {
    border-bottom: none;
}

tbody tr:hover {
    background-color: rgba(37, 99, 235, 0.02);
    transition: background-color 0.2s ease;
}

/* Status Cells */
td[data-status] {
    display: flex;
    align-items: center;
    gap: 0.5rem;
}

td[data-status]::before {
    content: '';
    width: 0.5rem;
    height: 0.5rem;
    border-radius: 50%;
}

td[data-status="active"]::before {
    background-color: var(--success-color);
}

td[data-status="inactive"]::before {
    background-color: var(--danger-color);
}

/* Button Styles */
button {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    padding: 0.5rem 1rem;
    font-size: 0.875rem;
    font-weight: 500;
    border-radius: 6px;
    border: 1px solid transparent;
    cursor: pointer;
    transition: all 0.15s ease;
    gap: 0.5rem;
    min-width: 100px;
}

button:focus {
    outline: 2px solid var(--primary-color);
    outline-offset: 2px;
}

/* Action Buttons */
.active {
    background-color: var(--success-color);
    color: white;
}

.active:hover {
    background-color: #047857;
}

.deactivated {
    background-color: var(--danger-color);
    color: white;
}

.deactivated:hover {
    background-color: #b91c1c;
}

.view-button {
    background-color: var(--primary-color);
    color: white;
}

.view-button:hover {
    background-color: var(--primary-hover);
}

/* Form Styles */
form {
    display: inline-flex;
    margin: 0 0.25rem;
}

/* Empty State */
.empty-state {
    padding: 3rem;
    text-align: center;
    color: var(--text-secondary);
}

/* Responsive Design */
@media (max-width: 1280px) {
    .table-container {
        margin: 0 -1rem;
        border-radius: 0;
    }
}

@media (max-width: 1024px) {
    table {
        display: block;
        overflow-x: auto;
        -webkit-overflow-scrolling: touch;
    }
    
    th, td {
        padding: 1rem;
    }
}

@media (max-width: 640px) {
    body {
        padding: 1rem;
    }
    
    h1 {
        font-size: 1.5rem;
    }
    
    h2 {
        font-size: 1.125rem;
    }
    
    th, td {
        padding: 0.75rem;
    }
    
    button {
        padding: 0.375rem 0.75rem;
        min-width: 80px;
    }
}

/* Loading States */
.loading {
    opacity: 0.7;
    pointer-events: none;
}

/* Custom Scrollbar */
::-webkit-scrollbar {
    width: 6px;
    height: 6px;
}

::-webkit-scrollbar-track {
    background: var(--background-primary);
}

::-webkit-scrollbar-thumb {
    background: #cbd5e1;
    border-radius: 3px;
}

::-webkit-scrollbar-thumb:hover {
    background: #94a3b8;
}

/* Print Styles */
@media print {
    body {
        background: white;
        padding: 0;
    }
    
    .table-container {
        box-shadow: none;
    }
    
    button {
        display: none;
    }
}

/* Utilities */
.visually-hidden {
    position: absolute;
    width: 1px;
    height: 1px;
    padding: 0;
    margin: -1px;
    overflow: hidden;
    clip: rect(0, 0, 0, 0);
    border: 0;
}

/* Focus Styles */
:focus-visible {
    outline: 2px solid var(--primary-color);
    outline-offset: 2px;
}
    </style>
    <script>
        // Function to confirm before removing a product
        function confirmRemoval() {
            return confirm("Are you sure you want to remove this product?");
        }
    </script>
</head>
<body>
    <h1>Admin Dashboard</h1>

    <!-- Buyers Table -->
    <div id="1">
    <h2>Buyers</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>phone_number</th>
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
    </div>

    <!-- Sellers Table -->
    <div id="2">
    <h2>Sellers</h2>
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
    </div>

    <!-- Products Table -->
<div id="3">
    <h2>Products</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Category</th>
                <th>Subcategory</th>
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
                    <td><%= product.getCategory() != null ? product.getCategory().getName() : "N/A" %></td>
                    <td><%= product.getSubcategory() != null ? product.getSubcategory().getName() : "N/A" %></td>
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
</div>


    <!-- Categories Table -->
    <div id="4">
    <h2>Categories</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
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
    </div>

</body>
</html>
