package com.CART.service;

import com.CART.entity.Cart;
import com.CART.entity.CartRequest;
import com.CART.entity.CartUpdateRequest;
import com.CART.entity.Order;
import com.CART.repository.CartRepository;
import com.CART.repository.OrderRepository;
import com.demo.entity.Buyer;
import com.demo.repository.BuyerRepository;
import com.example.pro.entity.Product;
import com.example.pro.repository.ProductRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Service
public class CartService {

    @Autowired
    private CartRepository cartRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private BuyerRepository buyerRepository;
    
    @Autowired
    private OrderRepository orderRepository; 

    /**
     * Adds a product to the cart for a given buyer.
     * If the product already exists in the cart, it updates the quantity.
     * If not, it creates a new cart item.
     * 
     * @param buyerId   The ID of the buyer
     * @param productId The ID of the product to add
     * @param quantity  The quantity to add
     * @throws Exception If the buyer or product is not found or if there's not enough stock
     */
    public void addToCart(Long buyerId, Integer productId, Integer quantity) throws Exception {
        // Get the buyer and product from the respective repositories
        Buyer buyer = buyerRepository.findById(buyerId)
                                     .orElseThrow(() -> new Exception("Buyer not found"));
        Product product = productRepository.findById(productId)
                                          .orElseThrow(() -> new Exception("Product not found"));

        // Check if the product quantity is sufficient
        if (product.getQuantity() < quantity) {
            throw new Exception("Not enough items available in stock");
        }

        // Check if the product is already in the cart for this buyer
        Optional<Cart> existingCartItem = cartRepository.findByBuyerAndProduct(buyer, product);

        if (existingCartItem.isPresent()) {
            // If product already exists in the cart, update quantity
            Cart cartItem = existingCartItem.get();
            cartItem.setQuantity(cartItem.getQuantity() + quantity); // Add the new quantity to existing
            cartRepository.save(cartItem); // Save updated cart item
        } else {
            // If product does not exist in the cart, create a new cart item
            Cart newCartItem = new Cart();
            newCartItem.setBuyer(buyer);
            newCartItem.setProduct(product);
            newCartItem.setQuantity(quantity);
            cartRepository.save(newCartItem); // Save the new cart item
        }
    }

    /**
     * Updates the quantity of an existing cart item.
     * Ensures that the updated quantity doesn't exceed the available stock.
     * 
     * @param cartId      The ID of the cart item to update
     * @param newQuantity The new quantity to set
     * @throws Exception If the cart item is not found or if there isn't enough stock
     */
    public void updateCartItemQuantity(Long cartId, Integer newQuantity) throws Exception {
        Cart cartItem = cartRepository.findById(cartId)
                                      .orElseThrow(() -> new Exception("Cart item not found"));

        Product product = cartItem.getProduct();
        
        // Check if the new quantity is available in stock
        if (product.getQuantity() < newQuantity) {
            throw new Exception("Not enough items available in stock");
        }

        // Update the cart item quantity
        cartItem.setQuantity(newQuantity);
        cartRepository.save(cartItem); // Save the updated cart item
    }

    /**
     * Removes an item from the cart.
     * 
     * @param cartId The ID of the cart item to remove
     * @throws Exception If the cart item is not found
     */
    public void removeFromCart(Long cartId) throws Exception {
        Cart cartItem = cartRepository.findById(cartId)
                                      .orElseThrow(() -> new Exception("Cart item not found"));
        cartRepository.delete(cartItem); // Delete the cart item
    }

    /**
     * Retrieves all items in the cart for a given buyer.
     * 
     * @param buyerId The ID of the buyer
     * @return List of Cart items for the buyer
     * @throws Exception If the buyer is not found
     */
    public List<Cart> getCartItemsForBuyer(Long buyerId) {
        List<Cart> cartItems = cartRepository.findByBuyerId(buyerId);
        System.out.println("Cart items fetched from repository: " + cartItems);
        return cartItems;
    }
    /**
     * Places an order for the items in the cart for a given buyer.
     * This method creates an order based on the items in the cart.
     * 
     * @param buyerId The ID of the buyer placing the order
     * @param paymentMethod 
     * @param phoneNumber 
     * @param pincode 
     * @param state 
     * @param city 
     * @param address 
     * @throws Exception If the cart is empty or if there is an issue with the stock
     */
    public void placeOrder(Long buyerId, String address, String city, String state, String pincode, String phoneNumber, String paymentMethod) throws Exception {
        // Fetch the buyer and their cart items
        Buyer buyer = buyerRepository.findById(buyerId)
                                     .orElseThrow(() -> new Exception("Buyer not found"));
        List<Cart> cartItems = cartRepository.findByBuyerId(buyerId);

        if (cartItems.isEmpty()) {
            throw new Exception("Cart is empty, cannot place order");
        }

        // Process each cart item to create an order
        for (Cart cartItem : cartItems) {
            Product product = cartItem.getProduct();
            int quantity = cartItem.getQuantity();

            // Check if the product has enough stock
            if (product.getQuantity() < quantity) {
                throw new Exception("Not enough stock for product: " + product.getName());
            }

            // Create the order
            double amount = product.getPrice() * quantity; // Calculate order amount
            Order order = new Order(
                LocalDate.now(), // Created date
                quantity,        // Quantity
                "Pending",       // Status
                buyer,           // Buyer
                product,         // Product
                amount           // Amount
            );

            // Save the order
            orderRepository.save(order);

            // Update product stock
            product.setQuantity(product.getQuantity() - quantity);
            productRepository.save(product); // Save updated product stock
        }

        // After placing the order, clear the cart for the buyer
        cartRepository.deleteAll(cartItems);
    }
    public List<Order> getOrdersForBuyer(Long buyerId) {
        // Fetch orders from the repository based on the buyerId
        return orderRepository.findByBuyerId(buyerId);
    }

}
