package com.example.entity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;

@Entity
@Table(name = "seller")
public class Seller {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String name;
    @Column(name = "mobile_number")
    private String mobileNumber;
    private String email;
    private String password;
    @Column(name = "business_details")
    private String businessDetails;
    private String address;
    private String city;
    private String state;
    private String pincode;
    private String image;
    private String role;
    @Column(name = "account_status")
    private boolean accountStatus;  // true for active, false for deactivated
    @Override
    public String toString() {
        return "Seller [id=" + id + ", name=" + name + ", email=" + email + ", mobileNumber=" + mobileNumber + "]";
    }

	public int getId() {
		return id;
	}
	public void setId(int id) {
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
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public boolean isAccountStatus() {
		return accountStatus;
	}
	public void setAccountStatus(boolean accountStatus) {
		this.accountStatus = accountStatus;
	}

    // getters and setters
}
