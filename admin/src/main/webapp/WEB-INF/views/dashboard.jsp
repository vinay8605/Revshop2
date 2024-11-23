<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Revshop</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script> <!-- Chart.js library -->
    <style>
        /* Your existing styles */
          .welcome-message {
        font-size: 2em;
        font-weight: bold;
        color: #1e293b;
        text-align: center;
        padding: 20px;
        border-radius: 8px;
        background-color: #f0f4f8;
        border: 2px solid #d1d5db;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        animation: slideIn 2s ease-out;
    }

    @keyframes slideIn {
        0% {
            transform: translateX(-100%);
            opacity: 0;
        }
        100% {
            transform: translateX(0);
            opacity: 1;
        }
    }
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Arial', sans-serif;
        }

        body {
            background: #f0f2f5;
        }

        .dashboard {
            padding: 20px;
            max-width: 1400px;
            margin: 0 auto;
            margin-left: 250px; /* Added to accommodate sidebar */
            transition: margin-left 0.3s ease; /* Smooth transition for margin */
        }

        /* Your other existing styles remain unchanged */
        .stats-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07);
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-3px);
        }

        .stat-card h3 {
            color: #64748b;
            font-size: 0.9em;
            margin-bottom: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-card .value {
            font-size: 2em;
            font-weight: bold;
            color: #1e293b;
            margin-bottom: 10px;
        }

        .stat-icon {
            margin-top: 10px;
            font-size: 1.5em;
            color: #64748b;
        }

        .charts-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(500px, 1fr));
            gap: 20px;
        }

        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.07);
        }

        .chart-card h3 {
            color: #1e293b;
            margin-bottom: 20px;
            font-size: 1.1em;
            font-weight: 600;
        }

        canvas {
            width: 100% !important;
            height: 300px !important;
        }

        /* Custom colors for stat cards */
        .stat-card:nth-child(1) { border-left: 4px solid #3b82f6; }
        .stat-card:nth-child(2) { border-left: 4px solid #10b981; }
        .stat-card:nth-child(3) { border-left: 4px solid #8b5cf6; }
        .stat-card:nth-child(4) { border-left: 4px solid #f59e0b; }

        /* New Sidebar Styles */
        .sidebar {
            width: 250px;
            height: 100vh;
            background: white;
            position: fixed;
            left: 0;
            top: 0;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            transition: transform 0.3s ease;
            z-index: 1000;
        }

        .sidebar-header {
            padding: 20px;
            border-bottom: 1px solid #e5e7eb;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #1e293b;
        }

        .menu-list {
            padding: 20px 0;
            list-style: none;
        }

        .menu-item {
            padding: 12px 20px;
            display: flex;
            align-items: center;
            color: #64748b;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .menu-item:hover {
            background: #f8fafc;
            color: #3b82f6;
        }

        .menu-item.active {
            background: #eff6ff;
            color: #3b82f6;
            border-left: 4px solid #3b82f6;
        }

        .menu-icon {
            margin-right: 12px;
            font-size: 1.2rem;
        }

        .menu-text {
            font-size: 0.95rem;
        }

        .toggle-btn {
            display: none;
            position: fixed;
            left: 20px;
            top: 20px;
            z-index: 1001;
            background: white;
            border: none;
            padding: 8px;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            cursor: pointer;
        }

        /* Mobile Responsiveness */
        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
            }

            .sidebar.active {
                transform: translateX(0);
            }

            .toggle-btn {
                display: block;
            }

            .dashboard {
                margin-left: 0;
            }

            .charts-container {
                grid-template-columns: 1fr;
            }
            
            .stat-card {
                padding: 20px;
            }
            
            .stat-card .value {
                font-size: 1.6em;
            }
            
        }
    </style>
</head>
<body>
    <!-- New Sidebar Toggle Button -->
    <button class="toggle-btn">☰</button>

    <!-- New Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="logo">Revshop_2</div>
        </div>
        
        <ul class="menu-list">
            <a href="/admin/stats" class="menu-item active">
                <span class="menu-icon">📊</span>
                <span class="menu-text">Stats</span>
            </a>
            
            <a href="javascript:void(0);" class="menu-item" id="dashboard-link">
    		<span class="menu-icon">🛍️</span>
    		<span class="menu-text">Dashboard</span>
		</a>

            
            <a href="javascript:void(0);" class="menu-item"id="addCategory-Link">
                <span class="menu-icon">📦</span>
                <span class="menu-text">Add-Category</span>
            </a>
            
            <a href="javascript:void(0);" class="menu-item"id="addSubCategory-Link">
                <span class="menu-icon">👥</span>
                <span class="menu-text">Add-SubCategory</span>
            </a>
            
            <a href="javascript:void(0)" class="menu-item"id = "Orders-Link">
                <span class="menu-icon">⚙️</span>
                <span class="menu-text">Orders</span>
            </a>
        </ul>
    </div>

    <!-- Your existing dashboard content -->
    <div class="dashboard">
        <!-- Statistics Section -->
        <div class="stats-container">
            <div class="stat-card">
                <h3>Total Sellers</h3>
                <div class="value"><%= request.getAttribute("dashboardStats") != null ? ((com.example.entity.DashboardStats) request.getAttribute("dashboardStats")).getTotalSellers() : 0 %></div>
                <div class="stat-icon">🛒</div>
            </div>
            <div class="stat-card">
                <h3>Total Buyers</h3>
                <div class="value"><%= request.getAttribute("dashboardStats") != null ? ((com.example.entity.DashboardStats) request.getAttribute("dashboardStats")).getTotalBuyers() : 0 %></div>
                <div class="stat-icon">👥</div>
            </div>
            <div class="stat-card">
                <h3>Total Orders</h3>
                <div class="value"><%= request.getAttribute("dashboardStats") != null ? ((com.example.entity.DashboardStats) request.getAttribute("dashboardStats")).getTotalOrders() : 0 %></div>
                <div class="stat-icon">📦</div>
            </div>
            <div class="stat-card">
                <h3>Total Sales</h3>
                <div class="value">$<%= request.getAttribute("dashboardStats") != null ? ((com.example.entity.DashboardStats) request.getAttribute("dashboardStats")).getTotalSales() : 0 %></div>
                <div class="stat-icon">💰</div>
            </div>
        </div>
        

      <!--  <!--  <!-- Charts Section -->
      <div class="chart-card">
    <h3 class="welcome-message">Welcome, Admin!</h3>
</div>
        
   
    <script>
 // Handle the "Dashboard" button click event
    document.getElementById('dashboard-link').addEventListener('click', function() {
        // Fetch the content dynamically from the server
        fetch('/admin') // Replace with your actual URL endpoint
            .then(response => response.text())
            .then(data => {
                // Inject the content into the dynamic content area
                document.querySelector('.dashboard').innerHTML = data;
            })
            .catch(error => console.error('Error loading dashboard content:', error));
        
        // Optionally, highlight the active menu item
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => item.classList.remove('active'));
        this.classList.add('active');
    });
    
/////////////////////////////////////////////////////

 // Handle the "Dashboard" button click event
    document.getElementById('addCategory-Link').addEventListener('click', function() {
        // Fetch the content dynamically from the server
        fetch('/admin/addCategory') // Replace with your actual URL endpoint
            .then(response => response.text())
            .then(data => {
                // Inject the content into the dynamic content area
                document.querySelector('.dashboard').innerHTML = data;
            })
            .catch(error => console.error('Error loading dashboard content:', error));
        
        // Optionally, highlight the active menu item
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => item.classList.remove('active'));
        this.classList.add('active');
    });
    //////////////////////////////////////////////////////////
     // Handle the "Dashboard" button click event
    document.getElementById('addSubCategory-Link').addEventListener('click', function() {
        // Fetch the content dynamically from the server
        fetch('/admin/addSubcategory') // Replace with your actual URL endpoint
            .then(response => response.text())
            .then(data => {
                // Inject the content into the dynamic content area
                document.querySelector('.dashboard').innerHTML = data;
            })
            .catch(error => console.error('Error loading dashboard content:', error));
        
        // Optionally, highlight the active menu item
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => item.classList.remove('active'));
        this.classList.add('active');
    });
    //////////////////////////////////////////////////////////
     document.getElementById('Orders-Link').addEventListener('click', function() {
        // Fetch the content dynamically from the server
        fetch('/admin/orders') // Replace with your actual URL endpoint
            .then(response => response.text())
            .then(data => {
                // Inject the content into the dynamic content area
                document.querySelector('.dashboard').innerHTML = data;
            })
            .catch(error => console.error('Error loading dashboard content:', error));
        
        // Optionally, highlight the active menu item
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => item.classList.remove('active'));
        this.classList.add('active');
    });

    
        // Your existing chart JavaScript
        function updateDashboardCharts(data) {
            // Monthly Orders Chart
            new Chart(document.getElementById('ordersChart'), {
                type: 'line',
                data: {
                    labels: data.monthlyOrders.map(item => item.month),
                    datasets: [{
                        label: 'Orders',
                        data: data.monthlyOrders.map(item => item.count),
                        borderColor: '#3b82f6',
                        backgroundColor: '#93c5fd20',
                        tension: 0.3,
                        fill: true
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        }
                    }
                }
            });

            // Monthly Sales Chart
            new Chart(document.getElementById('salesChart'), {
                type: 'bar',
                data: {
                    labels: data.monthlySales.map(item => item.month),
                    datasets: [{
                        label: 'Sales',
                        data: data.monthlySales.map(item => item.amount),
                        backgroundColor: '#10b981'
                    }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        legend: {
                            position: 'top',
                        }
                    }
                }
            });
        }

        // Get data from the JSP model attribute and update the charts
        const dashboardData = <%= request.getAttribute("dashboardStats") != null ? new com.fasterxml.jackson.databind.ObjectMapper().writeValueAsString(request.getAttribute("dashboardStats")) : "{}" %>;
        updateDashboardCharts(JSON.parse(dashboardData));

        // New JavaScript for sidebar toggle
        const toggleBtn = document.querySelector('.toggle-btn');
        const sidebar = document.querySelector('.sidebar');
        
        toggleBtn.addEventListener('click', () => {
            sidebar.classList.toggle('active');
        });

        // Handle menu item clicks
        const menuItems = document.querySelectorAll('.menu-item');
        menuItems.forEach(item => {
            item.addEventListener('click', () => {
                // Remove active class from all items
                menuItems.forEach(i => i.classList.remove('active'));
                // Add active class to clicked item
                item.classList.add('active');
                
                // On mobile, close sidebar after click
                if (window.innerWidth <= 768) {
                    sidebar.classList.remove('active');
                }
            });
        });
    </script>
</body>
</html>