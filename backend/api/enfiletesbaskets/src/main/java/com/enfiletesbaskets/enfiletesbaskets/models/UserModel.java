package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Entity
public class UserModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String email;
    private String pseudo;
    private String name;
    private String firstName;
    private String password;
    private byte[] profilPicture;
    private String role;
    private Integer nbPostDeleted;
    private Date banDate;

    @ManyToMany
    @JoinTable(
            name = "User_Tags",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    private List<TagModel> tagsValidated = new ArrayList<>();

    @OneToMany(mappedBy = "user")
    private List<CourseModel> courses = new ArrayList<>();

    // Getters and Setters

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPseudo() {
        return pseudo;
    }

    public void setPseudo(String pseudo) {
        this.pseudo = pseudo;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public byte[] getProfilPicture() {
        return profilPicture;
    }

    public void setProfilPicture(byte[] profilPicture) {
        this.profilPicture = profilPicture;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Integer getNbPostDeleted() {
        return nbPostDeleted;
    }

    public void setNbPostDeleted(Integer nbPostDeleted) {
        this.nbPostDeleted = nbPostDeleted;
    }

    public Date getBanDate() {
        return banDate;
    }

    public void setBanDate(Date banDate) {
        this.banDate = banDate;
    }

    public List<TagModel> getTagsValidated() {
        return tagsValidated;
    }

    public void setTagsValidated(List<TagModel> tagsValidated) {
        this.tagsValidated = tagsValidated;
    }

    public List<CourseModel> getCourses() {
        return courses;
    }

    public void setCourses(List<CourseModel> courses) {
        this.courses = courses;
    }
}
