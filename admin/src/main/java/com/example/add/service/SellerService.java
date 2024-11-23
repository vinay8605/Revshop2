package com.example.add.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Seller;
import com.example.repository.SellerRepository;

import java.util.List;
import java.util.Optional;

@Service
public class SellerService {

    @Autowired
    private SellerRepository sellerRepository;

    // Get all sellers
    public List<Seller> getAllSellers() {
        return sellerRepository.findAllByOrderByIdAsc();
    }

    // Update account status (activate or deactivate)
    public void updateSellerStatus(int id, boolean accountStatus) {
        Optional<Seller> seller = sellerRepository.findById(id);
        if (seller.isPresent()) {
            seller.get().setAccountStatus(accountStatus);
            sellerRepository.save(seller.get());
        }
    }
}
