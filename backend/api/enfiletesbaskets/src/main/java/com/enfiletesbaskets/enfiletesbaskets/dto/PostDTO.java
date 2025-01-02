package com.enfiletesbaskets.enfiletesbaskets.dto;


import java.util.Date;

public class PostDTO {
    private Long id;
    private String description;
    private Date datePost;
    private String imageBase64; // Image encodée en base64 pour transfert
    private Integer nbLike;
    private Integer nbPost;
    private Boolean visible;
    private Date banDate;
    private Long creatorId; // ID de l'utilisateur créateur
    private Long relatedPostId; // ID du post lié

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getDatePost() {
        return datePost;
    }

    public void setDatePost(Date datePost) {
        this.datePost = datePost;
    }

    public String getImageBase64() {
        return imageBase64;
    }

    public void setImageBase64(String imageBase64) {
        this.imageBase64 = imageBase64;
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

    public Long getCreatorId() {
        return creatorId;
    }

    public void setCreatorId(Long creatorId) {
        this.creatorId = creatorId;
    }

    public Long getRelatedPostId() {
        return relatedPostId;
    }

    public void setRelatedPostId(Long relatedPostId) {
        this.relatedPostId = relatedPostId;
    }
}
