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

    // Getters et Setters
}
