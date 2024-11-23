package com.example.entity;

import java.util.List;

public class DashboardStats {
    private long totalSellers;
    private long totalBuyers;
    private long totalOrders;
    private double totalSales;
    private List<MonthData> monthlyOrders;
    private List<MonthData> monthlySales;

    // Getters and Setters
    public long getTotalSellers() {
        return totalSellers;
    }

    public void setTotalSellers(long totalSellers) {
        this.totalSellers = totalSellers;
    }

    public long getTotalBuyers() {
        return totalBuyers;
    }

    public void setTotalBuyers(long totalBuyers) {
        this.totalBuyers = totalBuyers;
    }

    public long getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(long totalOrders) {
        this.totalOrders = totalOrders;
    }

    public double getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(double totalSales) {
        this.totalSales = totalSales;
    }

	  public List<MonthData> getMonthlyOrders() { return monthlyOrders; }
	  
	  public void setMonthlyOrders(List<MonthData> monthlyOrders) {
	  this.monthlyOrders = monthlyOrders; }
	  
	  public List<MonthData> getMonthlySales() { return monthlySales; }
	  
	  public void setMonthlySales(List<MonthData> monthlySales) { this.monthlySales
	  = monthlySales; }
	 
}