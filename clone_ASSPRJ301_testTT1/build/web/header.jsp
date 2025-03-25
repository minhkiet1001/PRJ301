<%@page pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Header</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                margin: 0;
                font-family: 'Segoe UI', Arial, sans-serif;
            }

            header {
                background: linear-gradient(45deg, #5DC1B9, #F7DC6F); /* Gradient xanh ngọc và vàng nhạt */
                color: white;
                padding: 10px 50px;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                z-index: 1000;
                transition: all 0.3s ease-in-out;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            }

            .container {
                display: flex;
                justify-content: space-between;
                align-items: center;
                max-width: 1200px;
                margin: 0 auto;
                height: 60px;
            }

            .logo {
                font-size: 28px;
                font-weight: 700;
                font-family: 'Pacifico', cursive; /* Font viết tay cho cảm giác ấm áp */
                letter-spacing: 1.5px;
                color: #ffffff;
                transition: transform 0.3s ease, text-shadow 0.3s ease;
            }

            .logo:hover {
                transform: scale(1.05);
                text-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
            }

            .nav-links {
                list-style: none;
                display: flex;
                align-items: center;
            }

            .nav-links li {
                margin: 0 15px;
            }

            .nav-links a {
                color: white;
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
                padding: 8px 12px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .nav-links a:hover, .nav-links a:focus {
                background: rgba(255, 255, 255, 0.15);
                color: #F8E1A1; /* Vàng nhạt khi hover */
                transform: translateY(-2px);
            }

            .header-right {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .user-info {
                position: relative;
                display: flex;
                align-items: center;
            }

            .user-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: #A2D9CE; /* Màu nền pastel nhẹ */
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                overflow: hidden;
                border: 2px solid transparent;
                background-image: linear-gradient(45deg, #5DC1B9, #F7DC6F); /* Viền gradient */
                background-clip: padding-box;
            }

            .user-avatar:hover {
                transform: scale(1.1);
                box-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
            }

            .user-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .user-avatar span {
                font-size: 20px;
                font-weight: 600;
                color: #5DC1B9;
            }

            .dropdown-menu {
                display: none;
                position: absolute;
                top: 100%;
                right: 0;
                background: linear-gradient(45deg, rgba(93, 193, 185, 0.85), rgba(78, 205, 196, 0.85));
                box-shadow: 0 6px 15px rgba(0, 0, 0, 0.2);
                border-radius: 12px;
                list-style: none;
                padding: 15px;
                min-width: 220px;
                z-index: 1001;
                backdrop-filter: blur(5px);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .user-info:hover .dropdown-menu {
                display: block;
                animation: slideDown 0.3s ease forwards;
            }

            @keyframes slideDown {
                from { transform: translateY(-10px); opacity: 0; }
                to { transform: translateY(0); opacity: 1; }
            }

            .dropdown-menu .user-profile {
                display: flex;
                flex-direction: column;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid rgba(255, 255, 255, 0.3);
                margin-bottom: 10px;
            }

            .dropdown-menu .user-profile .avatar {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                background: #ffffff;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-bottom: 10px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .dropdown-menu .user-profile .avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }

            .dropdown-menu .user-profile .avatar span {
                font-size: 28px;
                font-weight: 600;
                color: #5DC1B9;
            }

            .dropdown-menu .user-profile .name {
                font-size: 16px;
                font-weight: 500;
                color: white;
                text-align: center;
                padding: 0 10px;
            }

            .dropdown-menu li {
                margin: 5px 0;
            }

            .dropdown-menu a {
                display: block;
                color: white;
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                padding: 10px 20px;
                border-radius: 8px;
                transition: all 0.3s ease;
            }

            .dropdown-menu a:hover {
                background: rgba(255, 255, 255, 0.2);
                transform: translateX(5px);
            }

            .login-btn {
                padding: 8px 20px;
                text-decoration: none;
                border-radius: 25px;
                font-size: 14px;
                font-weight: 600;
                background: linear-gradient(45deg, #F7DC6F, #F1C40F); /* Gradient vàng cho nút đăng nhập */
                color: white;
                position: relative;
                overflow: hidden;
                transition: all 0.3s ease;
                box-shadow: 0 4px 12px rgba(241, 196, 15, 0.3);
                border: 1px solid rgba(255, 255, 255, 0.2);
            }

            .login-btn:hover {
                background: linear-gradient(45deg, #F8E1A1, #F4D03F);
                transform: scale(1.05) translateY(-2px);
                box-shadow: 0 6px 18px rgba(241, 196, 15, 0.5);
                color: #fff;
            }

            .login-btn::before {
                content: '';
                position: absolute;
                top: 50%;
                left: 50%;
                width: 0;
                height: 0;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
                transform: translate(-50%, -50%);
                transition: width 0.4s ease, height 0.4s ease;
            }

            .login-btn:hover::before {
                width: 150%;
                height: 150%;
                opacity: 0;
            }

            .menu-toggle {
                display: none;
                font-size: 28px;
                cursor: pointer;
                color: white;
                transition: transform 0.3s ease;
            }

            .menu-toggle:hover {
                transform: scale(1.1);
            }

            @media (max-width: 768px) {
                header {
                    padding: 10px 20px;
                }

                .nav-links {
                    display: none;
                    flex-direction: column;
                    background: linear-gradient(45deg, #5DC1B9, #F7DC6F); /* Đồng bộ gradient */
                    position: absolute;
                    width: 100%;
                    left: 0;
                    top: 60px;
                    text-align: center;
                    padding: 15px 0;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                }

                .nav-links.active {
                    display: flex;
                }

                .nav-links li {
                    margin: 10px 0;
                }

                .nav-links a {
                    display: block;
                    padding: 10px 20px;
                    font-size: 16px;
                }

                .header-right {
                    flex-direction: column;
                    align-items: flex-end;
                    gap: 5px;
                }

                .user-avatar {
                    width: 35px;
                    height: 35px;
                }

                .user-avatar img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .user-avatar span {
                    font-size: 18px;
                }

                .dropdown-menu {
                    display: none;
                    position: static;
                    width: 100%;
                    background: linear-gradient(45deg, rgba(93, 193, 185, 0.85), rgba(78, 205, 196, 0.85));
                    box-shadow: none;
                    border-radius: 0;
                    padding: 10px;
                }

                .user-info:hover .dropdown-menu {
                    display: none;
                }

                .user-info.active .dropdown-menu {
                    display: block;
                    opacity: 1;
                }

                .dropdown-menu .user-profile .avatar {
                    width: 50px;
                    height: 50px;
                }

                .dropdown-menu .user-profile .avatar img {
                    width: 100%;
                    height: 100%;
                    object-fit: cover;
                }

                .dropdown-menu .user-profile .avatar span {
                    font-size: 24px;
                }

                .dropdown-menu .user-profile .name {
                    font-size: 14px;
                }

                .login-btn {
                    padding: 6px 16px;
                    font-size: 12px;
                }

                .menu-toggle {
                    display: block;
                }

                .container {
                    height: 50px;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <div class="container">
                <div class="logo">🏡 KiBaKa Homestay</div>
                <nav>
                    <ul class="nav-links">
                        <li><a href="<%= request.getContextPath()%>/home.jsp">Trang chủ</a></li>
                        <li><a href="<%= request.getContextPath()%>/search.jsp">Homestay</a></li>
                        <li><a href="<%= request.getContextPath()%>/services.jsp">Dịch vụ</a></li>
                        <li><a href="<%= request.getContextPath()%>/contact.jsp">Liên hệ</a></li>
                        <li><a href="<%= request.getContextPath()%>/notifications.jsp">Thông báo</a></li>
                        <%
                            UserDTO user = (UserDTO) session.getAttribute("user");
                            if (user != null && "AD".equals(user.getRoleID())) {
                        %>
                        <li><a href="<%= request.getContextPath()%>/admin/dashboard.jsp">Admin Dashboard</a></li>
                        <% } %>
                    </ul>
                </nav>
                <div class="header-right">
                    <%
                        if (user != null) {
                            String fullName = user.getFullName();
                            String avatarInitial = fullName != null && !fullName.isEmpty() ? fullName.substring(0, 1).toUpperCase() : "U";
                    %>
                    <div class="user-info">
                        <div class="user-avatar">
                            <% if (user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty()) {%>
                            <img src="<%= user.getAvatarUrl()%>" alt="Avatar" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                            <% } else {%>
                            <span><%= avatarInitial%></span>
                            <% } %>
                        </div>
                        <ul class="dropdown-menu">
                            <li class="user-profile">
                                <div class="avatar">
                                    <% if (user.getAvatarUrl() != null && !user.getAvatarUrl().isEmpty()) {%>
                                    <img src="<%= user.getAvatarUrl()%>" alt="Avatar" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover;">
                                    <% } else {%>
                                    <span><%= avatarInitial%></span>
                                    <% }%>
                                </div>
                                <span class="name"><%= fullName != null ? fullName : "Người dùng"%></span>
                            </li>
                            <li><a href="<%= request.getContextPath()%>/viewBookings">Đơn của tôi</a></li>
                            <li><a href="<%= request.getContextPath()%>/profile.jsp">Thông tin cá nhân</a></li>
                            <li><a href="<%= request.getContextPath()%>/login?action=logout">Đăng xuất</a></li>
                        </ul>
                    </div>
                    <% } else {%>
                    <a href="<%= request.getContextPath()%>/login-regis.jsp" class="login-btn">Đăng nhập</a>
                    <% }%>
                </div>
                <div class="menu-toggle">☰</div>
            </div>
        </header>

        <script>
            document.querySelector(".menu-toggle").addEventListener("click", function () {
                document.querySelector(".nav-links").classList.toggle("active");
            });

            const userInfo = document.querySelector(".user-info");
            if (window.innerWidth <= 768 && userInfo) {
                document.querySelector(".user-avatar").addEventListener("click", function (e) {
                    e.preventDefault();
                    userInfo.classList.toggle("active");
                });
            }

            window.addEventListener("scroll", function () {
                const header = document.querySelector("header");
                if (window.scrollY > 50) {
                    header.style.boxShadow = "0 4px 12px rgba(0, 0, 0, 0.2)";
                } else {
                    header.style.boxShadow = "0 2px 10px rgba(0, 0, 0, 0.1)";
                }
            });
        </script>
    </body>
</html>