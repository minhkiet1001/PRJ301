package dao;

import dto.ContactMessageDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils; // Dùng class có sẵn để kết nối DB

public class ContactDAO {
    public void saveMessage(String fullName, String email, String phone, String message) {
        String sql = "INSERT INTO contact_messages (full_name, email, phone, message, created_at, is_read) VALUES (?, ?, ?, ?, NOW(), false)";

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DBUtils.getConnection(); // Lấy kết nối database
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, fullName);
            stmt.setString(2, email);
            stmt.setString(3, phone);
            stmt.setString(4, message);
            stmt.executeUpdate(); // Thực thi lệnh INSERT
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } finally {
            // Đảm bảo đóng tài nguyên sau khi sử dụng
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    
      public List<ContactMessageDTO> getAllMessages() {
        List<ContactMessageDTO> messages = new ArrayList<>();
        String sql = "SELECT id, full_name, email, phone, message, created_at, is_read FROM contact_messages";

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                ContactMessageDTO message = new ContactMessageDTO();
                message.setId(rs.getInt("id"));
                message.setFullName(rs.getString("full_name"));
                message.setEmail(rs.getString("email"));
                message.setPhone(rs.getString("phone"));
                message.setMessage(rs.getString("message"));
                message.setCreatedAt(rs.getTimestamp("created_at"));
                message.setIsRead(rs.getBoolean("is_read"));

                messages.add(message);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
       
    }
         return messages;
}
      
}
