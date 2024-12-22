package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;

@Entity
@Table(name = "User_Actualities")
public class UserActualityModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "user_id")
    private Long userId;

    @Column(name = "actuality_id")
    private Long actualityId;

    public UserActualityModel() {
    }

    public UserActualityModel(Long userId, Long actualityId) {
        this.userId = userId;
        this.actualityId = actualityId;
    }

    // Getters et setters
    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getActualityId() {
        return actualityId;
    }

    public void setActualityId(Long actualityId) {
        this.actualityId = actualityId;
    }
}

