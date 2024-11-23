# RevShop

## Overview
**RevShop** is a secure, user-friendly, and versatile e-commerce application designed for buyers, sellers, and administrators. It provides a comprehensive platform for users to browse products, manage carts, make purchases, and leave reviews. Sellers can manage product listings, inventory, and orders, while the **Admin service** oversees both buyers and sellers. The application will be demonstrated with a cloud-hosted working version, accompanied by a technical presentation and associated diagrams.

## Core Functionalities

### Buyer Account
As a buyer, the following functionalities are available:
1. **User Registration:** Register on the platform with a unique email and password.
2. **Login:** Authenticate with email and password.
3. **Product Details:** View product information, including images, prices, descriptions, and user reviews.
4. **Product Browsing:** Browse products by category or search using keywords.
5. **Cart Management:** Add or remove products from the cart, adjust quantities.
6. **Checkout:** Enter shipping and billing details to complete the purchase.
7. **Order Notifications:** Receive email notifications upon successful order placement.
8. **Order History:** Review past purchases.
9. **Product Reviews:** Rate and review purchased products.
10. **Favorites:** Save products to a favorites list for future reference.
11. **Payment Processing:** Use a payment gateway to securely complete transactions.

### Seller Account
As a seller, the following functionalities are available:
1. **User Registration:** Register as a seller with business details.
2. **Login:** Authenticate using email and password.
3. **Inventory Management:** Track and manage product inventory.
4. **Product Management:** Add new products, set prices, and provide descriptions.
5. **Order Fulfillment:** View placed orders and fulfill them.
6. **Order Notifications:** Receive email notifications when a user places an order.
7. **Discount Management:** Offer discounted prices alongside regular prices.
8. **Product Review Access:** View reviews left by buyers.
9. **Stock Alerts:** Receive web notifications when product quantities drop below a set threshold.

### Admin Account
As an admin, the following functionalities are available:
1. **Manage Buyers:** View, activate, deactivate, and manage buyer accounts.
2. **Manage Sellers:** View, approve, deactivate, and manage seller accounts.
3. **Monitor Platform Activity:** View platform statistics and manage overall site operations.
4. **Content Moderation:** Review and manage product listings, including content moderation and approval.

## Technology Stack
RevShop utilizes a range of technologies to build a modern, scalable, and maintainable e-commerce platform:

- **Backend:**
  - Java
  - Spring Boot (Spring Web, Spring Core, Spring ORM)
  - Hibernate
  - MySQL
  - JDBC
  - Microservices Architecture
  - **API Gateway** for microservice routing and load balancing
  - Servlets
- **Frontend:**
  - HTML, CSS, JavaScript
  - JSP (JavaServer Pages)
- **Version Control:**
  - Git

## Architecture
RevShop follows a **Microservices Architecture**, with each core functionality being handled by separate microservices. The services communicate through REST APIs and are managed by an **API Gateway** that handles request routing, load balancing, and centralized authentication.

### Key Services
- **User Service:** Handles user registration, authentication, and profile management.
- **Product Service:** Manages product listings, details, and inventory.
- **Cart Service:** Responsible for cart operations and checkout.
- **Order Service:** Handles order management and order history.
- **Payment Service:** Integrates with a payment gateway for processing transactions.
- **Notification Service:** Sends email and web notifications for buyers and sellers.
- **Admin Service:** Manages both buyer and seller accounts, moderates content, and monitors platform activity.

## Project Structure
Here's a general breakdown of the project's structure:

```
RevShop/
├── src/
│   ├── main/
│   │   ├── java/                    # Java source code (Spring Boot, Microservices, Controllers, Services, Models)
│   │   ├── resources/               # Application resources (properties, configurations)
│   │   └── webapp/
│   │       ├── WEB-INF/             # JSP pages and configuration files
│   │       └── static/              # CSS, JS, images
│   └── test/                        # Unit and integration tests
├── db/
│   └── scripts/                     # Database scripts for schema and initial data
├── diagrams/                        # Technical diagrams (UML, ERD, etc.)
├── README.md                        # Project documentation
├── pom.xml                          # Maven build file
└── .gitignore                       # Files and directories to be ignored by Git
```

## Setup and Installation

1. **Clone the repository:**
   
   ```bash
   git clone https://github.com/yourusername/RevShop.git
   ```
   
2. **Navigate to the project directory:**
   
   ```bash
   cd RevShop
   ```
   
3. **Configure the database:**
   
   - Install and set up MySQL.
   - Create a database named `revshop_db`.
   - Run the SQL scripts in the `db/scripts` folder to set up the schema and initial data.
   
4. **Configure application properties:**
   
   - Edit the database connection details in the `application.properties` file for each microservice:
     
     ```properties
     spring.datasource.url=jdbc:mysql://localhost:3306/revshop_db
     spring.datasource.username=root
     spring.datasource.password=yourpassword
     ```

5. **Build and Run Microservices:**
   
   - Use Maven to build each microservice:
   
     ```bash
     mvn clean install
     ```
   
   - Start each microservice using Spring Boot:
   
     ```bash
     mvn spring-boot:run
     ```
   
6. **Configure and Run API Gateway:**
   
   - Build and start the API Gateway service that routes requests to appropriate microservices.

7. **Access the application:**
   
   - Open your web browser and go to `http://localhost:8099` (API Gateway endpoint).

## Usage

### Buyer Workflow
1. Register and log in as a buyer.
2. Browse products and add them to the cart.
3. Proceed to checkout, enter shipping details, and make a payment.
4. Review products and manage order history.

### Seller Workflow
1. Register and log in as a seller.
2. Manage product inventory, add new items, and set pricing.
3. Fulfill orders and track product stock levels.

### Admin Workflow
1. Log in as an admin to manage buyer and seller accounts.
2. Approve or deactivate seller accounts, and manage content.
3. Monitor platform statistics and activity.

## Database Design
The application uses a MySQL database to manage buyer, seller, admin, product, order, and review data. The `db/scripts` folder contains the SQL scripts for database schema creation.


## Acknowledgments
Special thanks to the team at Revature for support and guidance throughout the development of this project.

