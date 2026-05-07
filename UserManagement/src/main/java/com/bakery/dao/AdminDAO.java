package com.bakery.dao;

import com.bakery.model.AdminUser;

//OOP Concept Applied: ABSTRACTION

public interface AdminDAO {
    AdminUser getAdminByUsername(String username);
    AdminUser getAdminByEmail(String email);
    boolean   updateLastLogin(int adminId);
    int       getTotalCustomerCount();
    int       getNewCustomersToday();
}