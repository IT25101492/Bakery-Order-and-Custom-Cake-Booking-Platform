package com.bakery.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import com.bakery.model.AdminUser;
import com.bakery.util.DBConnection;

//Implements AdminDAO interface for admin database operations.

public class AdminDAOImpl implements AdminDAO {

    @Override
    public AdminUser getAdminByUsername(String username) {
        String sql = "SELECT * FROM admins WHERE username = ? AND is_active = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToAdmin(rs);
            }

        } catch (SQLException e) {
            System.err.println("[AdminDAOImpl] getAdminByUsername error: " + e.getMessage());
        }
        return null;
    }

    @Override
    public AdminUser getAdminByEmail(String email) {
        String sql = "SELECT * FROM admins WHERE email = ? AND is_active = 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapResultSetToAdmin(rs);
            }

        } catch (SQLException e) {
            System.err.println("[AdminDAOImpl] getAdminByEmail error: " + e.getMessage());
        }
        return null;
    }

    @Override
    public boolean updateLastLogin(int adminId) {
        String sql = "UPDATE admins SET last_login_time = ? WHERE admin_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setTimestamp(1, Timestamp.valueOf(LocalDateTime.now()));
            ps.setInt(2, adminId);
            return ps.executeUpdate() == 1;

        } catch (SQLException e) {
            System.err.println("[AdminDAOImpl] updateLastLogin error: " + e.getMessage());
            return false;
        }
    }

    @Override
    public int getTotalCustomerCount() {
        String sql = "SELECT COUNT(*) FROM customers WHERE is_active = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[AdminDAOImpl] getTotalCustomerCount error: " + e.getMessage());
        }
        return 0;
    }

    @Override
    public int getNewCustomersToday() {
        String sql = "SELECT COUNT(*) FROM customers WHERE DATE(registration_date) = CURDATE()";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            System.err.println("[AdminDAOImpl] getNewCustomersToday error: " + e.getMessage());
        }
        return 0;
    }

    private AdminUser mapResultSetToAdmin(ResultSet rs) throws SQLException {
        AdminUser admin = new AdminUser();
        admin.setUserId(rs.getInt("admin_id"));
        admin.setUsername(rs.getString("username"));
        admin.setEmail(rs.getString("email"));
        admin.setPassword(rs.getString("password"));
        admin.setPhoneNumber(rs.getString("phone_number"));
        admin.setAdminLevel(rs.getInt("admin_level"));
        admin.setDepartment(rs.getString("department"));
        admin.setActive(rs.getInt("is_active") == 1);

        Timestamp ts = rs.getTimestamp("last_login_time");
        if (ts != null) {
            admin.setLastLoginTime(ts.toLocalDateTime());
        }
        return admin;
    }
}