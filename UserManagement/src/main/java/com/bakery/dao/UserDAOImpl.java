package com.bakery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.bakery.model.RegularCustomer;
import com.bakery.util.DBConnection;


//OOP Concepts Applied: Abstraction, Polymorphism, + Encapsulation

public class UserDAOImpl implements UserDAO {

    // CREATE: Register a new customer
    @Override
    public boolean registerCustomer(RegularCustomer customer) {
        //PreparedStatement to prevent SQL Injection
        String sql = "INSERT INTO customers (username, email, password, " +
                     "phone_number, delivery_address) VALUES (?, ?, ?, ?, ?)";

        // try-with-resources automatically closes Connection and PreparedStatement
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Bind parameters
            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword()); // Internal access via protected method
            ps.setString(4, customer.getPhoneNumber());
            ps.setString(5, customer.getDeliveryAddress());

            // executeUpdate() returns rows affected; 1 means success
            return ps.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] registerCustomer error: " + e.getMessage());
            return false;
        }
    }


    
    @Override
    public RegularCustomer getCustomerById(int customerId) { //READ - Get customer by ID
        String sql = "SELECT * FROM customers WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();

            // If a row is found, map it to a RegularCustomer object
            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] getCustomerById error: " + e.getMessage());
        }
        return null; // Return null if no customer found
    }

    @Override
    public RegularCustomer getCustomerByUsername(String username) {     //Get customer by username
        String sql = "SELECT * FROM customers WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] getCustomerByUsername error: " + e.getMessage());
        }
        return null;
    }

   
    @Override
    public RegularCustomer getCustomerByEmail(String email) {  //Get customer by email
        String sql = "SELECT * FROM customers WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToCustomer(rs);
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] getCustomerByEmail error: " + e.getMessage());
        }
        return null;
    }

    
    @Override
    public List<RegularCustomer> getAllCustomers() { //Get all customers (Admin view)
        String sql = "SELECT * FROM customers ORDER BY registration_date DESC";
        List<RegularCustomer> customers = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            // Loop through all rows and map each to a RegularCustomer
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] getAllCustomers error: " + e.getMessage());
        }
        return customers;
    }

    //Searches customers by username or email
    // Uses SQL LIKE for partial matching
    
    @Override
    public List<RegularCustomer> searchCustomers(String searchTerm) {
        String sql = "SELECT * FROM customers WHERE username LIKE ? OR email LIKE ?";
        List<RegularCustomer> customers = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String likePattern = "%" + searchTerm + "%";
            ps.setString(1, likePattern);
            ps.setString(2, likePattern);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                customers.add(mapResultSetToCustomer(rs));
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] searchCustomers error: " + e.getMessage());
        }
        return customers;
    }

    
    @Override
    public boolean updateCustomer(RegularCustomer customer) { //UPDATE - Modify customer details
        String sql = "UPDATE customers SET username = ?, email = ?, password = ?, " +
                     "phone_number = ?, delivery_address = ? WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, customer.getUsername());
            ps.setString(2, customer.getEmail());
            ps.setString(3, customer.getPassword());
            ps.setString(4, customer.getPhoneNumber());
            ps.setString(5, customer.getDeliveryAddress());
            ps.setInt(6, customer.getUserId());

            return ps.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] updateCustomer error: " + e.getMessage());
            return false;
        }
    }

    
    @Override
    public boolean deleteCustomer(int customerId) { //DELETE - Removes a customer account permanently
        String sql = "DELETE FROM customers WHERE customer_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            return ps.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] deleteCustomer error: " + e.getMessage());
            return false;
        }
    }

    
    @Override
    public boolean isUsernameExists(String username) { //Checks if username already exists
        String sql = "SELECT COUNT(*) FROM customers WHERE username = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0; // Returns true if count > 0
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] isUsernameExists error: " + e.getMessage());
        }
        return false;
    }

    
    @Override
    public boolean isEmailExists(String email) { //Checks if email already exists
        String sql = "SELECT COUNT(*) FROM customers WHERE email = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getInt(1) > 0;
            }

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] isEmailExists error: " + e.getMessage());
        }
        return false;
    }

    //Total customer count for Admin Dashboard
    @Override
    public int getTotalCustomerCount() {
        String sql = "SELECT COUNT(*) FROM customers WHERE is_active = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] getTotalCustomerCount error: " + e.getMessage());
        }
        return 0;
    }

    //New customers registered today for Admin Dashboard
    @Override
    public int getNewCustomersToday() {
        String sql = "SELECT COUNT(*) FROM customers WHERE DATE(registration_date) = CURDATE()";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);

        } catch (SQLException e) {
            System.err.println("[UserDAOImpl] getNewCustomersToday error: " + e.getMessage());
        }
        return 0;
    }

    //Centralizes the mapping logic — used by all READ methods
    private RegularCustomer mapResultSetToCustomer(ResultSet rs) throws SQLException {
        RegularCustomer customer = new RegularCustomer();

        customer.setUserId(rs.getInt("customer_id"));
        customer.setUsername(rs.getString("username"));
        customer.setEmail(rs.getString("email"));
        customer.setPassword(rs.getString("password"));
        customer.setPhoneNumber(rs.getString("phone_number"));
        customer.setDeliveryAddress(rs.getString("delivery_address"));
        customer.setLoyaltyPoints(rs.getInt("loyalty_points"));
        customer.setActive(rs.getInt("is_active") == 1);

        //Converts SQL Timestamp to Java LocalDateTime
        Timestamp ts = rs.getTimestamp("registration_date");
        if (ts != null) {
            customer.setRegistrationDate(ts.toLocalDateTime());
        }

        return customer;
    }
}