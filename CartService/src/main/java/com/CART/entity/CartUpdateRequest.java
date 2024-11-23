package com.CART.entity;

public class CartUpdateRequest {
    private Integer cartId;
    private Integer quantity;
	public Integer getCartId() {
		return cartId;
	}
	public void setCartId(Integer cartId) {
		this.cartId = cartId;
	}
	public Integer getQuantity() {
		return quantity;
	}
	public void setQuantity(Integer quantity) {
		this.quantity = quantity;
	}

    // Getters and setters
}
