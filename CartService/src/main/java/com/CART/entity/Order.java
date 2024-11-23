package com.CART.entity;

import jakarta.persistence.*;
import java.time.LocalDate;

import com.demo.entity.Buyer;
import com.example.pro.entity.Product;

@Entity
@Table(name = "orders")
public class Order {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;               // Order ID (primary key)
    
    @Column(name = "created_at")
    private LocalDate createdAt;  // Created date (without time)
    
    @Column(name = "quantity", nullable = false)
    private int quantity;          // Quantity of the product
    
    @Column(name = "status")
    private String status;         // Status of the order (e.g., Pending, Shipped)
    
    @ManyToOne
    @JoinColumn(name = "buyer_id", referencedColumnName = "id", nullable = false)
    private Buyer buyer;           // Reference to the buyer (foreign key)
    
    @ManyToOne
    @JoinColumn(name = "product_id", referencedColumnName = "id", nullable = false)
    private Product product;       // Reference to the product (foreign key)
    
    @Column(name = "amount")
    private double amount;         // Total amount of the order

    // Getters and Setters
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Buyer getBuyer() {
        return buyer;
    }

    public void setBuyer(Buyer buyer) {
        this.buyer = buyer;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    // Optional: Constructor for easier instantiation
    public Order(LocalDate createdAt, int quantity, String status, Buyer buyer, Product product, double amount) {
        this.createdAt = createdAt;
        this.quantity = quantity;
        this.status = status;
        this.buyer = buyer;
        this.product = product;
        this.amount = amount;
    }

	public Order() {
		super();
		// TODO Auto-generated constructor stub
	}
}
