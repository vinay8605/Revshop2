package com.seller.entity;

import jakarta.persistence.*;
import org.springframework.web.multipart.MultipartFile;

@Entity
@Table(name = "seller")
public class Seller {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;

    @Column(name = "mobile_number")
    private String mobileNumber;

    @Column(unique = true)
    private String email;

    private String password;

    @Column(name = "business_details")
    private String businessDetails;

    private String address;
    private String city;
    private String state;
    private String pincode;

    @Lob
    private byte[] image;  // Store the image as a byte array

    @Transient
    private MultipartFile imageFile;  // Handle file upload

    private String role;
    
    @Column(name = "account_status", nullable = false)
    private Boolean accountStatus = false;  // Set default value to false


    // Getters and Setters

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMobileNumber() {
        return mobileNumber;
    }

    public void setMobileNumber(String mobileNumber) {
        this.mobileNumber = mobileNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBusinessDetails() {
        return businessDetails;
    }

    public void setBusinessDetails(String businessDetails) {
        this.businessDetails = businessDetails;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getPincode() {
        return pincode;
    }

    public void setPincode(String pincode) {
        this.pincode = pincode;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public MultipartFile getImageFile() {
        return imageFile;
    }

    public void setImageFile(MultipartFile imageFile) {
        this.imageFile = imageFile;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Boolean getAccountStatus() {
        return accountStatus;
    }

    public void setAccountStatus(Boolean accountStatus) {
        this.accountStatus = accountStatus;
    }

    // Constructor
    public Seller(Integer id, String name, String mobileNumber, String email, String password, String businessDetails,
                  String address, String city, String state, String pincode, byte[] image, MultipartFile imageFile,
                  String role, Boolean accountStatus) {
        this.id = id;
        this.name = name;
        this.mobileNumber = mobileNumber;
        this.email = email;
        this.password = password;
        this.businessDetails = businessDetails;
        this.address = address;
        this.city = city;
        this.state = state;
        this.pincode = pincode;
        this.image = image;
        this.imageFile = imageFile;
        this.role = role;
        this.accountStatus = accountStatus;
    }

    // Default constructor
    public Seller() {
    }
}
