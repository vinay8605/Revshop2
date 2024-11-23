package com.CART.repository;

import com.CART.entity.Cart;
import com.demo.entity.Buyer;
import com.example.pro.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface CartRepository extends JpaRepository<Cart, Long> {

	 List<Cart> findByBuyerId(Long buyerId);  // Should return cart items for the specific buyerId    // Custom method to find a specific cart item by buyer and product
    Optional<Cart> findByBuyerAndProduct(Buyer buyer, Product product);
    
    // Method to delete cart item by cartId
    void deleteById(Long cartId);
}
