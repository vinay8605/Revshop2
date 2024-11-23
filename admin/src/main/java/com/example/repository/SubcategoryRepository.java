package com.example.repository;


import com.example.entity.Category;
import com.example.entity.Subcategory;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

public interface SubcategoryRepository extends JpaRepository<Subcategory, Integer> {

	Optional<Category> findByNameAndCategory(String subcategoryName, Category category);
}
