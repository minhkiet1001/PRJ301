<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="dto.RoomDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết phòng</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Arial, sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            color: #333;
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

        /* Phần Gallery */
        .room-gallery-section {
            width: 350px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            transition: transform 0.3s ease;
        }

        .room-gallery-section:hover {
            transform: translateY(-5px);
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
            background: rgba(0, 0, 0, 0.9);
            transform: translateY(-50%) scale(1.1);
        }

        .prev { left: 20px; }
        .next { right: 20px; }

        /* Phần giữa (Thông tin chi tiết) */
        .scrollable-content {
            flex: 1;
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            max-height: 600px;
            overflow-y: auto;
            transition: box-shadow 0.3s ease;
        }

        .scrollable-content:hover {
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .room-info-section h2 {
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 15px;
            color: #2c3e50;
            line-height: 1.2;
        }

        .room-info-section p {
            font-size: 16px;
            margin-bottom: 20px;
            line-height: 1.6;
            color: #666;
        }

        .room-amenities, .room-reviews {
            margin-top: 30px;
        }

        .room-amenities h3, .room-reviews h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2c3e50;
            border-bottom: 2px solid #5DC1B9;
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
            background: #f8f9fa;
            padding: 12px 15px;
            border-radius: 10px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .amenity-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .amenity-item i {
            font-size: 22px;
            color: #5DC1B9;
        }

        .amenity-item p {
            margin: 0;
            font-size: 15px;
            font-weight: 500;
            color: #333;
        }

        /* Phần đánh giá */
        .review-form {
            margin-top: 20px;
            background: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .review-form h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2c3e50;
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
            color: #ffcc00;
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
            border-color: #5DC1B9;
            outline: none;
        }

        .review-form button {
            padding: 12px 25px;
            background: linear-gradient(45deg, #5DC1B9, #4ECDC4);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
        }

        .review-form button:hover {
            background: linear-gradient(45deg, #4ECDC4, #45b7d1);
            transform: scale(1.05);
            box-shadow: 0 6px 15px rgba(93, 193, 185, 0.6);
        }

        .review-list .review-item {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .review-item:hover {
            transform: translateY(-3px);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .review-item p {
            margin: 5px 0;
            font-size: 15px;
            color: #555;
        }

        .review-item .rating {
            color: #ffcc00;
            font-size: 16px;
            font-weight: 600;
        }

        /* Phần hành động */
        .action-info-section {
            width: 300px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            padding: 25px;
            transition: transform 0.3s ease;
        }

        .action-info-section:hover {
            transform: translateY(-5px);
        }

        .action-info-section .price {
            font-size: 28px;
            font-weight: 700;
            color: #e74c3c;
            margin-bottom: 20px;
            text-align: center;
        }

        .action-info-section .rating {
            font-size: 16px;
            color: #2c3e50;
            margin-bottom: 20px;
            text-align: center;
        }

        .action-info-section .rating .stars {
            color: #ffcc00;
            margin-left: 5px;
        }

        .btn-book {
            display: block;
            padding: 14px 0;
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            text-align: center;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 15px rgba(231, 76, 60, 0.4);
            margin-bottom: 25px;
        }

        .btn-book:hover {
            background: linear-gradient(45deg, #c0392b, #a93226);
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(231, 76, 60, 0.6);
        }

        /* Thêm phần thông tin liên hệ nhanh */
        .contact-info {
            text-align: left;
            font-size: 15px;
            color: #666;
        }

        .contact-info h4 {
            font-size: 18px;
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 15px;
            border-bottom: 2px solid #5DC1B9;
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
            color: #5DC1B9;
            font-size: 18px;
        }

        .btn-contact {
            display: block;
            padding: 12px 0;
            background: linear-gradient(45deg, #5DC1B9, #4ECDC4);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-align: center;
            transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
            box-shadow: 0 4px 15px rgba(93, 193, 185, 0.4);
            margin-bottom: 10px;
        }

        .btn-contact:hover {
            background: linear-gradient(45deg, #4ECDC4, #45b7d1);
            transform: scale(1.05);
            box-shadow: 0 6px 20px rgba(93, 193, 185, 0.6);
            
        }

        /* Phần bản đồ */
        .room-location {
            width: 100%;
            margin-top: 30px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            padding: 30px;
            transition: box-shadow 0.3s ease;
        }

        .room-location:hover {
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .room-location h3 {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
            color: #2c3e50;
            border-bottom: 2px solid #5DC1B9;
            padding-bottom: 5px;
            display: inline-block;
        }

        .room-location p {
            font-size: 16px;
            color: #666;
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
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.15);
        }

        /* Responsive Design */
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
            <h2 style="font-size: 28px; color: #2c3e50;">Không tìm thấy thông tin phòng!</h2>
            <a href="home.jsp" class="btn-book" style="background: linear-gradient(45deg, #5DC1B9, #4ECDC4); padding: 12px 25px; font-size: 18px;">Quay lại trang chủ</a>
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
                            detailImages = new java.util.ArrayList<>();
                            detailImages.add(room.getImageUrl());
                        } else if (!detailImages.contains(room.getImageUrl())) {
                            detailImages.add(0, room.getImageUrl());
                        }
                        for (int i = 0; i < detailImages.size(); i++) {
                            String imageUrl = detailImages.get(i);
                            String activeClass = (i == 0) ? "active" : "";
                    %>
                    <img src="<%= imageUrl %>" alt="<%= room.getName() %>" class="<%= activeClass %>">
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
                    <h2><%= room.getName() %></h2>
                    <p><%= room.getDescription() != null ? room.getDescription() : "Chưa có mô tả" %></p>

                    <!-- Amenities -->
                    <div class="room-amenities">
                        <h3>Tiện ích</h3>
                        <div class="amenities-list">
                            <div class="amenity-item">
                                <i class="fas fa-wifi"></i>
                                <p>Wifi miễn phí</p>
                            </div>
                            <div class="amenity-item">
                                <i class="fas fa-swimming-pool"></i>
                                <p>Hồ bơi</p>
                            </div>
                            <div class="amenity-item">
                                <i class="fas fa-parking"></i>
                                <p>Bãi đỗ xe</p>
                            </div>
                            <div class="amenity-item">
                                <i class="fas fa-utensils"></i>
                                <p>Nhiều tiện ích xung quanh</p>
                            </div>
                        </div>
                    </div>

                    <!-- Reviews -->
                    <div class="room-reviews">
                        <h3>Đánh giá</h3>
                        <div class="review-form">
                            <h4>Viết đánh giá của bạn</h4>
                            <div class="rating-stars">
                                <span class="star" data-value="1">★</span>
                                <span class="star" data-value="2">★</span>
                                <span class="star" data-value="3">★</span>
                                <span class="star" data-value="4">★</span>
                                <span class="star" data-value="5">★</span>
                            </div>
                            <textarea placeholder="Nhập bình luận của bạn..." rows="4"></textarea>
                            <button type="button">Gửi đánh giá</button>
                        </div>
                        <div class="review-list">
                            <div class="review-item">
                                <p><strong>Nguyễn Văn A:</strong></p>
                                <p class="rating">⭐⭐⭐⭐⭐</p>
                                <p>Phòng rất đẹp, view tuyệt vời, dịch vụ tốt!</p>
                            </div>
                            <div class="review-item">
                                <p><strong>Trần Thị B:</strong></p>
                                <p class="rating">⭐⭐⭐⭐</p>
                                <p>Phòng sạch sẽ, giá cả hợp lý.</p>
                            </div>
                            <div class="review-item">
                                <p><strong>Lê Văn C:</strong></p>
                                <p class="rating">⭐⭐⭐</p>
                                <p>Dịch vụ tốt, nhưng giá hơi cao so với mong đợi.</p>
                            </div>
                            <div class="review-item">
                                <p><strong>Phạm Thị D:</strong></p>
                                <p class="rating">⭐⭐⭐⭐⭐</p>
                                <p>Rất hài lòng, sẽ quay lại lần nữa!</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Phần 3: Hành động (Bên phải) -->
            <div class="action-info-section">
                <div class="price"><%= String.format("%,.0f", room.getPrice()) %>đ</div>
                <div class="rating">
                    Đánh giá: <%= room.getRatings() %> <span class="stars">⭐</span> (<%= room.getRatings() %>/5)
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
            <iframe
                src="https://maps.google.com/maps?width=100%25&height=600&hl=en&q=S702%20Vinhomes%20GrandPark,%20Qu%E1%BA%ADn%209+(HomeStay)&t=&z=14&ie=UTF8&iwloc=B&output=embed"
                allowfullscreen=""
                loading="lazy">
            </iframe>
        </div>
        <%
            }
        %>
    </div>

    <div class="footer-container">
        <%@include file="footer.jsp" %>
    </div>

    <!-- JavaScript để điều khiển slideshow -->
    <script>
        let currentIndex = 0;
        const images = document.querySelectorAll('.room-gallery img');

        function showImage(index) {
            images.forEach((img, i) => {
                img.classList.remove('active');
                if (i === index) {
                    img.classList.add('active');
                }
            });
        }

        function changeImage(direction) {
            currentIndex += direction;
            if (currentIndex < 0) {
                currentIndex = images.length - 1;
            } else if (currentIndex >= images.length) {
                currentIndex = 0;
            }
            showImage(currentIndex);
        }

        showImage(currentIndex);
    </script>
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>
</body>
</html>