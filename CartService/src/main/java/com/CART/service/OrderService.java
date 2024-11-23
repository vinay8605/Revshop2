package com.CART.service;

import com.CART.entity.Order;
import com.CART.entity.Cart;
import com.example.pro.entity.*;
import com.CART.repository.OrderRepository;
import com.CART.repository.CartRepository;
import com.example.pro.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class OrderService {

    @Autowired
    private OrderRepository orderRepository;

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    // Fetch the last order placed by the buyer
    public Order getLastOrderByBuyerId(Long buyerId) {
        // Fetch the last order placed by the buyer based on the most recent order date
        return orderRepository.findTopByBuyerIdOrderByCreatedAtDesc(buyerId);
    }

    // Place the order and reduce product quantities
    @Transactional
    public Order placeOrder(Long buyerId, Order order) {
        // Save the order
        orderRepository.save(order);

        // Fetch the cart items for the buyer
        List<Cart> cartItems = cartRepository.findByBuyerId(buyerId);
        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();

            // Check if there is enough stock for the product
            if (product.getQuantity() >= cartItem.getQuantity()) {
                // Reduce the product quantity
                product.setQuantity(product.getQuantity() - cartItem.getQuantity());
                productRepository.save(product);  // Save the updated product quantity
            } else {
                throw new RuntimeException("Not enough stock for product: " + product.getName());
            }
        }

        // Clear the cart for the buyer after placing the order
        clearCart(buyerId);

        return order;
    }

    // Clear the cart after the order is placed
    private void clearCart(Long buyerId) {
        List<Cart> cartItems = cartRepository.findByBuyerId(buyerId);
        cartRepository.deleteAll(cartItems);  // Delete all items from the cart
    }
}
