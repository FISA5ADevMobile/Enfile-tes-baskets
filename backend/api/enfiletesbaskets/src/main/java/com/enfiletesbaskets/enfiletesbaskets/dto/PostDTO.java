package com.enfiletesbaskets.enfiletesbaskets.dto;


import java.util.Date;

public class PostDTO {
    private Long id;
    private String content;
    private Date datePost;
    private String imageUrl; // Image encodée en base64 pour transfert
    private Integer nbLike;
    private Integer nbPost;
    private Boolean visible;
    private Date banDate;
    private String username; // ID de l'utilisateur créateur
    private Long relatedPostId; // ID du post lié

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getDatePost() {
        return datePost;
    }

    public void setDatePost(Date datePost) {
        this.datePost = datePost;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Integer getNbLike() {
        return nbLike;
    }

    public void setNbLike(Integer nbLike) {
        this.nbLike = nbLike;
    }

    public Integer getNbPost() {
        return nbPost;
    }

    public void setNbPost(Integer nbPost) {
        this.nbPost = nbPost;
    }

    public Boolean getVisible() {
        return visible;
    }

    public void setVisible(Boolean visible) {
        this.visible = visible;
    }

    public Date getBanDate() {
        return banDate;
    }

    public void setBanDate(Date banDate) {
        this.banDate = banDate;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Long getRelatedPostId() {
        return relatedPostId;
    }

    public void setRelatedPostId(Long relatedPostId) {
        this.relatedPostId = relatedPostId;
    }
}
