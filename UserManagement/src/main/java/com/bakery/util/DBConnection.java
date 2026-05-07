package com.bakery.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String DB_URL      = "jdbc:mysql://localhost:3306/bakery_db" +
                                              "?useSSL=false&serverTimezone=UTC";
    private static final String DB_USER     = "root";       // MySQL username
    private static final String DB_PASSWORD = "your_password"; // MySQL password
    private static final String DB_DRIVER   = "com.mysql.cj.jdbc.Driver";


    // Static block: Load the MySQL JDBC driver once when
    // the class is first loaded into memory
    static {
        try {
            Class.forName(DB_DRIVER);
            System.out.println("[DBConnection] MySQL JDBC Driver loaded successfully.");
        } catch (ClassNotFoundException e) {
            System.err.println("[DBConnection] Failed to load MySQL driver: " + e.getMessage());
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    // Returns a new Connection to the bakery_db database
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }
    private DBConnection() {} //Prevents instantiation of utility class
}