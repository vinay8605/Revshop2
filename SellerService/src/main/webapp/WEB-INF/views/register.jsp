<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Seller Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
            color: #333;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }
        input, textarea, button {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        button {
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Seller Registration</h2>
    <form action="/api/sellers/register" method="post" enctype="multipart/form-data">
        
        <label for="name">Name</label>
        <input type="text" id="name" name="name" placeholder="Enter your name" required>
        
        <label for="mobileNumber">Mobile Number</label>
        <input type="text" id="mobileNumber" name="mobileNumber" placeholder="Enter your mobile number" required>
        
        <label for="email">Email</label>
        <input type="email" id="email" name="email" placeholder="Enter your email" required>
        
        <label for="password">Password</label>
        <input type="password" id="password" name="password" placeholder="Create a password" required>
        
        <label for="businessDetails">Business Details</label>
        <textarea id="businessDetails" name="businessDetails" rows="4" placeholder="Describe your business here"></textarea>
        
        <label for="address">Address</label>
        <input type="text" id="address" name="address" placeholder="Enter your address">
        
        <label for="city">City</label>
        <input type="text" id="city" name="city" placeholder="Enter your city">
        
        <label for="state">State</label>
        <input type="text" id="state" name="state" placeholder="Enter your state">
        
        <label for="pincode">Pincode</label>
        <input type="text" id="pincode" name="pincode" placeholder="Enter your pincode">
        
        <label for="image">Profile Image</label>
        <input type="file" id="image" name="imageFile">
        
        <button type="submit">Register</button>
    </form>
</body>
</html>
