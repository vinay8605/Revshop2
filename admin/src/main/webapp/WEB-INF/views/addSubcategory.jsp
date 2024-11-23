<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.example.entity.Category" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Subcategory</title>
    
    
    <style>
    /* Reset basic styling */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Arial', sans-serif;
}

/* Body and Background */
body {
    background-color: #f7fafc;
    padding: 20px;
}

/* Container for the form */
.form-container {
    background-color: white;
    max-width: 600px;
    margin: 0 auto;
    padding: 30px;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

/* Title styling */
h1 {
    font-size: 2rem;
    color: #2d3748;
    text-align: center;
    margin-bottom: 30px;
}

/* Form Group */
.form-group {
    margin-bottom: 20px;
}

/* Label styling */
label {
    font-size: 1rem;
    font-weight: 600;
    color: #4a5568;
    display: block;
    margin-bottom: 8px;
}

/* Select dropdown */
select,
input[type="text"] {
    width: 100%;
    padding: 10px;
    font-size: 1rem;
    border: 1px solid #e2e8f0;
    border-radius: 8px;
    background-color: #f9fafb;
    color: #4a5568;
    transition: border-color 0.3s ease, background-color 0.3s ease;
}

select:focus,
input[type="text"]:focus {
    border-color: #3182ce;
    background-color: #e2e8f0;
    outline: none;
}

/* Button Group */
.button-group {
    display: flex;
    justify-content: center;
}

/* Submit Button */
input[type="submit"] {
    background-color: #3182ce;
    color: white;
    border: none;
    padding: 12px 25px;
    font-size: 1rem;
    font-weight: 600;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #2b6cb0;
}

/* Back Link */
.back-link {
    display: block;
    margin-top: 20px;
    text-align: center;
    font-size: 1rem;
    color: #3182ce;
    text-decoration: none;
    font-weight: 600;
}

.back-link:hover {
    text-decoration: underline;
}

/* Responsive design for smaller screens */
@media (max-width: 768px) {
    .form-container {
        padding: 20px;
        margin: 10px;
    }

    h1 {
        font-size: 1.5rem;
    }

    label,
    select,
    input[type="text"],
    input[type="submit"] {
        font-size: 0.9rem;
    }
}
</style>
    
    

</head>

<body>

<div class="form-container">
    <h1>Add New Subcategory</h1>

    <form action="/admin/addSubcategory" method="post">
        <div class="form-group">
            <label for="category">Select Category:</label>
            <select name="categoryId" required>
                <% 
                    List<com.example.entity.Category> categories = (List<com.example.entity.Category>) request.getAttribute("categories");
                    if (categories != null) {
                        for (com.example.entity.Category category : categories) { 
                %>
                    <option value="<%= category.getId() %>"><%= category.getName() %></option>
                <% 
                        } 
                    }
                %>
            </select>
        </div>

        <div class="form-group">
            <label for="subcategory">Subcategory Name:</label>
            <input type="text" name="subcategory" required />
        </div>

        <div class="button-group">
            <input type="submit" value="Add Subcategory" />
        </div>
    </form>

    <a href="/admin" class="back-link">Back to admin dashboard</a>
</div>

</body>
</html>
