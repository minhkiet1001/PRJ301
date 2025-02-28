<%@ page import="java.util.List, dto.RoomDTO" %>
<%
    List<RoomDTO> rooms = (List<RoomDTO>) request.getAttribute("roomList");
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Danh Sách Homestay</title>
    <style>
        /* Reset CSS */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
        }

        body {
            background-color: #f9f9f9;
            padding: 20px;
            text-align: center;
        }

        h1 {
            margin-bottom: 20px;
            color: #333;
        }

        #room-list {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }

        .room {
            background-color: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            text-align: left;
            transition: transform 0.3s ease-in-out;
        }

        .room:hover {
            transform: translateY(-5px);
        }

        .room img {
            width: 100%;
            height: 200px;
            object-fit: cover;
            display: block;
        }

        .room-info {
            padding: 15px;
        }

        .room-info h2 {
            font-size: 20px;
            color: #333;
            margin-bottom: 10px;
        }

        .room-info p {
            font-size: 14px;
            color: #666;
            margin-bottom: 8px;
        }

        .price {
            font-size: 18px;
            font-weight: bold;
            color: #d9534f;
        }

        .amenities {
            font-size: 14px;
            font-weight: bold;
            color: #5bc0de;
        }

        .ratings {
            font-size: 14px;
            color: #f0ad4e;
            font-weight: bold;
        }

        .btn-view-details {
            display: inline-block;
            background-color: #007bff;
            color: #fff;
            padding: 8px 12px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 10px;
            text-align: center;
            transition: background 0.3s ease-in-out;
        }

        .btn-view-details:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <h1>Danh Sách Phòng Homestay</h1>

    <section id="room-list">
        <% if (rooms != null && !rooms.isEmpty()) { %>
            <% for (RoomDTO room : rooms) { %>
                <div class="room">
                    <img src="<%= room.getImageUrl() %>" alt="<%= room.getName() %>">
                    <div class="room-info">
                        <h2><%= room.getName() %></h2>
                        <p><%= room.getDescription() %></p>
                        <p class="price"><%= room.getPrice() %> VN? / ?êm</p>
                        <p class="amenities">Ti?n nghi: <%= room.getAmenities() %></p>
                        <p class="ratings">? <%= room.getRatings() %>/5</p>

                        <% if (session.getAttribute("user") != null) { %>
                            <a href="room-details?roomId=<%= room.getId() %>" class="btn-view-details">Xem chi ti?t</a>
                        <% } else { %>
                            <a href="login-regis.jsp" class="btn-view-details">??ng nh?p ?? ??t</a>
                        <% } %>
                    </div>
                </div>
            <% } %>
        <% } else { %>
            <p>Không có phòng nào ?? hi?n th?.</p>
        <% } %>
    </section>
</body>
</html>