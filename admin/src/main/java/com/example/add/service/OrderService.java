package com.example.add.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.example.entity.MonthData;
import com.example.entity.Orders;
import com.example.repository.OrderRepository;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class OrderService {
    private static final Logger logger = LoggerFactory.getLogger(OrderService.class);
    
    @Autowired
    private OrderRepository orderRepository;
    
    @Autowired
    private EmailService emailService;

    // Get all orders ordered by ID in ascending order
    public List<Orders> getFilteredOrders(Date date, String productName, String buyerName) {
        logger.info("Filtering orders with date: {}, productName: {}, buyerName: {}", date, productName, buyerName);
        
        // Create a dynamic query based on the provided filters
        if (date != null && productName != null && buyerName != null) {
            return orderRepository.findByCreatedAtAndProductNameContainingAndBuyerNameContaining(date, productName, buyerName);
        } else if (date != null && productName != null) {
            return orderRepository.findByCreatedAtAndProductNameContaining(date, productName);
        } else if (date != null && buyerName != null) {
            return orderRepository.findByCreatedAtAndBuyerNameContaining(date, buyerName);
        } else if (productName != null && buyerName != null) {
            return orderRepository.findByProductNameContainingAndBuyerNameContaining(productName, buyerName);
        } else if (date != null) {
            return orderRepository.findByCreatedAt(date);
        } else if (productName != null) {
            return orderRepository.findByProductNameContaining(productName);
        } else if (buyerName != null) {
            return orderRepository.findByBuyerNameContaining(buyerName);
        }
        // If no filters are provided, return all orders
        return orderRepository.findAll();
    }

    // Get a single order by ID
    public Optional<Orders> getOrderById(Long orderId) {
        logger.debug("Fetching order with ID: {}", orderId);
        return orderRepository.findById(orderId);
    }

    // Update order status with email notification
    @Transactional
    public void updateOrderStatus(Long orderId, String status) {
        System.out.println("Entering updateOrderStatus method...");
        logger.info("Updating order status to {} for order ID: {}", status, orderId);

        // Find the order by ID
        Orders order = orderRepository.findById(orderId)
            .orElseThrow(() -> {
                logger.error("Order not found for ID: {}", orderId);
                System.out.println("Order not found for ID: " + orderId); // Debugging output
                return new RuntimeException("Order not found for ID: " + orderId);
            });

        // Debugging: Output order details
        System.out.println("Found order: " + order);
        logger.debug("Order details: {}", order);

        // Validate buyer email
        if (order.getBuyer() == null || order.getBuyer().getEmail() == null) {
            logger.error("Buyer or buyer email is null for order ID: {}", orderId);
            System.out.println("Buyer or email is missing for order ID: " + orderId); // Debugging output
            throw new RuntimeException("Buyer information is missing");
        }

        // Debugging: Output buyer email
        System.out.println("Buyer email: " + order.getBuyer().getEmail());
        logger.debug("Buyer email: {}", order.getBuyer().getEmail());

        // Update the status
        order.setStatus(status);
        orderRepository.save(order);

        // Log the status update success
        logger.info("Order status updated successfully to {}", status);
        System.out.println("Order status updated successfully to: " + status); // Debugging output

        // Send email notification for specific statuses
        if (status.equals("Shipped") || status.equals("Delivered") || status.equals("Canceled")) {
            try {
                String buyerEmail = order.getBuyer().getEmail();
                logger.debug("Attempting to send email to: {} for order: {}", buyerEmail, orderId);
                System.out.println("Attempting to send email to: " + buyerEmail + " for order: " + orderId); // Debugging output

                emailService.sendOrderStatusEmail(
                    buyerEmail,
                    String.valueOf(orderId),
                    status
                );

                logger.info("Status update email sent successfully to {}", buyerEmail);
                System.out.println("Status update email sent successfully to: " + buyerEmail); // Debugging output

            } catch (Exception e) {
                logger.error("Failed to send status update email: {}", e.getMessage(), e);
                System.out.println("Failed to send status update email: " + e.getMessage()); // Debugging output
                // You might want to implement a retry mechanism here
            }
        }
    }

    // Method to get all orders
    public List<Orders> getAllOrders() {
        logger.debug("Fetching all orders sorted by ID");
        return orderRepository.findAllByOrderByIdAsc();
    }
}