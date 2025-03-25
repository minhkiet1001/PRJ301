/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.BookDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import sun.util.logging.PlatformLogger;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class BookDAO implements IDAO<BookDTO, String> {

    @Override
    public boolean create(BookDTO entity) {
        String sql = "INSERT INTO [tblBooks]" +
                "(BookID,Title, Author,PublishYear,Price,Quantity)"+
                "VALUES (?,?,?,?,?,?)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, entity.getBookID());
            ps.setString(2, entity.getTitle());
            ps.setString(3, entity.getAuthor());
            ps.setInt(4, entity.getPublishYear());
            ps.setDouble(5, entity.getPrice());
            ps.setInt(6, entity.getQuantity());
            int n = ps.executeUpdate();
            return n >0;
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex){
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    @Override
    public List<BookDTO> readAll() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public BookDTO readById(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean update(BookDTO entity) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean delete(String id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<BookDTO> search(String searchTerm) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    
    public List<BookDTO> searchByTile(String searchTerm){
        String sql = "SELECT * FROM tblBooks WHERE Title LIKE ?";
        List<BookDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+searchTerm+"%");
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                BookDTO books = new BookDTO(
                        rs.getString("BookID"),
                         rs.getString("Title"),
                         rs.getString("Author"),
                         rs.getInt("PublishYear"),
                         rs.getDouble("Price"),
                         rs.getInt("Quantity")
                );
                list.add(books);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex){
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
         return list;
    }
    
     public List<BookDTO> searchByTile2(String searchTerm){
        String sql = "SELECT * FROM tblBooks WHERE Title LIKE ? AND Quantity > 0";
        List<BookDTO> list = new ArrayList<>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%"+searchTerm+"%");
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                BookDTO books = new BookDTO(
                        rs.getString("BookID"),
                         rs.getString("Title"),
                         rs.getString("Author"),
                         rs.getInt("PublishYear"),
                         rs.getDouble("Price"),
                         rs.getInt("Quantity")
                );
                list.add(books);
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex){
            Logger.getLogger(BookDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
         return list;
    }
    
   public boolean updateQuantityToZero(String id){
       String sql = "UPDATE tblBooks SET Quantity = 0 WHERE BookID=?";
       try {
           Connection conn = DBUtils.getConnection();
           PreparedStatement ps = conn.prepareStatement(sql);
           ps.setString(1, id);
           int i = ps.executeUpdate();
           return i>0;
       } catch (Exception e) {
           System.out.println(e.toString());
       }
       return false;
   }
   
    
}
