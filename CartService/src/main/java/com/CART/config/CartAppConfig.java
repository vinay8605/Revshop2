package com.CART.config;
import org.springframework.cloud.client.loadbalancer.LoadBalanced;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class CartAppConfig {

	 @Bean(name = "cartRestTemplate")
    @LoadBalanced
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
}
