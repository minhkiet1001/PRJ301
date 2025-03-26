<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO"%>
<%@page import="dao.ContactDAO"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Homestay</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', 'Segoe UI', Arial, sans-serif;
        }
        body {
            background: linear-gradient(120deg, #e0eafc 0%, #cfdef3 100%);
            color: #2c3e50;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }
        .main-content {
            flex: 1;
            padding: 100px 20px;
            max-width: 1300px;
            margin: 0 auto;
            width: 95%;
        }
        .dashboard-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
            animation: fadeIn 0.5s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h1 {
            font-size: 42px;
            font-weight: 700;
            color: #1a3c34;
            margin-bottom: 30px;
            text-align: center;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
        }
        .menu-item {
            background: linear-gradient(45deg, #1abc9c, #16a085);
            color: white;
            padding: 25px;
            border-radius: 15px;
            text-align: center;
            text-decoration: none;
            font-size: 20px;
            font-weight: 600;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            box-shadow: 0 6px 15px rgba(26, 188, 156, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            position: relative; /* Để định vị số đếm đỏ */
        }
        .menu-item i {
            font-size: 24px;
        }
        .menu-item:hover {
            transform: scale(1.05);
            box-shadow: 0 8px 25px rgba(26, 188, 156, 0.6);
        }
        /* Số tin nhắn chưa đọc */
        .message-count {
            position: absolute;
            top: 10px;
            right: 10px;
            min-width: 20px;
            height: 20px;
            background: #e74c3c;
            color: white;
            font-size: 12px;
            font-weight: 600;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2px;
            border: 2px solid #fff; /* Viền trắng để nổi bật */
        }
        .logout-btn {
            display: block;
            margin: 40px auto 0;
            padding: 12px 30px;
            background: #e74c3c;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s ease, transform 0.3s ease;
            text-align: center;
            width: fit-content;
        }
        .logout-btn i {
            margin-right: 8px;
        }
        .logout-btn:hover {
            background: #c0392b;
            transform: scale(1.05);
        }
        .error-message {
            color: #e74c3c;
            background: #ffebee;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 25px;
            font-weight: 500;
        }
        @media (max-width: 768px) {
            .main-content {
                padding: 60px 15px;
            }
            h1 {
                font-size: 32px;
            }
            .menu-item {
                font-size: 16px;
                padding: 20px;
            }
            .menu-item i {
                font-size: 20px;
            }
            .logout-btn {
                padding: 10px 25px;
                font-size: 14px;
            }
            .menu {
                gap: 15px;
            }
            .message-count {
                top: 8px;
                right: 8px;
                min-width: 18px;
                height: 18px;
                font-size: 10px;
            }
        }
    </style>
</head>
<body>
    <div class="header-container">
        <%@include file="../header.jsp" %>
    </div>

    <div class="main-content">
        <%
            Object userObj = session.getAttribute("user"); // Lấy user từ session
            if (userObj == null || !"AD".equals(((dto.UserDTO) userObj).getRoleID())) {
                response.sendRedirect(request.getContextPath() + "/login-regis.jsp");
            } else {
                ContactDAO contactDAO = new ContactDAO();
                int unreadMessageCount = contactDAO.getUnreadMessageCount();
        %>
        <div class="dashboard-container">
            <h1>Chào mừng Admin: <%= ((UserDTO) userObj).getFullName() %></h1>
            <div class="menu">
                <a href="<%= request.getContextPath() %>/admin/users" class="menu-item"><i class="fas fa-users"></i> Quản lý người dùng</a>
                <a href="<%= request.getContextPath() %>/admin/rooms" class="menu-item"><i class="fas fa-bed"></i> Quản lý phòng</a>
                <a href="<%= request.getContextPath() %>/admin/bookings" class="menu-item"><i class="fas fa-calendar-check"></i> Quản lý đặt phòng</a>
                <a href="<%= request.getContextPath() %>/admin/statistics" class="menu-item"><i class="fas fa-chart-bar"></i> thống kê</a>
               <a href="<%= request.getContextPath() %>/admin/managePromotions" class="menu-item"><i class="fas fa-ticket-alt"></i> Mã giảm giá</a>
                <a href="<%= request.getContextPath() %>/admin/messages" class="menu-item">
                    <i class="fas fa-envelope"></i> Quản lý tin nhắn
                    <% if (unreadMessageCount > 0) { %>
                    <span class="message-count"><%= unreadMessageCount %></span>
                    <% } %>
                </a>
               
                  
                
            </div>
            <a href="<%= request.getContextPath() %>/login?action=logout" class="logout-btn"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
        </div>
        <%
            }
        %>
    </div>

    <div class="footer-container">
        <%@include file="../footer.jsp" %>
    </div>
</body>
</html>