package com.example.pro.controller;

import com.example.pro.entity.*;
import com.example.pro.service.ProductService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public String getAllProducts(@RequestParam(required = false) String category, 
                                  @RequestParam(required = false) String subcategory,
                                  @RequestParam(required = false) String search, 
                                  Model model) {

        List<Product> products = productService.getProducts(category, subcategory, search);
        model.addAttribute("products", products);  // Pass products to model
        model.addAttribute("categories", productService.getCategories());  // Pass categories to model
        model.addAttribute("subcategories", productService.getSubCategories());  // Pass subcategories to model

        return "products";  // Return the view name
    }

    // View product details
    @GetMapping("/product/{id}")
    public String getProductDetails(@PathVariable("id") int productId, Model model) {
        Product product = productService.getProductDetails(productId);
        model.addAttribute("product", product);
        return "details";
    }

    // Add to cart functionality (dummy for now)
    @PostMapping("/product/{id}/add-to-cart")
    public String addToCart(@PathVariable("id") int productId, Model model) {
        productService.addToCart(productId);
        return "redirect:http://localhost:8099/cart";  // Redirect to cart page after adding product
    }

    // Add to wishlist functionality (dummy for now)
    @PostMapping("/product/{id}/add-to-wishlist")
    public String addToWishlist(@PathVariable("id") int productId, Model model) {
        productService.addToWishlist(productId);
        return "redirect:/wishlist";  // Redirect to wishlist page after adding product
    }
}
