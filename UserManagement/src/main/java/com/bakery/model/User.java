package com.bakery.model;

// OOP Concepts Applied: Abstraction, Encapsulation

public abstract class User {

    private int    userId;
    private String username;
    private String email;
    private String password;   //No getter for password - security through encapsulation
    private String phoneNumber;

    // Constructors
    public User(int userId, String username, String email,
                String password, String phoneNumber) {
        this.userId      = userId;
        this.username    = username;
        this.email       = email;
        this.password    = password;
        this.phoneNumber = phoneNumber;
    }

    // Default constructor
    public User() {}


    // Abstract Method — Polymorphism foundation
    public abstract boolean authenticate(String inputPassword);

    public int    getUserId()     { return userId; }
    public String getUsername()   { return username; }
    public String getEmail()      { return email; }
    public String getPhoneNumber(){ return phoneNumber; }


    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        // Validation: username must not be null or empty
        if (username != null && !username.trim().isEmpty()) {
            this.username = username.trim();
        }
    }

    public void setEmail(String email) {
        // Validation: basic email format check
        if (email != null && email.contains("@") && email.contains(".")) {
            this.email = email.trim().toLowerCase();
        }
    }

    public void setPassword(String password) {
        // Validation: At least 8 chars, 1 uppercase, 1 digit, 1 special char
        if (isValidPassword(password)) {
            this.password = password;
        }
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    /* 
    Accessible by subclasses only
    Used internally for password comparison during auth
    */ 
    protected String getPasswordForAuth() {
        return password;
    }


    // Used by DAO classes and kept seperated from getPasswordForAuth()
    public String getPassword(){
        return password;
    }


   /* 
   Static Utility Method
     Password validation logic centralized here so both
     RegularCustomer and AdminUser can reuse it
   */ 

    public static boolean isValidPassword(String password) {
        if (password == null || password.length() < 8) return false;

        boolean hasUpper   = false;
        boolean hasDigit   = false;
        boolean hasSpecial = false;

        for (char c : password.toCharArray()) {
            if (Character.isUpperCase(c)) hasUpper   = true;
            if (Character.isDigit(c))     hasDigit   = true;
            if (!Character.isLetterOrDigit(c)) hasSpecial = true;
        }
        return hasUpper && hasDigit && hasSpecial;
    }

    // Abstract Method — Each user type displays info differently
    public abstract String getRole();

    @Override
    public String toString() {
        return "User{" +
               "userId="      + userId   +
               ", username='" + username + '\'' +
               ", email='"    + email    + '\'' +
               ", role='"     + getRole()+ '\'' +
               '}';
    }
}