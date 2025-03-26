<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dto.RoomDTO" %>
<%@ page import="dto.ReviewDTO" %>
<%@ page import="dao.ReviewDAO" %>
<%@ page import="dao.UserDAO" %>
<%@ page import="dto.UserDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phòng - Đặt Homestay</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #4a704a 0%, #d4e4bc 50%, #f7e7ce 100%);
            color: #fff; /* Màu chữ trắng chủ đạo */
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            overflow-x: hidden;
        }

        .header-container, .footer-container {
            width: 100%;
            z-index: 1000;
        }

        .main-content {
            flex: 1;
            padding: 80px 0 80px;
            max-width: 1200px;
            margin: 0 auto;
            width: 90%;
            position: relative;
        }

        .room-layout {
            display: flex;
            flex-wrap: wrap;
            width: 100%;
            margin-bottom: 30px;
            align-items: flex-start;
            gap: 20px;
        }

        .room-gallery-section {
            width: 350px;
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .room-gallery-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
        }

        .room-gallery {
            position: relative;
        }

        .room-gallery img {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 15px 15px 0 0;
            display: none;
            transition: opacity 0.5s ease-in-out;
        }

        .room-gallery img.active {
            display: block;
        }

        .prev, .next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            background: rgba(0, 0, 0, 0.6);
            color: white;
            border: none;
            padding: 12px 18px;
            cursor: pointer;
            border-radius: 50%;
            font-size: 24px;
            transition: background 0.3s ease, transform 0.3s ease;
        }

        .prev:hover, .next:hover {
            background: linear-gradient(45deg, #f4a261, #e9c46a); /* Gradient cam-vàng */
            transform: translateY(-50%) scale(1.1);
        }

        .prev { left: 20px; }
        .next { right: 20px; }

        .scrollable-content {
            flex: 1;
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            max-height: 600px;
            overflow-y: auto;
            transition: box-shadow 0.3s ease;
        }

        .scrollable-content:hover {
            box-shadow: 0 12px 30px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
        }

        .room-info-section h2 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
            color: #4a704a; /* Xanh lá đậm */
            line-height: 1.2;
            border-bottom: 2px solid #f4a261; /* Viền cam nhạt */
            padding-bottom: 5px;
            display: inline-block;
        }

        .room-info-section p {
            font-size: 16px;
            margin-bottom: 20px;
            line-height: 1.6;
            color: #555; /* Xám đậm */
        }

        .room-info-section strong {
            color: #f4a261; /* Cam nhạt cho điểm nhấn */
        }

        .room-amenities, .room-reviews {
            margin-top: 30px;
        }

        .room-amenities h3, .room-reviews h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #4a704a; /* Xanh lá đậm */
            border-bottom: 2px solid #f4a261; /* Viền cam nhạt */
            padding-bottom: 5px;
            display: inline-block;
        }

        .amenities-list {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }

        .amenity-item {
            display: flex;
            align-items: center;
            gap: 10px;
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            padding: 12px 15px;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease, background 0.3s ease;
        }

        .amenity-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
            background: #fff; /* Trắng hoàn toàn khi hover */
        }

        .amenity-item i {
            font-size: 22px;
            color: #f4a261; /* Cam nhạt cho biểu tượng */
        }

        .amenity-item p {
            margin: 0;
            font-size: 15px;
            font-weight: 500;
            color: #4a704a; /* Xanh lá đậm */
        }

        .review-form {
            margin-top: 20px;
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .review-form h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #4a704a; /* Xanh lá đậm */
        }

        .rating-stars {
            display: flex;
            gap: 5px;
            margin-bottom: 15px;
        }

        .rating-stars .star {
            font-size: 24px;
            color: #ccc;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .rating-stars .star.active {
            color: #f4a261; /* Cam nhạt cho ngôi sao */
        }

        .review-form textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 15px;
            margin-bottom: 15px;
            resize: vertical;
            transition: border-color 0.3s ease;
        }

        .review-form textarea:focus {
            border-color: #f4a261; /* Viền cam nhạt khi focus */
            outline: none;
        }

        .review-form button {
            padding: 12px 25px;
            background: linear-gradient(45deg, #f4a261, #e9c46a); /* Gradient cam-vàng */
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        }

        .review-form button:hover {
            background: linear-gradient(45deg, #e9c46a, #f4a261);
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(244, 162, 97, 0.6);
        }

        .review-list .review-item {
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .review-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
        }

        .review-item p {
            margin: 5px 0;
            font-size: 15px;
            color: #555; /* Xám đậm */
        }

        .review-item .rating {
            color: #f4a261; /* Cam nhạt cho đánh giá */
            font-size: 16px;
            font-weight: 600;
        }

        .action-info-section {
            width: 300px;
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            padding: 25px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .action-info-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
        }

        .action-info-section .price {
            font-size: 28px;
            font-weight: 700;
            color: #f4a261; /* Cam nhạt cho giá */
            margin-bottom: 20px;
            text-align: center;
        }

        .action-info-section .rating {
            font-size: 16px;
            color: #4a704a; /* Xanh lá đậm */
            margin-bottom: 20px;
            text-align: center;
        }

        .action-info-section .rating .stars {
            color: #f4a261; /* Cam nhạt cho ngôi sao */
            margin-left: 5px;
        }

        .btn-book {
            display: block;
            padding: 14px 0;
            background: linear-gradient(45deg, #f4a261, #e9c46a); /* Gradient cam-vàng */
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            text-align: center;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 15px rgba(244, 162, 97, 0.4);
            margin-bottom: 25px;
        }

        .btn-book:hover {
            background: linear-gradient(45deg, #e9c46a, #f4a261);
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(244, 162, 97, 0.6);
        }

        .contact-info {
            text-align: left;
            font-size: 15px;
            color: #555; /* Xám đậm */
        }

        .contact-info h4 {
            font-size: 18px;
            font-weight: 600;
            color: #4a704a; /* Xanh lá đậm */
            margin-bottom: 15px;
            border-bottom: 2px solid #f4a261; /* Viền cam nhạt */
            padding-bottom: 5px;
            display: inline-block;
        }

        .contact-info p {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .contact-info i {
            color: #f4a261; /* Cam nhạt cho biểu tượng */
            font-size: 18px;
        }

        .btn-contact {
            display: block;
            padding: 12px 0;
            background: linear-gradient(45deg, #f4a261, #e9c46a); /* Gradient cam-vàng */
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 15px rgba(244, 162, 97, 0.4);
            margin-bottom: 10px;
        }

        .btn-contact:hover {
            background: linear-gradient(45deg, #e9c46a, #f4a261);
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(244, 162, 97, 0.6);
        }

        .room-location {
            width: 100%;
            margin-top: 30px;
            background: rgba(255, 255, 255, 0.9); /* Nền trắng nhạt */
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
            padding: 30px;
            transition: box-shadow 0.3s ease;
        }

        .room-location:hover {
            box-shadow: 0 12px 30px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
        }

        .room-location h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #4a704a; /* Xanh lá đậm */
            border-bottom: 2px solid #f4a261; /* Viền cam nhạt */
            padding-bottom: 5px;
            display: inline-block;
        }

        .room-location p {
            font-size: 16px;
            color: #555; /* Xám đậm */
            margin-bottom: 20px;
        }

        .room-location iframe {
            width: 100%;
            height: 350px;
            border: 0;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            transition: box-shadow 0.3s ease;
        }

        .room-location iframe:hover {
            box-shadow: 0 6px 20px rgba(244, 162, 97, 0.3); /* Bóng cam nhạt */
        }

        @media (max-width: 1024px) {
            .room-layout {
                flex-direction: column;
                gap: 15px;
            }

            .room-gallery-section, .scrollable-content, .action-info-section {
                width: 100%;
                margin-right: 0;
                margin-bottom: 0;
            }

            .scrollable-content {
                max-height: none;
                overflow-y: visible;
            }

            .room-gallery img {
                height: 300px;
            }
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 60px 0 70px;
                width: 100%;
            }

            .room-info-section h2 {
                font-size: 28px;
            }

            .room-amenities h3, .room-reviews h3, .room-location h3 {
                font-size: 22px;
            }
        }
    </style>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</head>
<body>
    <div class="header-container">
        <%@include file="header.jsp" %>
    </div>

    <div class="main-content">
        <%
            RoomDTO room = (RoomDTO) request.getAttribute("room");
            if (room == null) {
        %>
        <div style="text-align: center; margin-top: 50px;">
            <h2 style="font-size: 28px; color: #4a704a;">Không tìm thấy thông tin phòng!</h2>
            <a href="home.jsp" class="btn-book" style="background: linear-gradient(45deg, #f4a261, #e9c46a); padding: 12px 25px; font-size: 18px;">Quay lại trang chủ</a>
        </div>
        <%
        } else {
        %>

        <div class="room-layout">
            <!-- Phần 1: Gallery (Bên trái) -->
            <div class="room-gallery-section">
                <div class="room-gallery">
                    <%
                        List<String> detailImages = room.getDetailImages();
                        if (detailImages == null || detailImages.isEmpty()) {
                            detailImages = new java.util.ArrayList<String>();
                            detailImages.add(room.getImageUrl());
                        } else if (!detailImages.contains(room.getImageUrl())) {
                            detailImages.add(0, room.getImageUrl());
                        }
                        for (int i = 0; i < detailImages.size(); i++) {
                            String imageUrl = detailImages.get(i);
                            String activeClass = (i == 0) ? "active" : "";
                    %>
                    <img src="<%= imageUrl%>" alt="<%= room.getName()%>" class="<%= activeClass%>">
                    <%
                        }
                    %>
                    <button class="prev" onclick="changeImage(-1)">❮</button>
                    <button class="next" onclick="changeImage(1)">❯</button>
                </div>
            </div>

            <!-- Phần giữa: Thông tin chi tiết (Có thể cuộn) -->
            <div class="scrollable-content">
                <div class="room-info-section">
                    <h2><%= room.getName()%></h2>
                    <p><%= room.getDescription() != null ? room.getDescription() : "Chưa có mô tả"%></p>
                    <p><strong>Giá:</strong> <%= String.format("%,.0f", room.getPrice())%>đ / đêm</p>
                    <p><strong>Tiện nghi:</strong> <%= room.getAmenities() != null ? room.getAmenities() : "Không có thông tin"%></p>
                    <p><strong>Đánh giá:</strong> <%= room.getRatings()%> ⭐</p>

                    <!-- Amenities -->
                    <div class="room-amenities">
                        <h3>Tiện ích</h3>
                        <div class="amenities-list">
                            <div class="amenity-item"><i class="fas fa-wifi"></i><p>Wifi miễn phí</p></div>
                            <div class="amenity-item"><i class="fas fa-swimming-pool"></i><p>Hồ bơi</p></div>
                            <div class="amenity-item"><i class="fas fa-parking"></i><p>Bãi đỗ xe</p></div>
                            <div class="amenity-item"><i class="fas fa-utensils"></i><p>Nhiều tiện ích xung quanh</p></div>
                        </div>
                    </div>

                    <!-- Reviews -->
                    <div class="room-reviews">
                        <h3>Đánh giá</h3>
                        <% if (user != null) {%>
                        <div class="review-form">
                            <h4>Viết đánh giá của bạn</h4>
                            <form action="submit-review" method="post">
                                <input type="hidden" name="roomId" value="<%= room.getId()%>">
                                <div class="rating-stars">
                                    <span class="star" data-value="1">★</span>
                                    <span class="star" data-value="2">★</span>
                                    <span class="star" data-value="3">★</span>
                                    <span class="star" data-value="4">★</span>
                                    <span class="star" data-value="5">★</span>
                                </div>
                                <input type="hidden" name="rating" id="rating-value" value="0">
                                <textarea name="comment" placeholder="Nhập bình luận của bạn..." rows="4" required></textarea>
                                <button type="submit">Gửi đánh giá</button>
                            </form>
                        </div>
                        <% } else { %>
                        <p>Vui lòng <a href="login-regis.jsp">đăng nhập</a> để viết đánh giá.</p>
                        <% } %>

                        <div class="review-list">
                            <%
                                ReviewDAO reviewDAO = new ReviewDAO();
                                UserDAO userDAO = new UserDAO();
                                List<ReviewDTO> reviews = reviewDAO.getReviewsByRoomId(room.getId());
                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                if (reviews != null && !reviews.isEmpty()) {
                                    for (ReviewDTO review : reviews) {
                                        UserDTO reviewer = userDAO.readById(review.getUserId());
                                        String reviewerName = reviewer != null ? reviewer.getFullName() : review.getUserId();
                                        StringBuilder stars = new StringBuilder();
                                        int rating = (int) review.getRating();
                                        for (int i = 0; i < rating; i++) {
                                            stars.append("⭐");
                                        }
                            %>
                            <div class="review-item">
                                <p><strong><%= reviewerName%>:</strong></p>
                                <p class="rating"><%= stars.toString()%></p>
                                <p><%= review.getComment()%></p>
                                <p><small><%= sdf.format(review.getCreatedAt())%></small></p>
                            </div>
                            <%
                                }
                            } else {
                            %>
                            <p>Chưa có đánh giá nào cho phòng này.</p>
                            <%
                                }
                            %>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Phần 3: Hành động (Bên phải) -->
            <div class="action-info-section">
                <div class="price"><%= String.format("%,.0f", room.getPrice())%>đ</div>
                <div class="rating">
                    Đánh giá: <%= room.getRatings()%> <span class="stars">⭐</span> (<%= room.getRatings()%>/5)
                </div>
                <a href="booking.jsp?roomId=<%= room.getId()%>" class="btn-book">Đặt ngay</a>
                <div class="contact-info">
                    <h4>Liên hệ nhanh</h4>
                    <p><i class="fas fa-phone-alt"></i> 0909 123 456</p>
                    <p><i class="fas fa-envelope"></i> homestay@example.com</p>
                    <a href="https://facebook.com/yourpage" target="_blank" class="btn-contact" style="background: linear-gradient(45deg, #1877F2, #3B5998);">
                        <i class="fab fa-facebook-f"></i> Liên hệ qua Facebook
                    </a>
                    <a href="https://instagram.com/yourpage" target="_blank" class="btn-contact" style="background: linear-gradient(45deg, #C13584, #E1306C, #F77737);">
                        <i class="fab fa-instagram"></i> Liên hệ qua Instagram
                    </a>
                    <a href="https://zalo.me/0909123456" target="_blank" class="btn-contact" style="background: linear-gradient(45deg, #00A2FF, #0078D4);">
                        <i class="fas fa-comment-dots"></i> Liên hệ qua Zalo
                    </a>
                </div>
            </div>
        </div>

        <!-- Phần bản đồ (Nằm dưới cùng) -->
        <div class="room-location">
            <h3>Vị trí</h3>
            <p><strong>Địa chỉ:</strong> S702 Vinhome Grand Park, Quận 9</p>
            <iframe src="https://maps.google.com/maps?width=100%25&height=600&hl=en&q=S702%20Vinhomes%20GrandPark,%20Qu%E1%BA%ADn%209+(HomeStay)&t=&z=14&ie=UTF8&iwloc=B&output=embed" allowfullscreen="" loading="lazy"></iframe>
        </div>
        <%
            }
        %>
    </div>

    <div class="footer-container">
        <%@include file="footer.jsp" %>
    </div>

    <script>
        var currentIndex = 0;
        var images = document.querySelectorAll('.room-gallery img');
        function showImage(index) {
            images.forEach(function (img, i) {
                img.classList.remove('active');
                if (i === index)
                    img.classList.add('active');
            });
        }
        function changeImage(direction) {
            currentIndex += direction;
            if (currentIndex < 0)
                currentIndex = images.length - 1;
            else if (currentIndex >= images.length)
                currentIndex = 0;
            showImage(currentIndex);
        }
        showImage(currentIndex);

        // Rating Stars
        var stars = document.querySelectorAll('.rating-stars .star');
        var ratingInput = document.getElementById('rating-value');
        stars.forEach(function (star) {
            star.addEventListener('click', function () {
                var value = star.getAttribute('data-value');
                ratingInput.value = value;
                stars.forEach(function (s) {
                    s.classList.remove('active');
                    if (s.getAttribute('data-value') <= value)
                        s.classList.add('active');
                });
            });
        });
    </script>
</body>
</html>