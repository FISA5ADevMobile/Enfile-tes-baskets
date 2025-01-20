package com.enfiletesbaskets.enfiletesbaskets.dto;

import java.util.Date;
import java.util.List;

public class CommunityDTO {
    private Long id;
    private String name;
    private String description;
    private Date banDate;
    private Boolean isPublic;
    private Long adminId; // ID de l'admin
    private boolean joined; // Liste des IDs des utilisateurs
    private List<Long> moderatorIds; // Liste des IDs des modérateurs
    private List<PostDTO> postIds; // Liste des IDs des posts
    private List<Long> bannedUserIds; // Liste des IDs des utilisateurs bannis
    private String categoryName; // ID de la catégorie
    private byte[] image;

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
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

    public Date getBanDate() {
        return banDate;
    }

    public void setBanDate(Date banDate) {
        this.banDate = banDate;
    }

    public Boolean getIsPublic() {
        return isPublic;
    }

    public void setIsPublic(Boolean isPublic) {
        this.isPublic = isPublic;
    }

    public Long getAdminId() {
        return adminId;
    }

    public void setAdminId(Long adminId) {
        this.adminId = adminId;
    }

    public boolean getJoined() {
        return joined;
    }

    public void setJoined(boolean joined) {
        this.joined = joined;
    }

    public List<Long> getModeratorIds() {
        return moderatorIds;
    }

    public void setModeratorIds(List<Long> moderatorIds) {
        this.moderatorIds = moderatorIds;
    }

    public List<PostDTO> getPostIds() {
        return postIds;
    }

    public void setPostIds(List<PostDTO> postIds) {
        this.postIds = postIds;
    }

    public List<Long> getBannedUserIds() {
        return bannedUserIds;
    }

    public void setBannedUserIds(List<Long> bannedUserIds) {
        this.bannedUserIds = bannedUserIds;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}