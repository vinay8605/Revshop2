package com.example.add.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.entity.DashboardStats;
import com.example.entity.MonthData;
import com.example.repository.BuyerRepository;
import com.example.repository.OrderRepository;
import com.example.repository.SellerRepository;

import java.util.List;

@Service
public class DashboardService {

    @Autowired
    private SellerRepository sellerRepository;

    @Autowired
    private BuyerRepository buyerRepository;

    @Autowired
    private OrderRepository orderRepository;

    // Method to fetch the dashboard statistics
    public DashboardStats getDashboardStats() {
        // Retrieve total sellers
        long totalSellers = sellerRepository.count(); // Assuming SellerRepository is set up with JPA

        // Retrieve total buyers
        long totalBuyers = buyerRepository.count(); // Assuming BuyerRepository is set up with JPA

        // Retrieve total orders
        long totalOrders = orderRepository.count(); // Assuming OrderRepository is set up with JPA

        // Calculate total sales (sum of amounts in orders)
        double totalSales = orderRepository.sumOrderAmounts(); // Make sure this method is defined in OrderRepository


        // Create and set values for DashboardStats
        DashboardStats stats = new DashboardStats();
        stats.setTotalSellers(totalSellers);
        stats.setTotalBuyers(totalBuyers);
        stats.setTotalOrders(totalOrders);
        stats.setTotalSales(totalSales);
        // Assuming DashboardStats has this field to hold monthly data

        // Return the statistics
        return stats;
    }
}
