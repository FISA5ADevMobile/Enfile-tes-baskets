    package com.enfiletesbaskets.enfiletesbaskets.models;
    
    import jakarta.persistence.*;
    
    import java.time.LocalDateTime;
    
    @Entity
    public class ActualityModel {
        @Id
        @GeneratedValue(strategy = GenerationType.IDENTITY)
        private Long id;
        private String title;
        private String description;
        private byte[] image;
        private boolean event;
        @Column(name = "publication_date")
        private LocalDateTime publicationDate;
    
        // Getters and Setters
        public Long getId() {
            return id;
        }
    
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
    
        public LocalDateTime getPublicationDate() {
            return publicationDate;
        }
    
        public void setPublicationDate(LocalDateTime publicationDate) {
            this.publicationDate = publicationDate;
        }
    }
