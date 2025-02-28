package dao;

import dto.RoomDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import utils.DBUtils;

public class RoomDAO {

    public RoomDTO getRoomById(int roomId) throws Exception {
        RoomDTO room = null;
        String sqlRoom = "SELECT * FROM rooms WHERE id = ?";
        String sqlImages = "SELECT image_url FROM room_images WHERE room_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement psRoom = conn.prepareStatement(sqlRoom);
             PreparedStatement psImages = conn.prepareStatement(sqlImages)) {
            
            if (conn == null) {
                throw new Exception("Cannot establish database connection");
            }

            // Truy vấn thông tin phòng
            psRoom.setInt(1, roomId);
            try (ResultSet rsRoom = psRoom.executeQuery()) {
                if (rsRoom.next()) {
                    room = new RoomDTO(
                        rsRoom.getInt("id"),
                        rsRoom.getString("name"),
                        rsRoom.getString("description"),
                        rsRoom.getDouble("price"),
                        rsRoom.getString("amenities"),
                        rsRoom.getFloat("ratings"),
                        rsRoom.getString("image_url"),
                        null 
                    );
                    
                    // Truy vấn danh sách ảnh chi tiết
                    psImages.setInt(1, roomId);
                    try (ResultSet rsImages = psImages.executeQuery()) {
                        List<String> detailImages = new ArrayList<>();
                        while (rsImages.next()) {
                            detailImages.add(rsImages.getString("image_url"));
                        }
                        room.setDetailImages(detailImages); // Gán danh sách ảnh chi tiết
                    }
                }
            }
        } catch (Exception e) {
            throw new Exception("Error retrieving room by ID " + roomId + ": " + e.getMessage(), e);
        }
        return room; // Trả về null nếu không tìm thấy phòng
    }

    public RoomDTO getRoomByName(String roomName) throws Exception {
        RoomDTO room = null;
        String sqlRoom = "SELECT * FROM rooms WHERE name = ?";
        String sqlImages = "SELECT image_url FROM room_images WHERE room_id = ?";
        
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement psRoom = conn.prepareStatement(sqlRoom);
             PreparedStatement psImages = conn.prepareStatement(sqlImages)) {
            
            if (conn == null) {
                throw new Exception("Cannot establish database connection");
            }

            // Truy vấn thông tin phòng
            psRoom.setString(1, roomName);
            try (ResultSet rsRoom = psRoom.executeQuery()) {
                if (rsRoom.next()) {
                    room = new RoomDTO(
                        rsRoom.getInt("id"),
                        rsRoom.getString("name"),
                        rsRoom.getString("description"),
                        rsRoom.getDouble("price"),
                        rsRoom.getString("amenities"),
                        rsRoom.getFloat("ratings"),
                        rsRoom.getString("image_url"),
                        null // detailImages để null, sẽ cập nhật sau
                    );
                    
                    // Truy vấn danh sách ảnh chi tiết
                    psImages.setInt(1, room.getId());
                    try (ResultSet rsImages = psImages.executeQuery()) {
                        List<String> detailImages = new ArrayList<>();
                        while (rsImages.next()) {
                            detailImages.add(rsImages.getString("image_url"));
                        }
                        room.setDetailImages(detailImages); // Gán danh sách ảnh chi tiết
                    }
                }
            }
        } catch (Exception e) {
            throw new Exception("Error retrieving room by name " + roomName + ": " + e.getMessage(), e);
        }
        return room; 
    }
    
 
     public List<RoomDTO> getFilteredRooms(String homestayName, Double maxPrice, String priceFilterType, String amenities) {
        List<RoomDTO> rooms = new ArrayList<>();
        String sql = "SELECT * FROM Rooms WHERE 1=1";

        // Xây dựng điều kiện lọc linh hoạt
        if (homestayName != null && !homestayName.isEmpty()) {
            sql += " AND LOWER(name) LIKE ?";
        }
        if (maxPrice != null) {
            if ("below".equals(priceFilterType)) {
                sql += " AND price <= ?";
            } else if ("above".equals(priceFilterType)) {
                sql += " AND price >= ?";
            }
        }
        if (amenities != null && !amenities.isEmpty()) {
            sql += " AND LOWER(amenities) LIKE ?";
        }

        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            int index = 1;
            if (homestayName != null && !homestayName.isEmpty()) {
                ps.setString(index++, "%" + homestayName.toLowerCase() + "%");
            }
            if (maxPrice != null) {
                ps.setDouble(index++, maxPrice);
            }
            if (amenities != null && !amenities.isEmpty()) {
                ps.setString(index++, "%" + amenities.toLowerCase() + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                rooms.add(new RoomDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("amenities"),
                        rs.getFloat("ratings"),
                        rs.getString("image_url"),
                        new ArrayList<>()
                ));
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return rooms;
    }








public List<RoomDTO> getAllRooms() throws Exception {
    List<RoomDTO> roomList = new ArrayList<>();
    String sqlRoom = "SELECT * FROM rooms";
    String sqlImages = "SELECT image_url FROM room_images WHERE room_id = ?";

    try (Connection conn = DBUtils.getConnection();
         PreparedStatement psRoom = conn.prepareStatement(sqlRoom);
         PreparedStatement psImages = conn.prepareStatement(sqlImages)) {

        if (conn == null) {
            throw new Exception("Cannot establish database connection");
        }

        // Truy vấn tất cả các phòng
        try (ResultSet rsRoom = psRoom.executeQuery()) {
            while (rsRoom.next()) {
                RoomDTO room = new RoomDTO(
                        rsRoom.getInt("id"),
                        rsRoom.getString("name"),
                        rsRoom.getString("description"),
                        rsRoom.getDouble("price"),
                        rsRoom.getString("amenities"),
                        rsRoom.getFloat("ratings"),
                        rsRoom.getString("image_url"),
                        null // detailImages để null, sẽ cập nhật sau
                );

                // Truy vấn danh sách ảnh chi tiết cho từng phòng
                psImages.setInt(1, room.getId());
                try (ResultSet rsImages = psImages.executeQuery()) {
                    List<String> detailImages = new ArrayList<>();
                    while (rsImages.next()) {
                        detailImages.add(rsImages.getString("image_url"));
                    }
                    room.setDetailImages(detailImages);
                }

                roomList.add(room);
            }
        }
    } catch (Exception e) {
        throw new Exception("Error retrieving all rooms: " + e.getMessage(), e);
    }
    return roomList;
}

}