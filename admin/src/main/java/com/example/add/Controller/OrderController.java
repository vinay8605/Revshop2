package com.example.add.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.example.add.service.OrderService;
import com.example.entity.MonthData;
import com.example.entity.Orders;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/admin/orders")
public class OrderController {

    @Autowired
    private OrderService orderService;

    // Get all orders and show in the JSP page
    @GetMapping
    public String getAllOrders(Model model) {
        List<Orders> orders = orderService.getAllOrders();
        model.addAttribute("orders", orders);  // Add orders to model for displaying in JSP
        return "orders";  // Return the view name for the JSP page
    }

    // Get filtered orders based on query parameters and show in the JSP page
    @GetMapping("/filter")
    public String getFilteredOrders(@RequestParam(required = false) 
                                    @DateTimeFormat(pattern = "yyyy-MM-dd") Date date,  // Format the date as yyyy-MM-dd
                                    @RequestParam(required = false) String productName,
                                    @RequestParam(required = false) String buyerName,
                                    Model model) {
        
        // Debugging: Print parameters to verify they are being passed correctly
		/*
		 * System.out.println("Date: " + date); System.out.println("Product Name: " +
		 * productName); System.out.println("Buyer Name: " + buyerName);
		 */

        // If date is null, it means no date filter was applied
        List<Orders> orders = orderService.getFilteredOrders(date, productName, buyerName);
        model.addAttribute("orders", orders);  // Add filtered orders to model
        System.out.println(orders);
        return "orders";  // Return the view name for the JSP page
    }


    // Update order status
    @PostMapping("/{orderId}/status")
    public String updateOrderStatus(@PathVariable Long orderId, 
                                    @RequestParam String status, 
                                    Model model) {
        // Update order status in the service layer
        orderService.updateOrderStatus(orderId, status);

        // Redirect to the orders page after status update
        return "redirect:/admin/orders";  // Correct redirect path to orders page
    }
    
}
