package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;
import java.util.Date;

@Entity
public class PostModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String description;
    private Date datePost;
    private byte[] image;
    private Integer nbLike;
    private Integer nbPost;
    private Boolean visible;
    private Date banDate;

    @ManyToOne
    @JoinColumn(name = "creator")
    private UserModel creator;

    @ManyToOne
    @JoinColumn(name = "related")
    private PostModel related;

    // Getters and Setters
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

    public byte[] getImage() {
        return image;
    }

    public void setImage(byte[] image) {
        this.image = image;
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

    public PostModel getRelated() {
        return related;
    }

    public void setRelated(PostModel related) {
        this.related = related;
    }
}
