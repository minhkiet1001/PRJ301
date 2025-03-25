/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author Admin
 */
public class BookDTO {
    private String BookID;
    private String title;
    private String Author;
    private int PublishYear;
    private double Price;
    private int Quantity;

    public BookDTO() {
    }

    public BookDTO(String BookID, String title, String Author, int PublishYear, double Price, int Quantity) {
        this.BookID = BookID;
        this.title = title;
        this.Author = Author;
        this.PublishYear = PublishYear;
        this.Price = Price;
        this.Quantity = Quantity;
    }

    public String getBookID() {
        return BookID;
    }

    public void setBookID(String BookID) {
        this.BookID = BookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return Author;
    }

    public void setAuthor(String Author) {
        this.Author = Author;
    }

    public int getPublishYear() {
        return PublishYear;
    }

    public void setPublishYear(int PublishYear) {
        this.PublishYear = PublishYear;
    }

    public double getPrice() {
        return Price;
    }

    public void setPrice(double Price) {
        this.Price = Price;
    }

    public int getQuantity() {
        return Quantity;
    }

    public void setQuantity(int Quantity) {
        this.Quantity = Quantity;
    }

    @Override
    public String toString() {
        return "BookDTO{" + "BookID=" + BookID + ", title=" + title + ", Author=" + Author + ", PublishYear=" + PublishYear + ", Price=" + Price + ", Quantity=" + Quantity + '}';
    }
    
    
}
