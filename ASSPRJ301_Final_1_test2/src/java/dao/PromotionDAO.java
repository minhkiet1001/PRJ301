package dao;

import dto.PromotionDTO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class PromotionDAO {
    private Connection getConnection() throws SQLException {
        String url = "jdbc:sqlserver://localhost:1433;databaseName=prj301_1805_slot8;encrypt=true;trustServerCertificate=true";
        String user = "sa";
        String password = "12345";
        return DriverManager.getConnection(url, user, password);
    }

    public PromotionDTO getPromotionByCode(String promoCode) {
        String query = "SELECT * FROM promotions WHERE code = ? AND start_date <= GETDATE() AND end_date >= GETDATE()";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, promoCode);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                PromotionDTO promotion = new PromotionDTO();
                promotion.setId(rs.getInt("id"));
                promotion.setCode(rs.getString("code"));
                promotion.setDiscountType(rs.getString("discount_type"));
                promotion.setDiscountAmount(rs.getDouble("discount_amount"));
                promotion.setStartDate(rs.getDate("start_date"));
                promotion.setEndDate(rs.getDate("end_date"));
                promotion.setUsageLimit(rs.getInt("usage_limit"));
                promotion.setUsageCount(rs.getInt("usage_count"));
                return promotion;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi truy vấn cơ sở dữ liệu: " + e.getMessage(), e);
        }
        return null;
    }

    public void incrementUsageCount(String promoCode) {
        String query = "UPDATE promotions SET usage_count = usage_count + 1 WHERE code = ?";
        try (Connection conn = getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, promoCode);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Lỗi khi cập nhật usage_count: " + e.getMessage(), e);
        }
    }
}