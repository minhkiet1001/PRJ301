<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            /* Reset CSS */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Body */
            body {
                font-family: 'Poppins', sans-serif;
                background: whitesmoke;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            /* Container */
            .login-container {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-grow: 1;
                padding: 20px;
                width: 100%;
            }

            /* Form chung */
            .form-wrapper {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 420px;
                text-align: center;
                transition: transform 0.3s ease;
            }

            .form-wrapper:hover {
                transform: scale(1.02);
            }

            /* Tiêu đề */
            .form-title {
                font-size: 28px;
                font-weight: bold;
                color: #333;
                margin-bottom: 20px;
            }

            .form-title::after {
                content: "";
                display: block;
                width: 50px;
                height: 4px;
                background: #5DC1B9;
                margin: 10px auto 0;
                border-radius: 2px;
            }

            /* Nhóm input */
            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            .form-group label {
                font-weight: 600;
                color: #444;
                display: block;
                margin-bottom: 8px;
                font-size: 16px;
            }

            .form-group input {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #ddd;
                border-radius: 8px;
                font-size: 16px;
                background: #f9f9f9;
                transition: all 0.3s ease;
            }

            .form-group input:focus {
                border-color: #5DC1B9;
                outline: none;
                background: white;
                box-shadow: 0 0 5px rgba(93, 193, 185, 0.3);
            }

            /* Nút */
            .submit-btn {
                background: #5DC1B9;
                color: white;
                padding: 14px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
                width: 100%;
                font-size: 18px;
                font-weight: bold;
                transition: all 0.3s ease;
            }

            .submit-btn:hover {
                background: #4BAA9F;
                transform: scale(1.05);
            }

            /* Liên kết chuyển đổi */
            .switch-form {
                margin-top: 15px;
                font-size: 14px;
                color: #555;
            }

            .switch-form a {
                color: #5DC1B9;
                font-weight: bold;
                text-decoration: none;
                transition: 0.3s;
            }

            .switch-form a:hover {
                color: #4BAA9F;
            }

            /* Ẩn form */
            .hidden {
                display: none;
            }

            /* Hiển thị lỗi, thông báo thành công */
            .error-message, .success-message {
                color: red;
                font-size: 14px;
                margin-bottom: 10px;
                text-align: center;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %> 

        <div class="login-container">
            <!-- Form đăng nhập -->
            <div class="form-wrapper" id="loginForm">
                <h2 class="form-title">Đăng nhập</h2>

                <form action="login" method="post">
                    <input type="hidden" name="action" value="login" />

                    <div class="form-group">
                        <label for="userId">Tên đăng nhập</label>
                        <input type="text" id="userId" name="txtUsername" required />
                        <% if (request.getAttribute("errorUsername") != null) {%>
                        <p class="error-message"><%= request.getAttribute("errorUsername")%></p>
                        <% } %>
                    </div>

                    <div class="form-group">
                        <label for="password">Mật khẩu</label>
                        <input type="password" id="password" name="txtPassword" required />
                        <% if (request.getAttribute("errorPassword") != null) {%>
                        <p class="error-message"><%= request.getAttribute("errorPassword")%></p>
                        <% } %>
                    </div>

                    <button type="submit" class="submit-btn">Đăng nhập</button>

                    <% if (request.getAttribute("errorMessage") != null) {%>
                    <p class="error-message"><%= request.getAttribute("errorMessage")%></p>
                    <% } %>
                </form>

                <p class="switch-form">Chưa có tài khoản? <a href="#" onclick="showRegister()">Đăng ký ngay</a></p>
            </div>

            <!-- Form đăng ký -->
            <div class="form-wrapper hidden" id="registerForm">
                <h2 class="form-title">Đăng ký</h2>

                <form action="register" method="post">
                    <div class="form-group">
                        <label for="newUsername">Tên đăng nhập</label>
                        <input type="text" id="newUsername" name="txtNewUsername" required />
                        <% if (request.getAttribute("errorNewUsername") != null) {%>
                        <p class="error-message"><%= request.getAttribute("errorNewUsername")%></p>
                        <% } %>
                    </div>

                    <div class="form-group">
                        <label for="fullName">Họ và tên</label>
                        <input type="text" id="fullName" name="txtFullName" required />
                        <% if (request.getAttribute("errorFullName") != null) {%>
                        <p class="error-message"><%= request.getAttribute("errorFullName")%></p>
                        <% } %>
                    </div>

                    <div class="form-group">
                        <label for="newPassword">Mật khẩu</label>
                        <input type="password" id="newPassword" name="txtNewPassword" required />
                        <% if (request.getAttribute("errorNewPassword") != null) {%>
                        <p class="error-message"><%= request.getAttribute("errorNewPassword")%></p>
                        <% } %>
                    </div>

                    <div class="form-group">
                        <label for="confirmPassword">Nhập lại mật khẩu</label>
                        <input type="password" id="confirmPassword" name="txtConfirmPassword" required />
                        <% if (request.getAttribute("errorConfirmPassword") != null) {%>
                        <p class="error-message"><%= request.getAttribute("errorConfirmPassword")%></p>
                        <% } %>
                    </div>

                    <button type="submit" class="submit-btn">Đăng ký</button>

                    <% if (request.getAttribute("errorMessage") != null) {%>
                    <p class="error-message"><%= request.getAttribute("errorMessage")%></p>
                    <% } %>
                    <% if (request.getAttribute("successMessage") != null) {%>
                    <p class="success-message"><%= request.getAttribute("successMessage")%></p>
                    <% } %>

                </form>

                <p class="switch-form">Đã có tài khoản? <a href="#" onclick="showLogin()">Đăng nhập</a></p>
            </div>
        </div>

        <%@include file="footer.jsp" %> 

        <script>
            function showRegister() {
                document.getElementById("loginForm").classList.add("hidden");
                document.getElementById("registerForm").classList.remove("hidden");
            }

            function showLogin() {
                document.getElementById("registerForm").classList.add("hidden");
                document.getElementById("loginForm").classList.remove("hidden");
            }
            window.onload = function () {
            <% if (request.getAttribute("showRegisterForm") != null) { %>
                showRegister();
            <% } else { %>
                showLogin();
            <% }%>
            };
        </script>
    </body>
</html>