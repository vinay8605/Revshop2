package com.example.pro.repository;

import com.example.pro.entity.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Integer> {

    // Find products by category name (if category is a Category entity)
    List<Product> findByCategory_Name(String categoryName);

    // Find products by subcategory
    List<Product> findBySubCategory_Name(String subcategoryName);

    // Find products by category and subcategory
    List<Product> findByCategory_NameAndSubCategory_Name(String categoryName, String subcategoryName);

	List<Product> findByNameContainingIgnoreCaseOrDescriptionContainingIgnoreCase(String search, String search2);
}
