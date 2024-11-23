package com.seller.SellerService;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication(scanBasePackages = "com.seller")
@EntityScan(basePackages = "com.seller.entity,com.seller.repository")
@EnableJpaRepositories(basePackages = "com.seller.repository")

@EnableDiscoveryClient
public class SellerServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(SellerServiceApplication.class, args);
	}

}
