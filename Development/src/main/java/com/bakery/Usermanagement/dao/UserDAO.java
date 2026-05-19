package com.bakery.Usermanagement.dao;

import java.util.List;

import com.bakery.Usermanagement.model.RegularCustomer;

 //Interface: UserDAO (Data Access Object)
 //OOP Concepts Applied: Abstraction + Polymorphism

public interface UserDAO {

    
    boolean registerCustomer(RegularCustomer customer);  // CREATE - Registering a new customer in the database

    RegularCustomer getCustomerById(int customerId);  // READ - Retrieve a single customer by their unique ID
    
    RegularCustomer getCustomerByUsername(String username); 

    RegularCustomer getCustomerByEmail(String email);    

    
    List<RegularCustomer> getAllCustomers(); // READ - Retrieve all customers (Admin view)

    
    List<RegularCustomer> searchCustomers(String searchTerm); //Search customers by username or email
    
    boolean updateCustomer(RegularCustomer customer); // UPDATE - Modify an existing customer's details
    
    boolean deleteCustomer(int customerId); // DELETE — Permanently removes a customer account
    
    boolean isUsernameExists(String username);

    boolean isEmailExists(String email);

    int getTotalCustomerCount();
    
    int getNewCustomersToday(); // Get's newly registered customers today
}