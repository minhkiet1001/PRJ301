<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Liên hệ - Homestay</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <style>
            /* Reset toàn cục */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
                scroll-behavior: smooth;
                font-family: 'Segoe UI', Arial, sans-serif;
            }

            body {
                background: linear-gradient(120deg, #e0f7fa, #d4f1f4, #fff9e6, #d4f1f4, #e0f7fa); /* Gradient nhẹ nhàng, đồng bộ với header và footer */
                background-size: 400% 400%;
                animation: gradientBG 20s ease infinite;
                color: #2c3e50;
                display: flex;
                flex-direction: column;
                min-height: 100vh;
            }

            @keyframes gradientBG {
                0% { background-position: 0% 50%; }
                50% { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            /* Header cải tiến */
            header {
                position: fixed;
                top: 0;
                width: 100%;
                background: linear-gradient(45deg, #5DC1B9, #F7DC6F); /* Đồng bộ với header.jsp */
                backdrop-filter: blur(10px);
                z-index: 1000;
                padding: 15px 0;
                box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
                transition: all 0.4s ease;
            }

            /* Container chính với thiết kế card */
            .contact-container {
                width: 90%;
                max-width: 1400px;
                margin: 100px auto 40px;
                display: grid;
                grid-template-columns: repeat(12, 1fr);
                grid-gap: 25px;
                padding: 0;
            }

            /* Hero section */
            .contact-hero {
                grid-column: span 12;
                background: linear-gradient(135deg, rgba(255,255,255,0.8), rgba(255,255,255,0.4));
                backdrop-filter: blur(10px);
                border-radius: 20px;
                padding: 40px;
                text-align: center;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                margin-bottom: 20px;
                border-left: 5px solid #5DC1B9;
                border-right: 5px solid #5DC1B9;
                position: relative;
                overflow: hidden;
            }

            .contact-hero::before {
                content: '';
                position: absolute;
                top: -50%;
                left: -50%;
                width: 200%;
                height: 200%;
                background: radial-gradient(circle, rgba(93, 193, 185, 0.1) 0%, transparent 70%);
                animation: rotateGlow 15s linear infinite;
                z-index: 0;
            }

            @keyframes rotateGlow {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }

            .contact-hero h2 {
                font-size: 2.5rem;
                margin-bottom: 20px;
                color: #2c3e50;
                position: relative;
                z-index: 1;
                text-transform: uppercase;
                letter-spacing: 2px;
            }

            .contact-hero p {
                font-size: 1.2rem;
                color: #555;
                max-width: 800px;
                margin: 0 auto;
                position: relative;
                z-index: 1;
            }

            /* Thông báo thành công */
            .success-message {
                grid-column: span 12;
                color: #5DC1B9;
                text-align: center;
                padding: 20px;
                background: rgba(224, 247, 250, 0.8);
                backdrop-filter: blur(5px);
                border-radius: 15px;
                margin-bottom: 20px;
                box-shadow: 0 5px 15px rgba(93, 193, 185, 0.2);
                border-left: 4px solid #5DC1B9;
                transform: translateY(0);
                animation: bounce 1s ease;
            }

            @keyframes bounce {
                0%, 20%, 50%, 80%, 100% {transform: translateY(0);}
                40% {transform: translateY(-20px);}
                60% {transform: translateY(-10px);}
            }

            /* Card design cho tất cả các section */
            .card {
                background: rgba(255, 255, 255, 0.8);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
                padding: 30px;
                transition: all 0.4s ease;
                position: relative;
                overflow: hidden;
                border-top: 4px solid transparent;
            }

            .card:hover {
                transform: translateY(-15px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
                border-top: 4px solid #5DC1B9;
            }

            .card::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.2), transparent);
                transform: translateX(-100%);
                transition: 0.7s;
            }

            .card:hover::before {
                transform: translateX(100%);
            }

            .card h3 {
                color: #2c3e50;
                font-size: 1.5rem;
                margin-bottom: 25px;
                display: flex;
                align-items: center;
                position: relative;
            }

            .card h3::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 0;
                width: 50px;
                height: 3px;
                background: #5DC1B9;
                transition: width 0.4s ease;
            }

            .card:hover h3::after {
                width: 100px;
            }

            .card h3 i {
                margin-right: 12px;
                background: #e0f7fa;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                color: #5DC1B9;
                font-size: 1.2rem;
                transition: all 0.3s ease;
            }

            .card:hover h3 i {
                background: #5DC1B9;
                color: white;
                transform: rotate(360deg);
            }

            /* Layout cụ thể cho từng phần */
            .contact-info {
                grid-column: span 6;
            }

            .contact-form {
                grid-column: span 6;
            }

            .map {
                grid-column: span 12;
            }
            
            .faq {
                grid-column: span 6;
            }

            .social-links {
                grid-column: span 6;
            }

            /* Thông tin liên hệ */
            .contact-info-list {
                list-style: none;
            }

            .contact-info-list li {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
                padding-bottom: 15px;
                border-bottom: 1px dashed rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .contact-info-list li:last-child {
                border-bottom: none;
            }

            .contact-info-list li:hover {
                transform: translateX(10px);
            }

            .contact-info-list i {
                background: #e0f7fa;
                color: #5DC1B9;
                border-radius: 50%;
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                margin-right: 15px;
                font-size: 1rem;
                transition: all 0.3s ease;
            }

            .contact-info-list li:hover i {
                background: #5DC1B9;
                color: white;
                transform: scale(1.2);
            }

            .contact-info-content {
                flex: 1;
            }

            .contact-info-content strong {
                display: block;
                color: #2c3e50;
                font-size: 1.1rem;
                margin-bottom: 5px;
            }

            .contact-info-content span {
                color: #7f8c8d;
                font-size: 0.95rem;
            }

            /* Form liên hệ */
            .form-group {
                margin-bottom: 20px;
                position: relative;
            }

            .form-control {
                width: 100%;
                padding: 15px 20px;
                font-size: 16px;
                background: rgba(255, 255, 255, 0.9);
                border: none;
                border-radius: 10px;
                box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
                transition: all 0.3s ease;
            }

            .form-control:focus {
                box-shadow: inset 0 2px 5px rgba(93, 193, 185, 0.2), 0 0 0 3px rgba(93, 193, 185, 0.1);
                outline: none;
            }

            textarea.form-control {
                min-height: 150px;
                resize: vertical;
            }

            .form-label {
                position: absolute;
                top: 15px;
                left: 20px;
                color: #95a5a6;
                transition: all 0.3s ease;
                pointer-events: none;
            }

            .form-control:focus + .form-label,
            .form-control:not(:placeholder-shown) + .form-label {
                transform: translateY(-25px) scale(0.8);
                color: #5DC1B9;
                font-weight: 500;
            }

            .btn-submit {
                background: linear-gradient(45deg, #5DC1B9, #4ECDC4);
                color: white;
                border: none;
                padding: 15px 30px;
                font-size: 16px;
                border-radius: 30px;
                cursor: pointer;
                display: inline-block;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-weight: 600;
                box-shadow: 0 4px 10px rgba(93, 193, 185, 0.3);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .btn-submit:hover {
                background: linear-gradient(45deg, #4ECDC4, #45B7AA);
                box-shadow: 0 6px 15px rgba(93, 193, 185, 0.4);
                transform: translateY(-3px);
            }

            .btn-submit::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(120deg, transparent, rgba(255, 255, 255, 0.3), transparent);
                transform: translateX(-100%);
                transition: 0.6s;
            }

            .btn-submit:hover::before {
                transform: translateX(100%);
            }

            /* Map style */
            .map-wrapper {
                position: relative;
                overflow: hidden;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                padding: 0;
                height: 400px;
            }

            .map-wrapper iframe {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                border: none;
            }

            /* Social links */
            .social-media {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 20px;
                margin-top: 20px;
            }

            .social-item {
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 80px;
                height: 80px;
                border-radius: 50%;
                background: white;
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
                transition: all 0.4s ease;
                text-decoration: none;
            }

            .social-item img {
                width: 40px;
                height: 40px;
                object-fit: contain;
                transition: all 0.4s ease;
            }

            .social-item::before {
                content: '';
                position: absolute;
                inset: 0;
                border-radius: 50%;
                padding: 3px;
                background: linear-gradient(45deg, #5DC1B9, #F7DC6F);
                -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
                -webkit-mask-composite: xor;
                mask-composite: exclude;
                opacity: 0;
                transition: all 0.4s ease;
            }

            .social-item:hover {
                transform: translateY(-10px) scale(1.1);
            }

            .social-item:hover::before {
                opacity: 1;
            }

            .social-item:hover img {
                transform: scale(1.2);
            }

            /* FAQ */
            .faq-item {
                margin-bottom: 20px;
                border-bottom: 1px dashed rgba(0, 0, 0, 0.1);
                padding-bottom: 15px;
                transition: all 0.3s ease;
            }

            .faq-item:last-child {
                border-bottom: none;
                margin-bottom: 0;
            }

            .faq-question {
                font-weight: 600;
                color: #2c3e50;
                font-size: 1.1rem;
                margin-bottom: 10px;
                display: flex;
                align-items: center;
            }

            .faq-question i {
                color: #5DC1B9;
                margin-right: 10px;
                font-size: 0.9rem;
            }

            .faq-answer {
                color: #7f8c8d;
                line-height: 1.6;
                padding-left: 25px;
            }

            /* Back to top button */
            .back-to-top {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 50px;
                height: 50px;
                background: #5DC1B9;
                color: white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 20px;
                cursor: pointer;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                opacity: 0;
                visibility: hidden;
                transition: all 0.4s ease;
                transform: translateY(20px);
                border: none;
            }

            .back-to-top.visible {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .back-to-top:hover {
                background: #4ECDC4;
                transform: translateY(-5px);
            }

            /* Footer */
            footer {
                background: linear-gradient(to right, #5DC1B9, #4ECDC4);
                padding: 30px 0;
                color: white;
                text-align: center;
                position: relative;
                overflow: hidden;
                margin-top: auto;
            }

            footer::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: url("data:image/svg+xml,%3Csvg width='100' height='20' viewBox='0 0 100 20' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath d='M21.184 20c.357-.13.72-.264.888-.14 1.005-.174 1.837-.425 2.403-.73 1.55-.838 1.074-1.91.75-2.797 1.116-.264 1.736-.882 1.414-1.384-.75-1.42-1.784-2.634-2.852-3.585 1.697-.385 2.25-1.738 1.462-2.502-2.214-2.138-5.624-3.78-8.912-3.487-1.854.158-3.413.986-4.7 2.458-1.003 1.15-1.817 2.62-2.096 3.99-.34 1.668.304 2.867 1.432 3.084-.65.783-1.106 1.717-1.37 2.754-.576 2.237-.29 4.83 1.28 6.394.538.533 1.26.935 2.133 1.176.973.27 2.096.356 3.364.276 1.507-.095 3.02-.322 4.524-.676 1.73-.407 3.392-.93 5.13-1.57.36-.135.705-.273 1.04-.415z' fill='%23ffffff' fill-opacity='0.1' fill-rule='evenodd'/%3E%3C/svg%3E");
            }

            footer a {
                color: white;
                margin: 0 15px;
                text-decoration: none;
                position: relative;
                transition: all 0.3s ease;
            }

            footer a::after {
                content: '';
                position: absolute;
                bottom: -5px;
                left: 0;
                width: 0;
                height: 2px;
                background: white;
                transition: width 0.3s ease;
            }

            footer a:hover::after {
                width: 100%;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .contact-container {
                    grid-template-columns: repeat(6, 1fr);
                    width: 95%;
                }
                
                .contact-hero {
                    grid-column: span 6;
                }
                
                .contact-info, .contact-form, .map, .social-links, .faq {
                    grid-column: span 6;
                }

                .contact-hero h2 {
                    font-size: 2rem;
                }
            }

            @media (max-width: 768px) {
                .contact-hero {
                    padding: 30px 20px;
                }
                
                .contact-hero h2 {
                    font-size: 1.8rem;
                }
                
                .card {
                    padding: 25px 20px;
                }
                
                .social-media {
                    gap: 15px;
                }
                
                .social-item {
                    width: 70px;
                    height: 70px;
                }
                
                .social-item img {
                    width: 35px;
                    height: 35px;
                }
                
                .back-to-top {
                    bottom: 20px;
                    right: 20px;
                    width: 45px;
                    height: 45px;
                }
            }

            @media (max-width: 576px) {
                .contact-container {
                    width: 92%;
                    margin-top: 80px;
                }
                
                .contact-hero {
                    padding: 25px 15px;
                }
                
                .contact-hero h2 {
                    font-size: 1.5rem;
                }
                
                .card {
                    padding: 20px 15px;
                }
                
                .btn-submit {
                    width: 100%;
                }
                
                .social-media {
                    gap: 10px;
                }
                
                .social-item {
                    width: 60px;
                    height: 60px;
                }
                
                .social-item img {
                    width: 30px;
                    height: 30px;
                }
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>

        <div class="contact-container">
            <!-- Hero Section -->
            <div class="contact-hero animate__animated animate__fadeInDown">
                <h2><i class="fas fa-paper-plane"></i> Liên Hệ Với Chúng Tôi</h2>
                <p>Chúng tôi luôn sẵn sàng lắng nghe và hỗ trợ bạn 24/7. Đừng ngần ngại liên hệ với chúng tôi qua các phương thức bên dưới.</p>
            </div>

            <%
                String message = (String) session.getAttribute("message");
                if (message != null) {
            %>
            <div class="success-message animate__animated animate__bounceIn">
                <i class="fas fa-check-circle" style="margin-right: 10px; font-size: 1.2rem;"></i> <%= message %>
            </div>
            <%
                    session.removeAttribute("message"); // Xóa thông báo sau khi hiển thị
                }
            %>

            <!-- Thông tin liên hệ -->
            <div class="card contact-info animate__animated animate__fadeInLeft">
                <h3><i class="fas fa-info-circle"></i> Thông Tin Liên Hệ</h3>
                <ul class="contact-info-list">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <div class="contact-info-content">
                            <strong>Địa chỉ</strong>
                            <span>123 Đường ABC, Quận XYZ, TP. Hồ Chí Minh</span>
                        </div>
                    </li>
                    <li>
                        <i class="fas fa-phone-alt"></i>
                        <div class="contact-info-content">
                            <strong>Điện thoại</strong>
                            <span>0901 234 567</span>
                        </div>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <div class="contact-info-content">
                            <strong>Email</strong>
                            <span>contact@homestay.com</span>
                        </div>
                    </li>
                    <li>
                        <i class="fas fa-clock"></i>
                        <div class="contact-info-content">
                            <strong>Giờ làm việc</strong>
                            <span>08:00 - 22:00 (Hằng ngày)</span>
                        </div>
                    </li>
                </ul>
            </div>

            <!-- Form liên hệ -->
            <div class="card contact-form animate__animated animate__fadeInRight">
                <h3><i class="fas fa-envelope-open-text"></i> Gửi Tin Nhắn</h3>
                <form action="ContactServlet" method="post">
                    <div class="form-group">
                        <input type="text" class="form-control" name="name" required placeholder=" ">
                        <label class="form-label">Họ và tên</label>
                    </div>
                    <div class="form-group">
                        <input type="email" class="form-control" name="email" required placeholder=" ">
                        <label class="form-label">Email</label>
                    </div>
                    <div class="form-group">
                        <input type="tel" class="form-control" name="phone" placeholder=" ">
                        <label class="form-label">Số điện thoại</label>
                    </div>
                    <div class="form-group">
                        <textarea class="form-control" name="message" required placeholder=" "></textarea>
                        <label class="form-label">Nội dung tin nhắn</label>
                    </div>
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane" style="margin-right: 8px;"></i> Gửi tin nhắn
                    </button>
                </form>
            </div>

            <!-- Map -->
            <div class="card map animate__animated animate__fadeInUp">
                <h3><i class="fas fa-map-marked-alt"></i> Bản Đồ</h3>
                <div class="map-wrapper">
                    <iframe src="https://maps.google.com/maps?width=100%25&height=600&hl=en&q=S702%20Vinhomes%20GrandPark,%20Qu%E1%BA%ADn%209+(HomeStay)&t=&z=14&ie=UTF8&iwloc=B&output=embed" allowfullscreen></iframe>
                </div>
            </div>

            <!-- FAQ -->
            <div class="card faq animate__animated animate__fadeInLeft">
                <h3><i class="fas fa-question-circle"></i> Câu Hỏi Thường Gặp</h3>
                <div class="faq-item">
                    <div class="faq-question">
                        <i class="fas fa-chevron-right"></i> Tôi có thể đặt phòng qua điện thoại?
                    </div>
                    <div class="faq-answer">
                        Có, bạn có thể gọi hotline của chúng tôi để đặt phòng nhanh chóng và thuận tiện 24/7.
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">
                        <i class="fas fa-chevron-right"></i> Chính sách hoàn hủy như thế nào?
                    </div>
                    <div class="faq-answer">
                        Chính sách hoàn hủy phụ thuộc vào loại phòng và thời gian đặt. Vui lòng liên hệ chúng tôi để biết thêm chi tiết cụ thể cho đặt phòng của bạn.
                    </div>
                </div>
                <div class="faq-item">
                    <div class="faq-question">
                        <i class="fas fa-chevron-right"></i> Có dịch vụ đưa đón sân bay không?
                    </div>
                    <div class="faq-answer">
                        Có, chúng tôi cung cấp dịch vụ đưa đón sân bay với chi phí hợp lý. Vui lòng đặt trước ít nhất 24 giờ.
                    </div>
                </div>
            </div>

            <!-- Social links -->
            <div class="card social-links animate__animated animate__fadeInRight">
                <h3><i class="fas fa-share-alt"></i> Kết Nối Với Chúng Tôi</h3>
                <div class="social-media">
                    <a href="https://www.facebook.com/mamchildrendreamfoundation" target="_blank" class="social-item">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/0/05/Facebook_Logo_%282019%29.png" alt="Facebook">
                    </a>
                    <a href="https://www.instagram.com/" target="_blank" class="social-item">
                        <img src="https://cdn.pixabay.com/photo/2016/08/09/17/52/instagram-1581266_640.jpg" alt="Instagram">
                    </a>
                    <a href="https://zalo.me/" target="_blank" class="social-item">
                        <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Icon_of_Zalo.svg/1024px-Icon_of_Zalo.svg.png" alt="Zalo">
                    </a>
                   
                </div>
            </div>
        </div>

        <%@include file="footer.jsp" %>

        <button id="back-to-top" class="back-to-top" aria-label="Quay lại đầu trang">
            <i class="fas fa-chevron-up"></i>
        </button>

        <script>
            // Các phần tử animation khi scroll
            document.addEventListener('DOMContentLoaded', function() {
                // Hiệu ứng cho nút back to top
                const backToTopBtn = document.getElementById('back-to-top');
                
                window.addEventListener('scroll', function() {
                    if (window.pageYOffset > 300) {
                        backToTopBtn.classList.add('visible');
                    } else {
                        backToTopBtn.classList.remove('visible');
                    }
                });

                backToTopBtn.addEventListener('click', function() {
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                });
            });
        </script>
    </body>
</html>