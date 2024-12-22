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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getBanDate() {
        return banDate;
    }

    public void setBanDate(Date banDate) {
        this.banDate = banDate;
    }

    public Boolean getPublic() {
        return isPublic;
    }

    public void setPublic(Boolean aPublic) {
        isPublic = aPublic;
    }

    public UserModel getAdmin() {
        return admin;
    }

    public void setAdmin(UserModel admin) {
        this.admin = admin;
    }

    public List<UserModel> getUsers() {
        return users;
    }

    public void setUsers(List<UserModel> users) {
        this.users = users;
    }

    public List<UserModel> getModerators() {
        return moderators;
    }

    public void setModerators(List<UserModel> moderators) {
        this.moderators = moderators;
    }

    public List<PostModel> getPosts() {
        return posts;
    }

    public void setPosts(List<PostModel> posts) {
        this.posts = posts;
    }

    public List<UserModel> getBannedUsers() {
        return bannedUsers;
    }

    public void setBannedUsers(List<UserModel> bannedUsers) {
        this.bannedUsers = bannedUsers;
    }

    public CategoryModel getCategory() {
        return category;
    }

    public void setCategory(CategoryModel category) {
        this.category = category;
    }
// Getters et Setters
}

