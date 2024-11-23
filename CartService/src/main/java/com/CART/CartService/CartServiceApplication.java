package com.CART.CartService;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.CART")  // Keep scanning com.CART
@ComponentScan(basePackages = {"com.demo", "com.CART"}) // Explicitly scan com.demo service package
@EntityScan(basePackages = {"com.CART.entity", "com.example.pro.entity", "com.demo.entity", "com.seller.entity"})
@EnableJpaRepositories(basePackages = {"com.CART.repository", "com.example.pro.repository", "com.demo.repository"})
public class CartServiceApplication {

    public static void main(String[] args) {
        SpringApplication.run(CartServiceApplication.class, args);
    }
}
