package com.enfiletesbaskets.enfiletesbaskets.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;

import java.util.List;

@Entity
@Table(name = "Tag")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class TagModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String description;

    @Column(name = "xpos")
    private Float xPos;

    @Column(name = "ypos")
    private Float yPos;

    @ManyToMany(mappedBy = "tags")
    @JsonBackReference 
    private List<ClassModel> classes;
    
    @ManyToMany(mappedBy = "tags")
    @JsonIgnoreProperties({"tags", "classes"}) // Prevent serialization of tags and classes in CourseModel
    private List<CourseModel> courses;
    
    @ManyToMany(mappedBy = "tags")
    @JsonIgnoreProperties({"tags", "classes", "courses"}) // Prevent serialization of related entities in UserModel
    private List<UserModel> users;
    
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

    public List<ClassModel> getClasses() {
        return classes;
    }

    public void setClasses(List<ClassModel> classes) {
        this.classes = classes;
    }

    public List<CourseModel> getCourses() {
        return courses;
    }

    public void setCourses(List<CourseModel> courses) {
        this.courses = courses;
    }

    public List<UserModel> getUsers() {
        return users;
    }

    public void setUsers(List<UserModel> users) {
        this.users = users;
    }
}
