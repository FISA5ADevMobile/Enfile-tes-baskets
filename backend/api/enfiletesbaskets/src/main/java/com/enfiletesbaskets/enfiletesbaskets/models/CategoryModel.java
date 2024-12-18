package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;
import java.util.List;

@Entity
public class CategoryModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    @OneToMany(mappedBy = "category")
    private List<CommunityModel> communities;

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

    public List<CommunityModel> getCommunities() {
        return communities;
    }

    public void setCommunities(List<CommunityModel> communities) {
        this.communities = communities;
    }
// Getters et Setters
}
