package com.example.repository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Repository;

import com.example.entity.Seller;

import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

@Repository
public interface SellerRepository extends JpaRepository<Seller, Integer> {
    List<Seller> findAllByOrderByIdAsc();
    long count(); 
}
