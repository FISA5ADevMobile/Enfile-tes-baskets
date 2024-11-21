package com.enfiletesbaskets.enfiletesbaskets.models;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import jakarta.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
public class TagModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String name;
    private String description;
    private Float xPos;
    private Float yPos;

    @ManyToMany(mappedBy = "tagsValidated")
    private List<UserModel> users = new ArrayList<>();

    @ManyToMany(mappedBy = "tags")
    private List<ClassModel> classes = new ArrayList<>();

    // Getters and Setters
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Float getxPos() {
        return xPos;
    }

    public void setxPos(Float xPos) {
        this.xPos = xPos;
    }

    public Float getyPos() {
        return yPos;
    }

    public void setyPos(Float yPos) {
        this.yPos = yPos;
    }

    public List<UserModel> getUsers() {
        return users;
    }

    public void setUsers(List<UserModel> users) {
        this.users = users;
    }

    public List<ClassModel> getClasses() {
        return classes;
    }

    public void setClasses(List<ClassModel> classes) {
        this.classes = classes;
    }
}
