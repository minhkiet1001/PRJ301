package dto;

import java.sql.Timestamp;

public class ContactMessageDTO {
    private int id;
    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String message;
    private Timestamp createdAt;
    private boolean isRead;

    public ContactMessageDTO() {}

    public ContactMessageDTO(int id, int userId, String fullName, String email, String phone, String message, Timestamp createdAt, boolean isRead) {
        this.id = id;
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.message = message;
        this.createdAt = createdAt;
        this.isRead = isRead;
    }

    // Getters & Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isIsRead() {
        return isRead;
    }

    public void setIsRead(boolean isRead) {
        this.isRead = isRead;
    }

    @Override
    public String toString() {
        return "ContactMessageDTO{" + "id=" + id + ", userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", phone=" + phone + ", message=" + message + ", createdAt=" + createdAt + ", isRead=" + isRead + '}';
    }
    
}
