package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;

@Entity
public class ActualityModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;
    private String description;
    private byte[] image;
    private boolean event;

    // Getters and Setters
    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

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

    public boolean getEvent() {
        return event;
    }

    public void setEvent(boolean event) {
        this.event = event;
    }
}
