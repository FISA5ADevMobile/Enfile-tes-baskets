package com.enfiletesbaskets.enfiletesbaskets.models;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class CommunityModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nom;
    private String description;
    private Date banDate;
    private Boolean isPublic;

    @ManyToOne
    @JoinColumn(name = "admin_id")
    private UserModel admin;

    @ManyToMany
    @JoinTable(
            name = "Community_Users",
            joinColumns = @JoinColumn(name = "community_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<UserModel> users = new ArrayList<>();

    @ManyToMany
    @JoinTable(
            name = "Community_Moderators",
            joinColumns = @JoinColumn(name = "community_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<UserModel> moderators = new ArrayList<>();

    @ManyToMany
    @JoinTable(
            name = "Community_Posts",
            joinColumns = @JoinColumn(name = "community_id"),
            inverseJoinColumns = @JoinColumn(name = "post_id")
    )
    private List<PostModel> posts = new ArrayList<>();

    @ManyToMany
    @JoinTable(
            name = "Community_BannedUsers",
            joinColumns = @JoinColumn(name = "community_id"),
            inverseJoinColumns = @JoinColumn(name = "user_id")
    )
    private List<UserModel> bannedUsers = new ArrayList<>();

    @ManyToOne
    @JoinColumn(name = "category_id")
    private CategoryModel category;

    // Getters et Setters
}

