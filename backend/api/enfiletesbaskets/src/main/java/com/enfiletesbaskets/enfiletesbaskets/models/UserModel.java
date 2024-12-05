package com.enfiletesbaskets.enfiletesbaskets.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "users")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class UserModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String email;

    @Column(nullable = false)
    private String pseudo;

    private String name;
    private String firstName;
    private String password;
    private byte[] profilPicture;
    private String role;

    @Column(name = "nbPostDeleted")
    private Integer nbPostDeleted = 0;

    private LocalDate banDate;

    @ManyToMany
    @JoinTable(
            name = "User_Tags",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "tag_id")
    )
    @JsonIgnoreProperties("users") // Prevent infinite loop with TagModel
    private List<TagModel> tags;

    @ManyToMany
    @JoinTable(
            name = "User_Courses",
            joinColumns = @JoinColumn(name = "user_id"),
            inverseJoinColumns = @JoinColumn(name = "course_id")
    )
    @JsonIgnoreProperties("users") // Prevent infinite loop with CourseModel
    private List<CourseModel> courses;

    public UserModel() {}

    public UserModel(Long id) {
        this.id = id;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

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

    public LocalDate getBanDate() {
        return banDate;
    }

    public void setBanDate(LocalDate banDate) {
        this.banDate = banDate;
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

    public Collection<? extends GrantedAuthority> getAuthorities() {
        List<GrantedAuthority> authorities = new ArrayList<>();
        authorities.add(new SimpleGrantedAuthority(role)); //
        return authorities;
    }
}
