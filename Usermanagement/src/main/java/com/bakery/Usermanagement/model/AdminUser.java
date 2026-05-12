package com.bakery.Usermanagement.model;

import java.time.LocalDateTime;

//OOP Concepts Applied: Inheritence, Polymorphism, Encapsulation
 
public class AdminUser extends User {
    private int           adminLevel;     // 1 = Regular, 2 = Super Admin
    private String        department;
    private LocalDateTime lastLoginTime;
    private boolean       isActive;

    public AdminUser(int userId, String username, String email,
                     String password, String phoneNumber,
                     int adminLevel, String department,
                     LocalDateTime lastLoginTime, boolean isActive) {
        // Initialize parent (User) fields
        super(userId, username, email, password, phoneNumber);

        // Initialize admin-specific fields
        this.adminLevel     = adminLevel;
        this.department     = department;
        this.lastLoginTime  = lastLoginTime;
        this.isActive       = isActive;
    }

    // Default constructor
    public AdminUser() {
        super();
    }


    @Override
    public boolean authenticate(String inputPassword) {
        // Admin must be active to log in
        if (!this.isActive) return false;

        // Admin must have a valid admin level
        if (this.adminLevel < 1 || this.adminLevel > 2) return false;

        // Compare provided password with stored password
        return inputPassword != null &&
               inputPassword.equals(this.getPasswordForAuth());
    }

    @Override
    public String getRole() {
        return adminLevel == 2 ? "SUPER_ADMIN" : "ADMIN";
    }

    public int           getAdminLevel()    { return adminLevel; }
    public String        getDepartment()    { return department; }
    public LocalDateTime getLastLoginTime() { return lastLoginTime; }
    public boolean       isActive()         { return isActive; }

    
    public void setAdminLevel(int adminLevel) {
        // Only valid levels are 1 (Admin) or 2 (Super Admin)
        if (adminLevel == 1 || adminLevel == 2) {
            this.adminLevel = adminLevel;
        }
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public void setLastLoginTime(LocalDateTime lastLoginTime) {
        this.lastLoginTime = lastLoginTime;
    }

    public void setActive(boolean isActive) {
        this.isActive = isActive;
    }

    // Updates last login time — called after successful authentication
    public void recordLogin() {
        this.lastLoginTime = LocalDateTime.now();
    }
}