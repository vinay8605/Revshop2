package com.CART.controller;

import com.CART.entity.Cart;
import com.CART.entity.Order;
import com.CART.service.CartService;
import com.demo.entity.Buyer;
import com.demo.service.BuyerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartController {

    @Autowired
    private CartService cartService;
    
    @Autowired
    private BuyerService buyerService; 

    @GetMapping("/view")
    public String viewCart(@CookieValue(value = "buyerId", required = false) String buyerId, Model model) {
        System.out.println("Buyer ID from cookie: " + buyerId);  // Log the buyerId value

        if (buyerId == null || buyerId.isEmpty()) {
            model.addAttribute("errorMessage", "Please log in to view the cart.");
            return "redirect:/login"; // Redirect to login page if buyerId is not found
        }

        try {
            Long buyerLongId = Long.parseLong(buyerId);  // Parse buyerId to Long
            System.out.println("Buyer ID parsed: " + buyerLongId);  // Log the parsed ID
            List<Cart> cartItems = cartService.getCartItemsForBuyer(buyerLongId);
            System.out.println("Retrieved Cart Items: " + cartItems); // Log cart items for debugging
            model.addAttribute("buyerId", buyerId);

            model.addAttribute("cartItems", cartItems);

            // Calculate the total price
            double totalPrice = cartItems.stream()
                                         .mapToDouble(item -> item.getQuantity() * item.getProduct().getPrice())
                                         .sum();
            model.addAttribute("totalPrice", totalPrice);

            return "cart";  // Return to the cart view
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error retrieving cart items: " + e.getMessage());
            return "cart";  // Return to the cart view with error message
        }
    }

    // Add an item to the cart
    @PostMapping("/add")
    public String addToCart(@CookieValue(value = "buyerId") Long buyerId,
                            @RequestParam Integer productId, 
                            @RequestParam Integer quantity, Model model) {
        System.out.println("Buyer ID in addToCart: " + buyerId);
        System.out.println("Buyer ID in proToCart: " + productId);
        System.out.println("Buyer ID in addToCart: " + quantity);// Add this line to check the buyerId
        try {
            cartService.addToCart(buyerId, productId, quantity);
            return "redirect:http://localhost:8099/cart/view"; // Redirect to view cart after adding
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error adding product to cart: " + e.getMessage());
            return "redirect:/cart/view";  // Redirect back to cart view with error message
        }
    }

    // Update the quantity of an item in the cart
    @PostMapping("/update")
    public String updateCartItem(@CookieValue(value = "buyerId") Long buyerId,
                                  @RequestParam Long cartId, 
                                  @RequestParam Integer quantity, Model model) {
        System.out.println("Buyer ID in updateCartItem: " + buyerId);  // Add this line to check the buyerId
        try {
            // Check if the quantity is valid before updating
            if (quantity <= 0) {
                model.addAttribute("errorMessage", "Quantity must be greater than zero.");
                return "redirect:/cart/view";
            }
            cartService.updateCartItemQuantity(cartId, quantity);
            return "redirect:http://localhost:8099/cart/view"; // Redirect to view cart after update
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating cart item: " + e.getMessage());
            return "cart";  // Return the cart.jsp view with error message
        }
    }

    // Remove an item from the cart
    @GetMapping("/remove")
    public String removeFromCart(@CookieValue(value = "buyerId") Long buyerId,
                                 @RequestParam Long cartId, Model model) {
        System.out.println("Buyer ID in removeFromCart: " + buyerId);  // Add this line to check the buyerId
        try {
            cartService.removeFromCart(cartId);
            return "redirect:http://localhost:8099/cart/view"; // Redirect to view cart after removal
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error removing item from cart: " + e.getMessage());
            return "cart";  // Return the cart.jsp view with error message
        }
    }

    @GetMapping("/checkout")
    public String checkout(@CookieValue(value = "buyerId") Long buyerId, Model model) {
        try {
            List<Cart> cartItems = cartService.getCartItemsForBuyer(buyerId);
            double totalPrice = cartItems.stream()
                                          .mapToDouble(item -> item.getQuantity() * item.getProduct().getPrice())
                                          .sum();
            model.addAttribute("cartItems", cartItems);
            model.addAttribute("totalPrice", totalPrice);
            model.addAttribute("buyerId", buyerId);

            // Fetch buyer details (address, city, state, etc.)
            Buyer buyer = buyerService.getBuyerById(buyerId);
            model.addAttribute("buyer", buyer);

            return "Checkout"; // Return to checkout view
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error during checkout: " + e.getMessage());
            return "cart";
        }
    }
    @PostMapping("/updateAddress")
    public String updateAddress(@CookieValue(value = "buyerId", required = false) Long buyerId, 
                                 @RequestParam String address, @RequestParam String city, 
                                 @RequestParam String state, @RequestParam String pincode, 
                                 @RequestParam String phoneNumber, Model model) {
        System.out.println("aaaaaaaa"+buyerId);
    	if (buyerId == null) {
            model.addAttribute("errorMessage", "Buyer ID is missing. Please log in again.");
            return "errorPage";  // Return to an appropriate error page
        }
        
        try {
            // Update the buyer's address details
            buyerService.updateBuyerAddress(buyerId, address, city, state, pincode, phoneNumber);
            return "Checkout";  // Redirect back to the checkout page
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error updating address: " + e.getMessage());
            return "Checkout";  // Return to the change address page with error
        }
    }
    // Proceed to Place Order
    @PostMapping("/placeOrder")
    public String placeOrder(@CookieValue(value = "buyerId") Long buyerId, 
                             @RequestParam String address, @RequestParam String city, 
                             @RequestParam String state, @RequestParam String pincode, 
                             @RequestParam String phoneNumber, @RequestParam String paymentMethod,
                             Model model) {
        try {
            // Place the order and update database
            cartService.placeOrder(buyerId, address, city, state, pincode, phoneNumber, paymentMethod);
            return "Confirmation";  // Redirect to order confirmation page
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error placing order: " + e.getMessage());
            return "Checkout";  // Return to checkout page with error
        }
    }
    
    
    @GetMapping("/orders")
    public String viewOrders(@CookieValue(value = "buyerId", required = false) String buyerId, Model model) {
        System.out.println("Buyer ID from cookie in Orders: " + buyerId);

        if (buyerId == null || buyerId.isEmpty()) {
            model.addAttribute("errorMessage", "Please log in to view your orders.");
            return "redirect:/login";  // Redirect to login page if buyerId is not found
        }

        try {
            Long buyerLongId = Long.parseLong(buyerId);  // Parse buyerId to Long
            System.out.println("Buyer ID parsed: " + buyerLongId);

            // Fetch orders placed by the buyer
            List<Order> orders = cartService.getOrdersForBuyer(buyerLongId);  // Call service to fetch orders
            System.out.println("Retrieved Orders: " + orders);

            if (orders.isEmpty()) {
                model.addAttribute("message", "You have no orders placed yet.");
            } else {
                model.addAttribute("orders", orders);  // Add orders to the model
            }

            return "order";  // Return the orders view
        } catch (NumberFormatException e) {
            model.addAttribute("errorMessage", "Invalid buyer ID format.");
            return "order";  // Return to orders view with error message
        } catch (Exception e) {
            model.addAttribute("errorMessage", "Error retrieving orders: " + e.getMessage());
            return "order";  // Return to orders view with error message
        }
    }


    // For logging out and clearing session
    @GetMapping("/logout")
    public String logout(@CookieValue(value = "buyerId") String buyerId, Model model) {
        System.out.println("Buyer ID in logout: " + buyerId);  // Add this line to check the buyerId
        model.addAttribute("message", "You have been logged out successfully.");
        return "redirect:/login"; // Redirect to login page after logout
    }
}
