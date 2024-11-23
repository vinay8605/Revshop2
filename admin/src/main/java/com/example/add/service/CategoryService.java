package com.example.add.service;
import com.example.entity.Category;
import com.example.entity.Subcategory;
import com.example.repository.CategoryRepository;
import com.example.repository.SubcategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.Optional;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    @Autowired
    private SubcategoryRepository subcategoryRepository;

    // Add a new category
    public Category addCategory(String name) {
        // Check if category with the same name already exists
        Optional<Category> existingCategory = categoryRepository.findByName(name);
        if (existingCategory.isPresent()) {
            throw new IllegalArgumentException("Category with this name already exists.");
        }
        
        Category category = new Category();
        category.setName(name);
        return categoryRepository.save(category);
    }

    // Add a subcategory under an existing category
    public Subcategory addSubcategoryToCategory(int categoryId, String subcategoryName) {
        Category category = categoryRepository.findById(categoryId)
            .orElseThrow(() -> new IllegalArgumentException("Category not found with id: " + categoryId));

        // Check if subcategory with the same name exists within this category
        if (subcategoryRepository.findByNameAndCategory(subcategoryName, category).isPresent()) {
            throw new IllegalArgumentException("Subcategory with this name already exists under the specified category.");
        }
        
        Subcategory subcategory = new Subcategory();
        subcategory.setName(subcategoryName);
        subcategory.setCategory(category);
        
        return subcategoryRepository.save(subcategory);
    }
}
