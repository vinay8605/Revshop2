package com.example.add.Controller;
import java.util.*;
import com.example.entity.Category;
import com.example.entity.Subcategory;
import com.example.add.service.EmailService;
import com.example.add.service.ProductService;
import com.example.repository.BuyerRepository;
import com.example.repository.CategoryRepository;
import com.example.repository.ProductRepository;
import com.example.repository.SellerRepository;
import com.example.repository.SubcategoryRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private BuyerRepository buyerRepository;

    @Autowired
    private SellerRepository sellerRepository;

    @Autowired
    private ProductRepository productRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SubcategoryRepository subcategoryRepository;

    @Autowired
    private ProductService productService;
    @Autowired
    private EmailService emailservice;

    // Admin Dashboard
    @GetMapping
    public String adminDashboard(Model model) {
        model.addAttribute("buyers", buyerRepository.findAllByOrderByIdAsc());
        model.addAttribute("sellers", sellerRepository.findAllByOrderByIdAsc());
        model.addAttribute("products", productRepository.findAll());
        model.addAttribute("categories", categoryRepository.findAll());
        return "adminDashboard";
    }

    // Update buyer status (Activate/Deactivate)
    @PostMapping("/updateBuyerStatus")
    public String updateBuyerStatus(@RequestParam Long id, @RequestParam boolean approval_status) {
        buyerRepository.findById(id).ifPresent(buyer -> {
            buyer.setApproval_status(approval_status);
            buyerRepository.save(buyer);
        });
        return "redirect:/admin/stats";
    }

    // Update seller status (Activate/Deactivate)
    @PostMapping("/updateSellerStatus")
    public String updateSellerStatus(@RequestParam int id, @RequestParam boolean accountStatus) {
        sellerRepository.findById(id).ifPresent(seller -> {
            seller.setAccountStatus(accountStatus);
            sellerRepository.save(seller);
            if (accountStatus) {
                emailservice.sendAccountActivationEmail(seller.getEmail(), seller.getName());
            }
        });
        return "redirect:/admin/stats";
    }

    // Remove product by ID
    @PostMapping("/removeProduct")
    public String removeProduct(@RequestParam int productId) {
        productRepository.deleteById(productId);
        return "redirect:/admin/stats";
    }

    // View Product by Id
    @GetMapping("/viewProduct/{id}")
    public String viewProduct(@PathVariable("id") int id, Model model) {
        return productService.getProductById(id)
                .map(product -> {
                    model.addAttribute("product", product);
                    return "viewProduct";
                })
                .orElse("errorPage");
    }
    
    
    @GetMapping("/addCategory")
    public String showAddCategoryForm() {
    	return "addCategory";
    }

    // Add a new category
    @PostMapping("/addCategory")
    public String addCategory(@RequestParam("category") String categoryName) {
        Category category = new Category();
        category.setName(categoryName);
        categoryRepository.save(category);
        return "redirect:/admin/stats";
    }

    // Remove category by ID
    @PostMapping("/removeCategory")
    public String removeCategory(@RequestParam("categoryId") int categoryId) {
        categoryRepository.deleteById(categoryId);
        return "redirect:/admin/stats";
    }

    @GetMapping("/addSubcategory")
    public String showAddSubcategoryForm(Model model) {
        List<Category> categories = categoryRepository.findAll(); // Fetch all categories
        System.out.println("Categories fetched: " + categories); // Debug log
        model.addAttribute("categories", categories); // Pass the categories list to the view
        return "addSubcategory"; // Name of the JSP view for adding a subcategory
    }

    @PostMapping("/addSubcategory")
    public String addSubcategory(@RequestParam("categoryId") int categoryId, @RequestParam("subcategory") String subcategoryName) {
        categoryRepository.findById(categoryId).ifPresentOrElse(category -> {
            System.out.println("Category found: " + category.getName()); // Ensure the category is found
            Subcategory subcategory = new Subcategory();
            subcategory.setName(subcategoryName);
            subcategory.setCategory(category); // Set the category for the subcategory
            subcategoryRepository.save(subcategory); // Save the new subcategory
        }, () -> {
            System.out.println("Category not found with ID: " + categoryId); // Debug log for missing category
        });
        return "redirect:/admin/stats"; // Redirect to the admin dashboard after adding the subcategory
    }

 // Show all categories and allow viewing subcategories and removing categories
    @GetMapping("/categories")
    public String showCategories(Model model) {
        List<Category> categories = categoryRepository.findAll(); // Fetch all categories
        model.addAttribute("categories", categories); // Pass the categories list to the view
        return "manageCategories"; // JSP page for managing categories
    }

    // Show subcategories for a specific category
    @GetMapping("/viewCategory/{categoryId}")
    public String viewSubcategoriesForCategory(@PathVariable Integer categoryId, Model model) {
        Category category = categoryRepository.findById(categoryId).orElse(null);
        if (category != null) {
            model.addAttribute("category", category);
            // Convert the Set to a List
            List<Subcategory> subcategoriesList = new ArrayList<>(category.getSubcategories());
            model.addAttribute("subcategories", subcategoriesList);
        }
        return "viewSubcategories"; // The name of the JSP view
    }



    // Handle the subcategory removal
    @PostMapping("/removeSubcategory")
    public String removeSubcategory(@RequestParam("subcategoryId") int subcategoryId) {
        subcategoryRepository.deleteById(subcategoryId); // Delete the subcategory by ID
        return "redirect:/admin/stats"; // Redirect to the admin dashboard after removal
    }

}
