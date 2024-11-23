package com.example.pro.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "subcategory")  // Specify the table name explicitly
public class SubCategory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")  // Map to the 'subid' column in the database
    private Long id;

    @Column(name = "name")  // Map to the 'name' column in the database
    private String name;

    @ManyToOne
    @JoinColumn(name = "category_id", referencedColumnName = "id")  // Maps to 'category_id' in subcategory
    private Category category;

    public Long getid() {
        return id;
    }

    public void setid(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }
}
