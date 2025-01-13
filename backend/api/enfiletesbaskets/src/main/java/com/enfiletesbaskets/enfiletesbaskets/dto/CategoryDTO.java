package com.enfiletesbaskets.enfiletesbaskets.dto;

import java.util.List;

public class CategoryDTO {
    private Long id;
    private String nom;
    private List<Long> communityIds; // Liste des IDs des communautés

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

    public List<Long> getCommunityIds() {
        return communityIds;
    }

    public void setCommunityIds(List<Long> communityIds) {
        this.communityIds = communityIds;
    }
}
