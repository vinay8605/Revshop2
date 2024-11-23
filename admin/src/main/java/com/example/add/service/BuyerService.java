package com.example.add.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.Buyer;
import com.example.repository.BuyerRepository;

import java.util.List;
import java.util.Optional;

@Service
public class BuyerService {

    private final BuyerRepository buyerRepository;

    @Autowired
    public BuyerService(BuyerRepository buyerRepository) {
        this.buyerRepository = buyerRepository;
    }

    // Get all buyers in ascending order by id
    public List<Buyer> getAllBuyers() {
        return buyerRepository.findAllByOrderByIdAsc();
    }

    // Update account status (activate or deactivate)
    public void updateBuyerStatus(Long id, boolean approval_status) {
        Optional<Buyer> buyerOptional = buyerRepository.findById(id);
        if (buyerOptional.isPresent()) {
            Buyer buyer = buyerOptional.get();
            buyer.setApproval_status(approval_status);
            buyerRepository.save(buyer);
        } else {
            // Optionally, you could throw an exception or log a message here
            System.out.println("Buyer with id " + id + " not found");
        }
    }
}
