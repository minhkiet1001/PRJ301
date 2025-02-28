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
public class RoomDTO {
    private int id;
    private String name;
    private String description;
    private double price;
    private String amenities;
    private float ratings;
    private String imageUrl;

    public RoomDTO() {
    }

    public RoomDTO(int id, String name, String description, double price, String amenities, float ratings, String imageUrl) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.amenities = amenities;
        this.ratings = ratings;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getAmenities() {
        return amenities;
    }

    public void setAmenities(String amenities) {
        this.amenities = amenities;
    }

    public float getRatings() {
        return ratings;
    }

    public void setRatings(float ratings) {
        this.ratings = ratings;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    @Override
    public String toString() {
        return "RoomDTO{" + "id=" + id + ", name=" + name + ", description=" + description + ", price=" + price + ", amenities=" + amenities + ", ratings=" + ratings + ", imageUrl=" + imageUrl + '}';
    }
    
    
}
