package com.example.entity;


public class MonthData {
    private String month;
    private long count;  // for order count
    private double amount;  // for total sales amount

    // Constructor with count and amount
    public MonthData(String month, long count, double amount) {
        this.month = month;
        this.count = count;
        this.amount = amount;
    }

    // Getters and Setters
    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public long getCount() {
        return count;
    }

    public void setCount(long count) {
        this.count = count;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }
}
