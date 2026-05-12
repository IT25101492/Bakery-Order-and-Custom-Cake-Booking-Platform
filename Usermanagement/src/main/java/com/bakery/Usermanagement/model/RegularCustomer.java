package com.bakery.Usermanagement.model;

import java.time.LocalDateTime;

//OOP Concepts Applied: Inheritence, Polymorphism, Encapsulation

public class RegularCustomer extends User {


    private String        deliveryAddress;
    private LocalDateTime registrationDate;
    private int           loyaltyPoints;
    private boolean       isActive;

  public RegularCustomer(int userId, String username, String email,
                           String password, String phoneNumber,
                           String deliveryAddress, LocalDateTime registrationDate,
                           int loyaltyPoints, boolean isActive) {
        // Call parent (User) constructor for shared fields
        super(userId, username, email, password, phoneNumber);

        // Initialize child-specific fields
        this.deliveryAddress  = deliveryAddress;
        this.registrationDate = registrationDate;
        this.loyaltyPoints    = loyaltyPoints;
        this.isActive         = isActive;
    }

    // Constructor for new customer registration
    public RegularCustomer(String username, String email, String password,
                           String phoneNumber, String deliveryAddress) {
        super(0, username, email, password, phoneNumber);
        this.deliveryAddress  = deliveryAddress;
        this.registrationDate = LocalDateTime.now();
        this.loyaltyPoints    = 0;
        this.isActive         = true;
    }

    // Default no-arg constructor
    public RegularCustomer() {
        super();
    }


    // Customer authentication: compare input with stored password
    @Override
    public boolean authenticate(String inputPassword) {
        return inputPassword != null &&
               inputPassword.equals(this.getPasswordForAuth());
    }

    
    // Returns the role label for this user type
    
    @Override
    public String getRole() {
        return "CUSTOMER";
    }

    //Customer-specific fields
    public String        getDeliveryAddress()  { return deliveryAddress; }
    public LocalDateTime getRegistrationDate() { return registrationDate; }
    public int           getLoyaltyPoints()    { return loyaltyPoints; }
    public boolean       isActive()            { return isActive; }

   
    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public void setRegistrationDate(LocalDateTime registrationDate) {
        this.registrationDate = registrationDate;
    }

    public void setLoyaltyPoints(int loyaltyPoints) {
        // Loyalty points negative check
        if (loyaltyPoints >= 0) {
            this.loyaltyPoints = loyaltyPoints;
        }
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    // Convenience method to add loyalty points after an order
    public void addLoyaltyPoints(int points) {
        if (points > 0) {
            this.loyaltyPoints += points;
        }
    }
}