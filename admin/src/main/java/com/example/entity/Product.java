package com.example.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "product")
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "name", nullable = true)
    private String name;

    @Column(name = "description", nullable = true)
    private String description;

    @Column(name = "color", nullable = true)
    private String color;

    @Column(name = "size", nullable = true)
    private String size;

    @Column(name = "price", nullable = true)
    private double price;

    @Column(name = "quantity", nullable = true)
    private int quantity;

    @Column(name = "image", nullable = true)
    private byte[] image; // Changed to byte[] for storing binary data (like images)

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id", referencedColumnName = "id")
    private Category category;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "subcategory_id", referencedColumnName = "id")
    private Subcategory subcategory;

    @Column(name = "seller_id", nullable = true)
    private int sellerId;

    @Column(name = "discount_price", nullable = true)
    private double discountPrice;

    // Constructors
    public Product() {}

    public Product(String name, String description, String color, String size, double price, int quantity, byte[] image, Category category, Subcategory subcategory, int sellerId, double discountPrice) {
        this.name = name;
        this.description = description;
        this.color = color;
        this.size = size;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
        this.category = category;
        this.subcategory = subcategory;
        this.sellerId = sellerId;
        this.discountPrice = discountPrice;
    }

    // Getters and Setters
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public Subcategory getSubcategory() {
        return subcategory;
    }

    public void setSubcategory(Subcategory subcategory) {
        this.subcategory = subcategory;
    }

    public int getSellerId() {
        return sellerId;
    }

    public void setSellerId(int sellerId) {
        this.sellerId = sellerId;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }

    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
    }

    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", color='" + color + '\'' +
                ", size='" + size + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", image=" + (image != null ? image.length : 0) + " bytes" +
                ", category=" + category +
                ", subcategory=" + subcategory +
                ", sellerId=" + sellerId +
                ", discountPrice=" + discountPrice +
                '}';
    }
}
