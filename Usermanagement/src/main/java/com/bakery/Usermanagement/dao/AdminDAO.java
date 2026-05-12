package com.bakery.Usermanagement.dao;

import com.bakery.Usermanagement.model.AdminUser;

//OOP Concept Applied: ABSTRACTION

public interface AdminDAO {
    AdminUser getAdminByUsername(String username);
    AdminUser getAdminByEmail(String email);
    boolean   updateLastLogin(int adminId);
    int       getTotalCustomerCount();
    int       getNewCustomersToday();
}