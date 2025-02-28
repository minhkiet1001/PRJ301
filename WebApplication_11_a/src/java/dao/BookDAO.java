/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BookDTO;
import dto.UserDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class BookDAO implements IDAO<UserDTO, String>  {

    @Override
    public boolean create(UserDTO entity) {
        return false;
    }

    @Override
    public List<UserDTO> readAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public UserDTO readById(String id) {
        return null;
    }

    @Override
    public boolean update(UserDTO entity) {
         return false;
    }

    @Override
    public boolean delete(String id) {
          return false;
    }

    @Override
    public List<UserDTO> search(String searchTerm) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public List<BookDTO> searchByTitle(String searchTerm){
        String sql = "SELECT * FROM tblBooks WHERE title LIKE ? ";
        List<BookDTO> list = new ArrayList<>();
        try{
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" +searchTerm +"%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                BookDTO book = new BookDTO(
                        rs.getString("BookID"), 
                        rs.getString("Title"), 
                        rs.getString("Author"), 
                        rs.getInt("PublishYear"), 
                        rs.getDouble("Price"), 
                        rs.getInt("Quantity"));
                 list.add(book);
            }
            
        }catch (Exception e){
            System.out.println(e.toString());
        }
        return list;
    }
    
     public List<BookDTO> searchByTitle2(String searchTerm) {
        String sql = "SELECT * FROM tblBooks WHERE title LIKE ? AND Quantity>0";
        List<BookDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookDTO book = new BookDTO(
                        rs.getString("BookID"),
                        rs.getString("Title"),
                        rs.getString("Author"),
                        rs.getInt("PublishYear"),
                        rs.getDouble("Price"),
                        rs.getInt("Quantity"));
                list.add(book);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }

    public boolean updateQuantityToZero(String id) {
        String sql = "UPDATE tblBooks SET Quantity=0 WHERE BookID=?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, id);
            
            int i = ps.executeUpdate();
            return i > 0;
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return false;
    }
    
}
