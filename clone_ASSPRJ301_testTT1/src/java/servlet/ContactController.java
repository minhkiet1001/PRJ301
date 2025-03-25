package servlet;


import dto.ContactMessageDTO;
import dto.UserDTO;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import utils.DBUtils;

@WebServlet("/ContactServlet")
public class ContactController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Đặt mã hóa ký tự để hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String fullName = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String messageContent = request.getParameter("message");

        // Lấy userId từ session (nếu có)
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");
        Integer userId = null;
        if (user != null) {
            try {
                userId = Integer.parseInt(user.getUserID()); // Chuyển đổi String sang int
            } catch (NumberFormatException e) {
                userId = null; // Nếu userID không phải số, đặt null
                e.printStackTrace();
            }
        }

        // Lưu vào database
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DBUtils.getConnection();
            String sql = "INSERT INTO contact_messages (user_id, full_name, email, phone, message) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setObject(1, userId); // Sử dụng setObject để xử lý null
            pstmt.setString(2, fullName);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, messageContent);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Đặt thông báo thành công vào session
                request.getSession().setAttribute("message", "Cảm ơn bạn đã gửi tin nhắn! Chúng tôi sẽ liên hệ lại sớm nhất.");
            } else {
                request.getSession().setAttribute("message", "Có lỗi xảy ra khi gửi tin nhắn. Vui lòng thử lại!");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Lỗi kết nối database: " + e.getMessage());
        } catch(ClassNotFoundException e){
            e.printStackTrace();
            }finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        // Chuyển hướng lại trang contact.jsp
        response.sendRedirect(request.getContextPath() + "/contact.jsp");
    }
}