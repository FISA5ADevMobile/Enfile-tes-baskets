package com.enfiletesbaskets.enfiletesbaskets.dto;

import java.util.Date;
import java.util.List;

public class CommunityDTO {
    private Long id;
    private String nom;
    private String description;
    private Date banDate;
    private Boolean isPublic;
    private Long adminId; // ID de l'admin
    private List<Long> userIds; // Liste des IDs des utilisateurs
    private List<Long> moderatorIds; // Liste des IDs des modérateurs
    private List<Long> postIds; // Liste des IDs des posts
    private List<Long> bannedUserIds; // Liste des IDs des utilisateurs bannis
    private Long categoryId; // ID de la catégorie

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
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

    public List<Long> getUserIds() {
        return userIds;
    }

    public void setUserIds(List<Long> userIds) {
        this.userIds = userIds;
    }

    public List<Long> getModeratorIds() {
        return moderatorIds;
    }

    public void setModeratorIds(List<Long> moderatorIds) {
        this.moderatorIds = moderatorIds;
    }

    public List<Long> getPostIds() {
        return postIds;
    }

    public void setPostIds(List<Long> postIds) {
        this.postIds = postIds;
    }

    public List<Long> getBannedUserIds() {
        return bannedUserIds;
    }

    public void setBannedUserIds(List<Long> bannedUserIds) {
        this.bannedUserIds = bannedUserIds;
    }

    public Long getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Long categoryId) {
        this.categoryId = categoryId;
    }
}