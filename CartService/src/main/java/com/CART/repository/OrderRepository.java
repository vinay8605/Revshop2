package com.CART.repository;

import com.CART.entity.Order;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends JpaRepository<Order, Long> {

    // Custom query to get the latest order placed by the buyer, ordered by order date in descending order
    Order findTopByBuyerIdOrderByCreatedAtDesc(Long buyerId);
    List<Order> findByBuyerId(Long buyerId);  // Query to fetch orders by buyerId
}
