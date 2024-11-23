package com.example.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.example.entity.MonthData;
import com.example.entity.Orders;

import jakarta.transaction.Transactional;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface OrderRepository extends JpaRepository<Orders, Long> {
    
    // Fetch all orders ordered by ID in ascending order
    List<Orders> findAllByOrderByIdAsc();

    // Fetch orders by buyer name (exact match)
    List<Orders> findByBuyerName(String buyerName);

    // Fetch orders by product name (exact match)
    List<Orders> findByProductName(String productName);

    // Fetch orders by created date (exact match)
    List<Orders> findByCreatedAt(Date createdAt);

    // Custom query to filter orders by date, product name, and buyer name (partial match for product and buyer names)
    List<Orders> findByCreatedAtAndProductNameContainingAndBuyerNameContaining(
            Date createdAt, String productName, String buyerName);
    
    // Fetch orders by created date and product name (partial match for product name)
    List<Orders> findByCreatedAtAndProductNameContaining(Date createdAt, String productName);

    // Fetch orders by created date and buyer name (partial match for buyer name)
    List<Orders> findByCreatedAtAndBuyerNameContaining(Date createdAt, String buyerName);

    // Fetch orders by product name and buyer name (partial match for both)
    List<Orders> findByProductNameContainingAndBuyerNameContaining(String productName, String buyerName);

    // Fetch orders by product name (partial match)
    List<Orders> findByProductNameContaining(String productName);

    // Fetch orders by buyer name (partial match)
    List<Orders> findByBuyerNameContaining(String buyerName);

    // Fetch a single order by ID
    Optional<Orders> findById(Long orderId);

    // Additional method for counting all orders
    long count();
    
    // Example custom query: Calculate the total amount of all orders (adjust as per actual field)
    @Query("SELECT ROUND(SUM(o.amount),2)FROM Orders o")
    double sumOrderAmounts();
    
 // New method to get monthly order statistics (count of orders per month)
}


