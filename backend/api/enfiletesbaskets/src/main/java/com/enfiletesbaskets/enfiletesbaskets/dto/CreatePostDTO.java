package com.enfiletesbaskets.enfiletesbaskets.dto;

import java.util.Date;

public class CreatePostDTO {
    private String description;
    private byte[] image;
    private Boolean visible;
    private String email; // ID du créateur
    private Long relatedPostId; // ID du post lié, si applicable
    // Getters et Setters
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
    }

    public Boolean getVisible() {
        return visible;
    }

    public void setVisible(Boolean visible) {
        this.visible = visible;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Long getRelatedPostId() {
        return relatedPostId;
    }

    public void setRelatedPostId(Long relatedPostId) {
        this.relatedPostId = relatedPostId;
    }
}