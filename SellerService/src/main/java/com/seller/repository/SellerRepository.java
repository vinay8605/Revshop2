package com.seller.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.seller.entity.Seller;

import java.util.Optional;

public interface SellerRepository extends JpaRepository<Seller, Integer> {
    Seller findByEmail(String email);

	Optional<Seller> findByEmailAndPassword(String email, String password);
}
