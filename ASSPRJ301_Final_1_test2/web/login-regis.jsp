<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đăng nhập & Đăng ký</title>
    <link href="https://fonts.googleapis.com/css2?family=Quicksand:wght@300;600;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        *,
        :before,
        :after {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: inherit;
        }

        body {
            font-family: 'Quicksand', sans-serif;
            background-image: url(https://raw.githubusercontent.com/CiurescuP/LogIn-Form/main/bg.jpg);
            background-repeat: no-repeat;
            background-size: cover;
            background-position: center;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-grow: 1;
            padding: 60px 20px 20px;
            width: 100%;
        }

        .form-wrapper {
            height: 500px;
            width: 400px;
            background-color: rgba(255, 255, 255, 0.13);
            position: relative;
            border-radius: 17px;
            backdrop-filter: blur(5px);
            border: 5px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 0 40px rgba(129, 236, 174, 0.6);
            padding: 15px;
            transition: transform 0.3s ease;
            overflow-y: auto;
        }

        .form-wrapper:hover {
            transform: translateY(-5px);
        }

        .form-wrapper * {
            font-family: 'Quicksand', sans-serif;
            color: #ffffff;
            letter-spacing: 1px;
            outline: none;
            border: none;
        }

        .form-title {
            font-size: 35px;
            font-weight: 600;
            line-height: 45px;
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .form-group label {
            display: block;
            margin-top: 20px;
            font-size: 22px;
            font-weight: 800;
        }

        .input-container {
            position: relative;
            width: 100%;
        }

        .form-group input {
            margin-top: 8px;
            margin-bottom: 10px;
            padding: 12px 15px;
            font-size: 14px;
            font-weight: 300;
            background: rgba(0, 0, 0, 0.4) !important; /* Màu nền xám đen trong suốt giống ảnh */
            border: none;
            border-radius: 5px;
            width: 100%;
            color: #ffffff;
            -webkit-appearance: none;
            -moz-appearance: none;
            appearance: none;
        }

        .form-group input:hover {
            background: rgba(0, 0, 0, 0.5) !important; /* Hiệu ứng hover tối hơn một chút */
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            background: rgba(0, 0, 0, 0.5) !important; /* Hiệu ứng focus tối hơn */
        }

        /* Xử lý autofill của trình duyệt */
        .form-group input:-webkit-autofill,
        .form-group input:-webkit-autofill:hover,
        .form-group input:-webkit-autofill:focus,
        .form-group input:-webkit-autofill:active {
            -webkit-box-shadow: 0 0 0 30px rgba(0, 0, 0, 0.4) inset !important;
            -webkit-text-fill-color: #ffffff !important;
        }

        ::placeholder {
            color: #a0a0a0;
            text-transform: uppercase;
            font-weight: 300;
            letter-spacing: 1px;
        }

        .submit-btn {
            margin-top: 20px;
            margin-bottom: 10px;
            width: 100%;
            background: rgba(0, 0, 0, 0.22);
            border: 2px solid #38363654;
            border-radius: 5px;
            color: #e1e1e1;
            padding: 8px 15px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
        }

        .submit-btn:hover {
            background: #629677;
            transition: all 0.50s ease;
        }

        .submit-btn:focus {
            box-shadow: 0px 0px 0px 2px rgba(103, 110, 103, 0.71);
            background: #629677;
        }

        .switch-form {
            font-size: 16px;
            display: flex;
            text-align: center;
            justify-content: center;
            align-items: center;
            margin-top: 10px;
        }

        .switch-form a {
            color: #ffffff;
            font-weight: 600;
            text-decoration: none;
            margin-left: 5px;
        }

        .switch-form a:hover {
            color: #629677;
        }

        .hidden {
            display: none;
        }

        .message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-weight: 500;
            font-size: 14px;
        }

        .error-message {
            background: #ffebee;
            color: #e74c3c;
        }

        .success-message {
            background: #e8f5e9;
            color: #27ae60;
        }

        .form-group .error {
            color: #e74c3c;
            font-size: 14px;
            margin-top: 5px;
            text-align: left;
        }
    </style>
</head>
<body>
    <%@include file="header.jsp" %> 

    <div class="login-container">
        <!-- Form đăng nhập -->
        <div class="form-wrapper" id="loginForm" style="<%= request.getAttribute("showRegisterForm") != null && (boolean) request.getAttribute("showRegisterForm") ? "display: none;" : ""%>">
            <h2 class="form-title">Đăng nhập</h2>
            <% if (request.getAttribute("errorMessage") != null) { %>
                <div class="message error-message"><%= request.getAttribute("errorMessage") %></div>
            <% } %>
            <% if (request.getAttribute("successMessage") != null) { %>
                <div class="message success-message"><%= request.getAttribute("successMessage") %></div>
            <% } %>
            <form action="login" method="post">
                <input type="hidden" name="action" value="login" />
                <div class="form-group">
                    <label for="userId">Tên đăng nhập</label>
                    <div class="input-container">
                        <input type="text" id="userId" name="txtUsername" placeholder="EMAIL OR PHONE" value="<%= request.getParameter("txtUsername") != null ? request.getParameter("txtUsername") : ""%>" required />
                    </div>
                    <% if (request.getAttribute("errorUsername") != null) { %>
                        <p class="error"><%= request.getAttribute("errorUsername") %></p>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="password">Mật khẩu</label>
                    <div class="input-container">
                        <input type="password" id="password" name="txtPassword" placeholder="PASSWORD" required />
                    </div>
                    <% if (request.getAttribute("errorPassword") != null) { %>
                        <p class="error"><%= request.getAttribute("errorPassword") %></p>
                    <% } %>
                </div>
                <button type="submit" class="submit-btn">Đăng nhập</button>
            </form>
            <p class="switch-form">Chưa có tài khoản? <a href="#" onclick="showRegister()">Đăng ký ngay</a></p>
        </div>

        <!-- Form đăng ký -->
        <div class="form-wrapper" id="registerForm" style="<%= request.getAttribute("showRegisterForm") != null && (boolean) request.getAttribute("showRegisterForm") ? "" : "display: none;"%>">
            <h2 class="form-title">Đăng ký</h2>
            <% if (request.getAttribute("errorMessage") != null && request.getAttribute("showRegisterForm") != null && (boolean) request.getAttribute("showRegisterForm")) { %>
                <div class="message error-message"><%= request.getAttribute("errorMessage") %></div>
            <% } %>
            <% if (request.getAttribute("successMessage") != null && (request.getAttribute("showRegisterForm") == null || !(boolean) request.getAttribute("showRegisterForm"))) { %>
                <div class="message success-message"><%= request.getAttribute("successMessage") %></div>
            <% } %>
            <form action="register" method="post">
                <div class="form-group">
                    <label for="newUsername">Tên đăng nhập</label>
                    <div class="input-container">
                        <input type="text" id="newUsername" name="txtNewUsername" placeholder="EMAIL OR PHONE" value="<%= request.getParameter("txtNewUsername") != null ? request.getParameter("txtNewUsername") : ""%>" required />
                    </div>
                    <% if (request.getAttribute("errorNewUsername") != null) { %>
                        <p class="error"><%= request.getAttribute("errorNewUsername") %></p>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="fullName">Họ và tên</label>
                    <div class="input-container">
                        <input type="text" id="fullName" name="txtFullName" placeholder="FULL NAME" value="<%= request.getParameter("txtFullName") != null ? request.getParameter("txtFullName") : ""%>" required />
                    </div>
                    <% if (request.getAttribute("errorFullName") != null) { %>
                        <p class="error"><%= request.getAttribute("errorFullName") %></p>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="gmail">Gmail</label>
                    <div class="input-container">
                        <input type="email" id="gmail" name="txtGmail" placeholder="EMAIL" value="<%= request.getParameter("txtGmail") != null ? request.getParameter("txtGmail") : ""%>" required />
                    </div>
                    <% if (request.getAttribute("errorGmail") != null) { %>
                        <p class="error"><%= request.getAttribute("errorGmail") %></p>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="sdt">Số điện thoại</label>
                    <div class="input-container">
                        <input type="text" id="sdt" name="txtSdt" placeholder="PHONE NUMBER" value="<%= request.getParameter("txtSdt") != null ? request.getParameter("txtSdt") : ""%>" />
                    </div>
                    <% if (request.getAttribute("errorSdt") != null) { %>
                        <p class="error"><%= request.getAttribute("errorSdt") %></p>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="newPassword">Mật khẩu</label>
                    <div class="input-container">
                        <input type="password" id="newPassword" name="txtNewPassword" placeholder="PASSWORD" required />
                    </div>
                    <% if (request.getAttribute("errorNewPassword") != null) { %>
                        <p class="error"><%= request.getAttribute("errorNewPassword") %></p>
                    <% } %>
                </div>
                <div class="form-group">
                    <label for="confirmPassword">Nhập lại mật khẩu</label>
                    <div class="input-container">
                        <input type="password" id="confirmPassword" name="txtConfirmPassword" placeholder="CONFIRM PASSWORD" required />
                    </div>
                    <% if (request.getAttribute("errorConfirmPassword") != null) { %>
                        <p class="error"><%= request.getAttribute("errorConfirmPassword") %></p>
                    <% } %>
                </div>
                <button type="submit" class="submit-btn">Đăng ký</button>
            </form>
            <p class="switch-form">Đã có tài khoản? <a href="#" onclick="showLogin()">Đăng nhập</a></p>
        </div>
    </div>

    <%@include file="footer.jsp" %> 

    <script>
        function showRegister() {
            document.getElementById("loginForm").style.display = "none";
            document.getElementById("registerForm").style.display = "block";
        }

        function showLogin() {
            document.getElementById("registerForm").style.display = "none";
            document.getElementById("loginForm").style.display = "block";
        }

        window.onload = function () {
            <% if (request.getAttribute("showRegisterForm") != null && (boolean) request.getAttribute("showRegisterForm")) { %>
                showRegister();
            <% } else { %>
                showLogin();
            <% } %>
        };
    </script>
</body>
</html>