package dto;

public class UserDTO {
    private String userID;
    private String fullName;
    private String roleID;
    private String password;
    private String gmail;
    private String sdt;
    private String avatarUrl;
    private String token;
    private boolean isVerified;

    // Constructor mới chỉ nhận userID
    public UserDTO(String userID) {
        this.userID = userID;
        this.fullName = null;
        this.roleID = null;
        this.password = null;
        this.gmail = null;
        this.sdt = null;
        this.avatarUrl = null;
        this.token = null;
        this.isVerified = false;
    }

    // Các constructor hiện có
    public UserDTO(String userID, String fullName, String roleID, String password, String gmail, String sdt, String avatarUrl, String token, boolean isVerified) {
        this.userID = userID;
        this.fullName = fullName;
        this.roleID = roleID;
        this.password = password;
        this.gmail = gmail;
        this.sdt = sdt;
        this.avatarUrl = avatarUrl;
        this.token = token;
        this.isVerified = isVerified;
    }

    public UserDTO(String userID, String fullName, String roleID, String password, String gmail, String sdt, String avatarUrl) {
        this(userID, fullName, roleID, password, gmail, sdt, avatarUrl, null, false);
    }

    // Getters và setters (giữ nguyên)
    public String getUserID() {
        return userID;
    }

    public void setUserID(String userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRoleID() {
        return roleID;
    }

    public void setRoleID(String roleID) {
        this.roleID = roleID;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getGmail() {
        return gmail;
    }

    public void setGmail(String gmail) {
        this.gmail = gmail;
    }

    public String getSdt() {
        return sdt;
    }

    public void setSdt(String sdt) {
        this.sdt = sdt;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public boolean isIsVerified() {
        return isVerified;
    }

    public void setIsVerified(boolean isVerified) {
        this.isVerified = isVerified;
    }
}