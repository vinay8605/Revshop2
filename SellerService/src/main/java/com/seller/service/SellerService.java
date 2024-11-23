package com.seller.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.seller.entity.Seller;
import com.seller.repository.SellerRepository;

@Service
public class SellerService {

    @Autowired
    private SellerRepository sellerRepository;

    public void registerSeller(Seller seller) {
        // Check if the seller already exists based on email or another field
        Seller existingSeller = sellerRepository.findByEmail(seller.getEmail());
        if (existingSeller != null) {
            throw new RuntimeException("Seller with this email already exists");
        }
        System.out.println("Received seller: " + seller);

        // Save the seller to the database
        sellerRepository.save(seller);
    }


    public Seller loginSeller(String email, String password) {
        // Find seller by email
        Seller seller = sellerRepository.findByEmail(email);
        // Check if seller exists and password matches
        if (seller != null && seller.getPassword().equals(password)) {
            return seller;
        }
        return null; // Return null if authentication fails
    }

    public Seller getSellerById(Integer id) {
        // Find seller by ID
        return sellerRepository.findById(id).orElse(null);
    }

    public Seller getSellerByEmail(String email) {
        return sellerRepository.findByEmail(email);
    }

	public boolean authenticateSeller(String email, String password) {
		// TODO Auto-generated method stub
		return sellerRepository.findByEmailAndPassword(email, password).isPresent();
	}
}
