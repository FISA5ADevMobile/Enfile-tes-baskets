package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.*;

@Entity
@Table(name = "Class")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class ClassModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    private String description;

    @ManyToOne
    @JoinColumn(name = "owner", nullable = false)
    private UserModel owner;

    private String password;
    private Integer time;

    @Column(name = "begin_date")
    private LocalDate beginDate;

    @Column(name = "end_date")
    private LocalDate endDate;

    @ManyToMany
    @JoinTable(
            name = "Class_Tags",
            joinColumns = @JoinColumn(name = "class_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    @JsonManagedReference
    @ToString.Exclude // Évite la boucle infinie dans toString
    private List<TagModel> tags;

    @ManyToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REMOVE})
    @JoinTable(
            name = "Class_Courses",
            joinColumns = @JoinColumn(name = "class_id"),
            inverseJoinColumns = @JoinColumn(name = "course_id")
    )
    @JsonManagedReference
    @ToString.Exclude // Évite la boucle infinie dans toString
    private List<CourseModel> courses = new ArrayList<>();


    public ClassModel(String name, String description, UserModel owner, String password, Integer time, LocalDate beginDate, LocalDate endDate) {
        this.name = name;
        this.description = description;
        this.owner = owner;
        this.password = password;
        this.time = time;
        this.beginDate = beginDate;
        this.endDate = endDate;
    }

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

    public UserModel getOwner() {
        return owner;
    }

    public void setOwner(UserModel owner) {
        this.owner = owner;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getTime() {
        return time;
    }

    public void setTime(Integer time) {
        this.time = time;
    }

    public LocalDate getBeginDate() {
        return beginDate;
    }

    public void setBeginDate(LocalDate beginDate) {
        this.beginDate = beginDate;
    }

    public LocalDate getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDate endDate) {
        this.endDate = endDate;
    }

    public List<TagModel> getTags() {
        return tags;
    }

    public void setTags(List<TagModel> tags) {
        this.tags = tags;
    }

    public List<CourseModel> getCourses() {
        return courses;
    }

    public void setCourses(List<CourseModel> courses) {
        this.courses = courses;
    }
}
