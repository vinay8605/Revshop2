package com.example.pro.entity;

import jakarta.persistence.*;

@Entity
@Table(name = "category")  // Explicitly specify the table name
public class Category {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")  // Map to the 'id' column in the database
    private Long id;

    @Column(name = "name")  // Map to the 'name' column in the database
    private String name;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
