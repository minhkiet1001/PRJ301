<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cập nhật thông tin cá nhân</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Poppins', sans-serif;
                background: linear-gradient(135deg, #f0f4f8 0%, #d9e6f2 100%);
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                margin: 0;
            }

            .header-container {
                width: 100%;
                position: fixed;
                top: 0;
                left: 0;
                z-index: 1000;
            }

            .footer-container {
                width: 100%;
                position: fixed;
                bottom: 0;
                left: 0;
                z-index: 999;
            }

            .main-content {
                flex: 1;
                display: flex;
                padding: 80px 0 60px 0;
                width: 100%;
                overflow: auto;
            }

            .sidebar {
                width: 280px;
                background: white;
                border-right: 1px solid #e0e0e0;
                padding: 20px;
                height: calc(100vh - 140px);
                position: fixed;
                left: 0;
                top: 80px;
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
                transition: all 0.3s ease;
            }

            .sidebar h3 {
                font-size: 22px;
                color: #2c3e50;
                margin-bottom: 25px;
                padding-bottom: 10px;
                border-bottom: 2px solid #5DC1B9;
            }

            .sidebar a {
                display: flex;
                align-items: center;
                padding: 12px 15px;
                color: #333;
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                border-radius: 8px;
                margin-bottom: 10px;
                transition: all 0.3s ease;
            }

            .sidebar a i {
                margin-right: 10px;
                font-size: 18px;
            }

            .sidebar a:hover, .sidebar a.active {
                background: linear-gradient(45deg, #5DC1B9, #4ECDC4);
                color: white;
                box-shadow: 0 4px 12px rgba(93, 193, 185, 0.3);
            }

            .content-area {
                flex: 1;
                margin-left: 280px;
                padding: 20px;
                width: calc(100% - 280px);
                display: flex;
                justify-content: center;
                align-items: flex-start;
            }

            .form-container {
                width: 100%;
                max-width: 600px;
                padding: 35px;
                background: white;
                border-radius: 12px;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .form-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
            }

            h2 {
                font-size: 28px;
                font-weight: 600;
                color: #2c3e50;
                text-align: center;
                margin-bottom: 25px;
                position: relative;
            }

            h2::after {
                content: "";
                display: block;
                width: 50px;
                height: 3px;
                background: #5DC1B9;
                margin: 10px auto 0;
                border-radius: 2px;
            }

            .form-group {
                position: relative;
                margin-bottom: 20px;
            }

            label {
                font-weight: 500;
                color: #555;
                font-size: 14px;
                margin-bottom: 8px;
                display: block;
            }

            .input-container {
                position: relative;
                display: flex;
                align-items: center;
            }

            .input-container i {
                position: absolute;
                left: 12px;
                color: #888;
                font-size: 16px;
                transition: color 0.3s ease;
                z-index: 2;
            }

            input[type="text"], input[type="email"], input[type="password"] {
                width: 100%;
                padding: 12px 15px 12px 38px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                font-size: 14px;
                background: #f9f9f9;
                transition: all 0.3s ease;
            }

            input[type="file"] {
                width: 100%;
                padding: 12px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                font-size: 14px;
                background: #f9f9f9;
                transition: all 0.3s ease;
            }

            input:focus {
                border-color: #5DC1B9;
                background: white;
                box-shadow: 0 0 6px rgba(93, 193, 185, 0.2);
                outline: none;
            }

            input:focus + i {
                color: #5DC1B9;
            }

            button {
                background: linear-gradient(45deg, #5DC1B9, #4ECDC4);
                color: white;
                padding: 12px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                width: 100%;
                font-size: 16px;
                font-weight: 600;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(93, 193, 185, 0.3);
            }

            button:hover {
                background: linear-gradient(45deg, #4ECDC4, #45b7d1);
                transform: scale(1.03);
                box-shadow: 0 6px 18px rgba(93, 193, 185, 0.5);
            }

            .message {
                padding: 10px 15px;
                margin-top: 5px;
                border-radius: 8px;
                font-size: 14px;
                text-align: left;
            }

            .message.success {
                background: #e8f5e9;
                color: #27ae60;
                border-left: 4px solid #27ae60;
            }

            .message.error {
                background: #ffebee;
                color: #e74c3c;
                border-left: 4px solid #e74c3c;
            }

            .form-message {
                padding: 10px 15px;
                margin-bottom: 20px;
                border-radius: 8px;
                font-size: 14px;
                text-align: center;
                font-weight: 500;
            }

            .form-message.success {
                background: #e8f5e9;
                color: #27ae60;
                border: 1px solid #a5d6a7;
            }

            .form-message.error {
                background: #ffebee;
                color: #e74c3c;
                border: 1px solid #ef9a9a;
            }

            .current-avatar {
                margin-top: 15px;
                text-align: center;
                padding: 15px;
                background: #f9f9f9;
                border-radius: 8px;
                border: 1px solid #e0e0e0;
            }

            .current-avatar img {
                max-width: 100px;
                border-radius: 50%;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
                border: 3px solid #5DC1B9;
            }
            
            .current-avatar img:hover {
                transform: scale(1.05);
            }

            .current-avatar span {
                display: block;
                margin-top: 10px;
                font-size: 13px;
                color: #666;
            }

            .verified-indicator {
                display: inline-flex;
                align-items: center;
                margin-top: 5px;
                font-size: 12px;
                color: #27ae60;
                font-weight: 500;
            }
            
            .verified-indicator i {
                margin-right: 5px;
                position: static;
            }

            input[disabled], input[readonly] {
                background: #f5f5f5;
                color: #666;
                cursor: not-allowed;
                border: 1px solid #ddd;
            }

            @media (max-width: 768px) {
                .main-content {
                    flex-direction: column;
                    padding: 80px 10px 60px 10px;
                }
                .sidebar {
                    width: 100%;
                    height: auto;
                    position: static;
                    box-shadow: none;
                    border-right: none;
                    border-bottom: 1px solid #e0e0e0;
                }
                .content-area {
                    margin-left: 0;
                    width: 100%;
                    padding: 10px;
                }
                .form-container {
                    padding: 20px;
                }
                h2 {
                    font-size: 24px;
                }
                input[type="text"], input[type="email"], input[type="password"], input[type="file"] {
                    padding: 10px 15px 10px 35px;
                    font-size: 13px;
                }
                .input-container i {
                    left: 10px;
                    font-size: 14px;
                }
                button {
                    padding: 10px;
                    font-size: 14px;
                }
            }
        </style>
    </head>
    <body>
        <div class="header-container">
            <%@include file="header.jsp" %>
        </div>

        <div class="main-content">
            <%
                if (user == null) {
                    response.sendRedirect("login-regis.jsp");
                    return;
                }
                String section = request.getParameter("section") != null ? request.getParameter("section") : "profile";
            %>
            <div class="sidebar">
                <h3>Tài khoản: <%= user.getUserID()%></h3>
                <a href="<%= request.getContextPath()%>/profile?section=profile" class="<%= section.equals("profile") ? "active" : ""%>">
                    <i class="fas fa-user"></i> Thông tin cá nhân
                </a>
                <a href="<%= request.getContextPath()%>/profile?section=security" class="<%= section.equals("security") ? "active" : ""%>">
                    <i class="fas fa-shield-alt"></i> Bảo mật
                </a>
            </div>

            <div class="content-area">
                <% if (section.equals("profile")) { %>
                <div class="form-container">
                    <h2>Cập nhật thông tin cá nhân</h2>
                    <%
                        String successMessage = (String) request.getAttribute("successMessage");
                        String errorMessage = (String) request.getAttribute("errorMessage");
                    %>
                    <% if (successMessage != null) {%>
                    <div class="form-message success"><i class="fas fa-check-circle"></i> <%= successMessage%></div>
                    <% } %>
                    <% if (errorMessage != null) {%>
                    <div class="form-message error"><i class="fas fa-exclamation-circle"></i> <%= errorMessage%></div>
                    <% }%>
                    <form action="<%= request.getContextPath()%>/updateProfile" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="userId" value="<%= user.getUserID()%>">
                        <div class="form-group">
                            <label for="fullName">Họ và tên:</label>
                            <div class="input-container">
                                <input type="text" id="fullName" name="fullName" value="<%= user.getFullName() != null ? user.getFullName() : ""%>">
                                <i class="fas fa-id-card"></i>
                            </div>
                            <% if (request.getAttribute("errorFullName") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorFullName")%></div>
                            <% }%>
                        </div>
                        <div class="form-group">
                            <label for="gmail">Gmail:</label>
                            <div class="input-container">
                                <input type="email" id="gmail" name="gmail" value="<%= user.getGmail() != null ? user.getGmail() : ""%>"
                                    <%= user.isIsVerified() ? "readonly" : ""%>>
                                <i class="fas fa-envelope"></i>
                            </div>
                            <% if (user.isIsVerified()) { %>
                            <div class="verified-indicator"><i class="fas fa-check-circle"></i> Email đã được xác nhận</div>
                            <% } %>
                            <% if (request.getAttribute("errorGmail") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorGmail")%></div>
                            <% }%>
                        </div>
                        <div class="form-group">
                            <label for="sdt">Số điện thoại:</label>
                            <div class="input-container">
                                <input type="text" id="sdt" name="sdt" value="<%= user.getSdt() != null ? user.getSdt() : ""%>">
                                <i class="fas fa-phone"></i>
                            </div>
                            <% if (request.getAttribute("errorSdt") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorSdt")%></div>
                            <% } %>
                        </div>
                        <div class="form-group">
                            <label for="avatar">Avatar:</label>
                            <input type="file" id="avatar" name="avatar" accept="image/*">
                            <% if (request.getAttribute("errorAvatar") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorAvatar")%></div>
                            <% } %>
                            <% if (user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty()) {%>
                            <div class="current-avatar">
                                <img src="<%= user.getAvatarUrl()%>" alt="Avatar hiện tại">
                                <span>Avatar hiện tại</span>
                            </div>
                            <% } else { %>
                            <div class="current-avatar">
                                <img src="<%= request.getContextPath()%>/images/default-avatar.png" alt="Avatar mặc định">
                                <span>Chưa có avatar</span>
                            </div>
                            <% } %>
                        </div>
                        <button type="submit"><i class="fas fa-save"></i> Cập nhật</button>
                    </form>
                </div>
                <% } else if (section.equals("security")) { %>
                <div class="form-container">
                    <h2>Đổi mật khẩu</h2>
                    <%
                        String changePassSuccess = (String) request.getAttribute("changePassSuccess");
                        String changePassError = (String) request.getAttribute("changePassError");
                    %>
                    <% if (changePassSuccess != null) {%>
                    <div class="form-message success"><i class="fas fa-check-circle"></i> <%= changePassSuccess%></div>
                    <% } %>
                    <% if (changePassError != null) {%>
                    <div class="form-message error"><i class="fas fa-exclamation-circle"></i> <%= changePassError%></div>
                    <% }%>
                    <form action="<%= request.getContextPath()%>/changePassword" method="post">
                        <input type="hidden" name="userId" value="<%= user.getUserID()%>">
                        <div class="form-group">
                            <label for="currentPassword">Mật khẩu hiện tại:</label>
                            <div class="input-container">
                                <input type="password" id="currentPassword" name="currentPassword" required>
                                <i class="fas fa-lock"></i>
                            </div>
                            <% if (request.getAttribute("errorCurrentPassword") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorCurrentPassword")%></div>
                            <% } %>
                        </div>
                        <div class="form-group">
                            <label for="newPassword">Mật khẩu mới:</label>
                            <div class="input-container">
                                <input type="password" id="newPassword" name="newPassword" required>
                                <i class="fas fa-key"></i>
                            </div>
                            <% if (request.getAttribute("errorNewPassword") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorNewPassword")%></div>
                            <% } %>
                        </div>
                        <div class="form-group">
                            <label for="confirmPassword">Xác nhận mật khẩu mới:</label>
                            <div class="input-container">
                                <input type="password" id="confirmPassword" name="confirmPassword" required>
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <% if (request.getAttribute("errorConfirmPassword") != null) {%>
                            <div class="message error"><i class="fas fa-exclamation-circle"></i> <%= request.getAttribute("errorConfirmPassword")%></div>
                            <% } %>
                        </div>
                        <button type="submit"><i class="fas fa-key"></i> Đổi mật khẩu</button>
                    </form>
                </div>
                <% }%>
            </div>
        </div>

        <div class="footer-container">
            <%@include file="footer.jsp" %>
        </div>
    </body>
</html>