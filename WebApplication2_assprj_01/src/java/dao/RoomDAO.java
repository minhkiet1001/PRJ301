/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.RoomDTO;
import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import static java.util.Collections.list;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class RoomDAO {
    public RoomDTO getRoomById(int roomId){
        String sql = "SELECT * FROM rooms WHERE id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, roomId);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                RoomDTO room = new RoomDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("decription"),
                        rs.getDouble("price"),
                        rs.getString("amenities"),
                        rs.getFloat("ratings"),
                        rs.getString("image_url")
                );
               return room; 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    public RoomDTO getRoomByName(String roomName){
        String sql = "SELECT * FROM rooms WHERE name = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, roomName);
            ResultSet rs = ps.executeQuery();
            
            if(rs.next()){
                RoomDTO room = new RoomDTO(
                         rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("amenities"),
                    rs.getFloat("ratings"),
                    rs.getString("image_url")
                );
                return room;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
     public List<RoomDTO> searchRooms(String name, String minPrice, String maxPrice, String amenities, String minRating) {
        List<RoomDTO> rooms = new ArrayList<>();
        try (Connection conn = DBUtils.getConnection()) {
            String query = "SELECT * FROM rooms WHERE 1=1";
            List<Object> parameters = new ArrayList<>();

            if (name != null && !name.isEmpty()) {
                query += " AND name LIKE ?";
                parameters.add("%" + name + "%");
            }
            if (minPrice != null && !minPrice.isEmpty()) {
                query += " AND price >= ?";
                parameters.add(Double.parseDouble(minPrice));
            }
            if (maxPrice != null && !maxPrice.isEmpty()) {
                query += " AND price <= ?";
                parameters.add(Double.parseDouble(maxPrice));
            }
            if (amenities != null && !amenities.isEmpty()) {
                query += " AND amenities LIKE ?";
                parameters.add("%" + amenities + "%");
            }
            if (minRating != null && !minRating.isEmpty()) {
                query += " AND ratings >= ?";
                parameters.add(Float.parseFloat(minRating));
            }

            PreparedStatement ps = conn.prepareStatement(query);
            for (int i = 0; i < parameters.size(); i++) {
                ps.setObject(i + 1, parameters.get(i));
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
                        rs.getString("imageUrl")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rooms;
    }
     
     public List<RoomDTO> getAllRooms(){
         List<RoomDTO> list = new ArrayList<>();
         String sql = "SELECT * FROM rooms";
         
         try {
             Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();
               while (rs.next()) {
                RoomDTO room = new RoomDTO(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("amenities"),
                        rs.getFloat("ratings"),
                        rs.getString("imageUrl"));
                list.add(room);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
     }
     
}
