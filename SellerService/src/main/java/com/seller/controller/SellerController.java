package com.seller.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import com.seller.entity.Seller;
import com.seller.service.SellerService;

@Controller
@RequestMapping("/api/sellers")
public class SellerController {

    @Autowired
    private SellerService sellerService;

    // Display the registration form for a new seller
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        if (!model.containsAttribute("seller")) {
            model.addAttribute("seller", new Seller());
        }
        return "register"; // This will look for a view named 'seller_register.jsp' or 'seller_register.html'
    }
    @GetMapping("/login")
    public String showLoginForm(Model model) {
        if (!model.containsAttribute("seller")) {
            model.addAttribute("seller", new Seller());
        }
        return "login"; // This will look for a view named 'seller_register.jsp' or 'seller_register.html'
    }

    @PostMapping("/register")
    public String registerSeller(@Valid @ModelAttribute("seller") Seller seller,
                                 BindingResult bindingResult,
                                 @RequestParam(value="imageFile",  required = false) MultipartFile imageFile, // Explicitly bind MultipartFile
                                 Model model) {
        if (bindingResult.hasErrors()) {
            return "register";  // Return to the registration page if validation fails
        }

        try {
            // Handle the image file for seller's profile
            if (imageFile != null && !imageFile.isEmpty()) {
                seller.setImage(imageFile.getBytes());  // Convert the file to byte[] and set the image
            }

            sellerService.registerSeller(seller);  // Save the seller to the database
            return "login";  // Redirect to the login page after successful registration
        } catch (IOException e) {
            model.addAttribute("errorMessage", "Error processing profile image file");
            return "register";  // Return to the registration page in case of an error
        } catch (Exception e) {
            model.addAttribute("errorMessage", "An error occurred during registration: " + e.getMessage());
            return "register";  // Return to the registration page if any other exception occurs
        }
    }



    // Login functionality for sellers
    @PostMapping("/login")
    public String loginSeller(@RequestParam("email") String email,
                              @RequestParam("password") String password,
                              Model model) {
        boolean isAuthenticated = sellerService.authenticateSeller(email, password);
        if (isAuthenticated) {
            model.addAttribute("welcomeMessage", "Login successful. Welcome!");
            return "redirect:http://localhost:8085/seller/dashboard/addProduct"; // Redirect to seller dashboard or products page
        } else {
            model.addAttribute("errorMessage", "Invalid email or password");
            return "login"; // Return to login page if authentication fails
        }
    }
}
