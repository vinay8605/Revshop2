package com.example.pro;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.example.pro")
@EntityScan(basePackages = "com.example.pro.entity,com.example.pro.repository,com.seller.entity")
@EnableJpaRepositories(basePackages = "com.example.pro.repository")
public class ProductApplication {

    public static void main(String[] args) {
        SpringApplication.run(ProductApplication.class, args);
    }
}
