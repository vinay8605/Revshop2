package com.example.entity;

import jakarta.persistence.*;
import java.util.Set;

@Entity
@Table(name = "category")
public class Category {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "name", nullable = false, unique = true, length = 100)
    private String name;

    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private Set<Subcategory> subcategories;

    // Default constructor
    public Category() {
    }

    // Getters and setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Set<Subcategory> getSubcategories() {
        return subcategories;
    }

    public void setSubcategories(Set<Subcategory> subcategories) {
        this.subcategories = subcategories;
    }
    @Override
    public String toString() {
        return "Category{id=" + id + ", name='" + name + "'}";
    }

}

