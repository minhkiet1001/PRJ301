<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.ContactMessageDTO"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thông báo từ người dùng</title>
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
        }
        .main-content {
            flex: 1;
            padding: 100px 20px;
            max-width: 1300px;
            margin: 0 auto;
            width: 95%;
        }
        .notifications-container {
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
        .table-container {
            overflow-x: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        th, td {
            padding: 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background: linear-gradient(45deg, #1abc9c, #16a085);
            color: white;
            font-weight: 600;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .no-data {
            text-align: center;
            color: #e74c3c;
            font-size: 18px;
            padding: 20px;
        }
        .back-btn {
            display: block;
            margin: 20px auto 0;
            padding: 12px 30px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s ease, transform 0.3s ease;
            text-align: center;
            width: fit-content;
        }
        .back-btn i {
            margin-right: 8px;
        }
        .back-btn:hover {
            background: #2980b9;
            transform: scale(1.05);
        }
        .error-message {
            color: #e74c3c;
            text-align: center;
            padding: 15px;
            background: #ffe6e6;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        @media (max-width: 768px) {
            .main-content {
                padding: 60px 15px;
            }
            h1 {
                font-size: 32px;
            }
            th, td {
                padding: 10px;
                font-size: 14px;
            }
            .back-btn {
                padding: 10px 25px;
                font-size: 14px;
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
            Object userObj = session.getAttribute("user");
            if (userObj == null || !"AD".equals(((dto.UserDTO) userObj).getRoleID())) {
                response.sendRedirect(request.getContextPath() + "/login-regis.jsp");
            } else {
        %>
        <div class="notifications-container">
            <h1>Thông báo từ người dùng</h1>
            <%
                String errorMessage = (String) session.getAttribute("message");
                if (errorMessage != null) {
            %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
            <%
                    session.removeAttribute("message");
                }
            %>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>User ID</th>
                            <th>Họ và tên</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th>Tin nhắn</th>
                            <th>Thời gian gửi</th>
                            <th>Đã đọc</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<ContactMessageDTO> messages = (List<ContactMessageDTO>) request.getAttribute("messages");
                            if (messages != null && !messages.isEmpty()) {
                                for (ContactMessageDTO message : messages) {
                        %>
                        <tr>
                            <td><%= message.getId() %></td>
                            <td><%= message.getUserId() == 0 ? "Không có" : message.getUserId() %></td>
                            <td><%= message.getFullName() != null ? message.getFullName() : "Không có" %></td>
                            <td><%= message.getEmail() != null ? message.getEmail() : "Không có" %></td>
                            <td><%= message.getPhone() != null ? message.getPhone() : "Không có" %></td>
                            <td><%= message.getMessage() != null ? message.getMessage() : "Không có" %></td>
                            <td><%= message.getCreatedAt() != null ? message.getCreatedAt() : "Không có" %></td>
                            <td><%= message.isIsRead() ? "Đã đọc" : "Chưa đọc" %></td>
                        </tr>
                        <%
                                }
                            } else {
                        %>
                        <tr>
                            <td colspan="8" class="no-data">Chưa có thông báo nào từ người dùng.</td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <a href="<%= request.getContextPath() %>/admin/dashboard" class="back-btn"><i class="fas fa-arrow-left"></i> Quay lại Dashboard</a>
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