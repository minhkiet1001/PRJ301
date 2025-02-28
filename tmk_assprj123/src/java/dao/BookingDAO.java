package dao;

import dto.BookingDTO;
import dto.RoomDTO;
import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

public class BookingDAO {

    // Hằng số cho các trạng thái đặt phòng
    public static final String STATUS_PENDING = "Pending";
    public static final String STATUS_CONFIRMED = "Confirmed";
    public static final String STATUS_CANCELLED = "Cancelled";

    // Thêm đặt phòng mới sau khi kiểm tra phòng có sẵn
    public boolean addBooking(BookingDTO booking) throws ClassNotFoundException {
        if (booking == null || !isRoomAvailable(booking.getRoom().getId(), booking.getCheckInDate(), booking.getCheckOutDate())) {
            return false;
        }

        String sql = "INSERT INTO bookings (userID, room_id, check_in_date, check_out_date, total_price, status, created_at) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, booking.getUser().getUserID());
            ps.setInt(2, booking.getRoom().getId());
            ps.setDate(3, new java.sql.Date(booking.getCheckInDate().getTime()));
            ps.setDate(4, new java.sql.Date(booking.getCheckOutDate().getTime()));
            ps.setDouble(5, booking.getTotalPrice());
            ps.setString(6, booking.getStatus());
            ps.setTimestamp(7, new Timestamp(booking.getCreatedAt().getTime()));
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error adding booking: " + e.getMessage());
            return false;
        }
    }

    // Kiểm tra phòng có sẵn không
    public boolean isRoomAvailable(int roomId, java.util.Date checkIn, java.util.Date checkOut) throws ClassNotFoundException {
        if (roomId <= 0 || checkIn == null || checkOut == null || checkOut.before(checkIn)) {
            return false;
        }

        String sql = "SELECT COUNT(*) FROM bookings WHERE room_id = ? AND (check_in_date < ? AND check_out_date > ?) AND status != ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setDate(2, new java.sql.Date(checkOut.getTime()));
            ps.setDate(3, new java.sql.Date(checkIn.getTime()));
            ps.setString(4, STATUS_CANCELLED);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error checking room availability: " + e.getMessage());
        }
        return false;
    }

    // Lấy danh sách đặt phòng theo userID
    public List<BookingDTO> getBookingsByUserId(String userID) throws ClassNotFoundException, Exception {
        List<BookingDTO> bookings = new ArrayList<>();
        String sql = "SELECT * FROM bookings WHERE userID = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching bookings by user ID: " + e.getMessage());
        }
        return bookings;
    }

    // Lấy danh sách đặt phòng theo room_id
    public List<BookingDTO> getBookingsByRoomId(int roomId) throws ClassNotFoundException, Exception {
        List<BookingDTO> bookings = new ArrayList<>();
        if (roomId <= 0) {
            return bookings;
        }

        String sql = "SELECT * FROM bookings WHERE room_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    bookings.add(mapResultSetToBooking(rs));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching bookings by room ID: " + e.getMessage());
        }
        return bookings;
    }

    // Hủy đặt phòng bằng cách cập nhật trạng thái
    public boolean cancelBooking(int bookingId) throws ClassNotFoundException {
        return updateBookingStatus(bookingId, STATUS_CANCELLED);
    }

    // Cập nhật trạng thái đặt phòng
    public boolean updateBookingStatus(int bookingId, String status) throws ClassNotFoundException {
        if (bookingId <= 0 || status == null || status.trim().isEmpty()) {
            return false;
        }

        String sql = "UPDATE bookings SET status = ? WHERE id = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating booking status: " + e.getMessage());
            return false;
        }
    }

    // Map dữ liệu từ ResultSet sang BookingDTO
    private BookingDTO mapResultSetToBooking(ResultSet rs) throws SQLException, Exception {
        UserDAO userDAO = new UserDAO();
        UserDTO user = userDAO.readById(rs.getString("userID"));

        RoomDAO roomDAO = new RoomDAO();
        RoomDTO room = roomDAO.getRoomById(rs.getInt("room_id"));

        return new BookingDTO(
                rs.getInt("id"),
                user,
                room,
                rs.getDate("check_in_date"),
                rs.getDate("check_out_date"),
                rs.getDouble("total_price"),
                rs.getString("status"),
                rs.getTimestamp("created_at")
        );
    }

    // Lấy thông tin đặt phòng theo ID
    public BookingDTO getBookingById(int bookingId) throws ClassNotFoundException, Exception {
        if (bookingId <= 0) {
            return null;
        }

        String sql = "SELECT * FROM bookings WHERE id = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching booking by ID: " + e.getMessage());
        }
        return null;
    }

    // Lấy thông tin đặt phòng theo userID và room_id
    public BookingDTO getBookingByUserAndRoom(String userId, int roomId) throws ClassNotFoundException, Exception {
        if (userId == null || userId.trim().isEmpty() || roomId <= 0) {
            return null;
        }

        String sql = "SELECT * FROM bookings WHERE userID = ? AND room_id = ? AND status != ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userId);
            ps.setInt(2, roomId);
            ps.setString(3, STATUS_CANCELLED);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToBooking(rs);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error fetching booking by user and room: " + e.getMessage());
        }
        return null;
    }
}