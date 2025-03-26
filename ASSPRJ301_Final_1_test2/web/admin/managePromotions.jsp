<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dto.UserDTO"%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý mã giảm giá - Homestay</title>
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
        .management-container {
            background: #ffffff;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            padding: 40px;
        }
        h1 {
            font-size: 36px;
            font-weight: 700;
            color: #1a3c34;
            margin-bottom: 30px;
            text-align: center;
        }
        .add-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 12px 25px;
            background: linear-gradient(45deg, #1abc9c, #16a085);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            transition: background 0.3s ease, transform 0.3s ease;
        }
        .add-btn:hover {
            background: linear-gradient(45deg, #16a085, #1abc9c);
            transform: scale(1.05);
        }
        .add-btn i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="header-container">
        <%@include file="header.jsp" %>
    </div>

    <div class="main-content">
        <%
            Object userObj = session.getAttribute("user");
            if (userObj == null || !"AD".equals(((dto.UserDTO) userObj).getRoleID())) {
                response.sendRedirect(request.getContextPath() + "/login-regis.jsp");
                return;
            }
        %>
        <div class="management-container">
            <h1>Quản lý mã giảm giá</h1>
            <a href="<%= request.getContextPath() %>/addPromotion.jsp" class="add-btn"><i class="fas fa-plus-circle"></i> Thêm mã giảm giá</a>
            <!-- Thêm danh sách mã giảm giá ở đây nếu cần -->
        </div>
    </div>

    <div class="footer-container">
        <%@include file="footer.jsp" %>
    </div>
</body>
</html>