package com.CART.entity;

import com.demo.entity.Buyer;
import com.example.pro.entity.Product;

import jakarta.persistence.*;
@Entity
public class Cart {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long cartId;

    private int quantity;

    @ManyToOne
    @JoinColumn(name = "product_id")
    private Product product;  // The product associated with the cart item

    @ManyToOne
    @JoinColumn(name = "buyer_id")  // Update to reflect the correct field name
    private Buyer buyer;  // The buyer associated with the cart item

    // Getters and Setters

    public Long getCartId() {
        return cartId;
    }

    public void setCartId(Long cartId) {
        this.cartId = cartId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public Buyer getBuyer() {
        return buyer;
    }

    public void setBuyer(Buyer buyer) {
        this.buyer = buyer;
    }
}
