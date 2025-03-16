package servlet;

import dto.ContactMessageDTO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.DBUtils;

@WebServlet("/admin/notifications")
public class Notification extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Kiểm tra quyền truy cập
        Object userObj = request.getSession().getAttribute("user");
        if (userObj == null || !"AD".equals(((dto.UserDTO) userObj).getRoleID())) {
            response.sendRedirect(request.getContextPath() + "/login-regis.jsp");
            return;
        }

        // Lấy dữ liệu từ database
        List<ContactMessageDTO> messages = new ArrayList<>();
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            conn = DBUtils.getConnection();
            stmt = conn.createStatement();
            String sql = "SELECT * FROM contact_messages ORDER BY created_at DESC";
            rs = stmt.executeQuery(sql);

            while (rs.next()) {
                ContactMessageDTO message = new ContactMessageDTO();
                message.setId(rs.getInt("id"));
                message.setUserId(rs.getInt("user_id"));
                if (rs.wasNull()) {
                    message.setUserId(0); // Đặt giá trị mặc định nếu user_id là NULL
                }
                message.setFullName(rs.getString("full_name"));
                message.setEmail(rs.getString("email"));
                message.setPhone(rs.getString("phone"));
                message.setMessage(rs.getString("message"));
                message.setCreatedAt(rs.getTimestamp("created_at"));
                message.setIsRead(rs.getBoolean("is_read"));
                messages.add(message);
            }

            // Đặt danh sách messages vào request attribute
            request.setAttribute("messages", messages);

        } catch (SQLException e) {
            e.printStackTrace();
            // Sử dụng request.getSession() để đặt thông báo lỗi
            HttpSession session = request.getSession();
            session.setAttribute("message", "Lỗi lấy dữ liệu từ database: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("message", "Lỗi kết nối driver database: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Chuyển hướng đến contactuser.jsp
        request.getRequestDispatcher("/admin/contactofuser.jsp").forward(request, response);
    }
}