package com.enfiletesbaskets.enfiletesbaskets.models;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Table(name = "Tag")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class TagModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;
    @Column(columnDefinition = "TEXT")
    private String description;

    @Column(name = "xpos")
    private Float xPos;

    @Column(name = "ypos")
    private Float yPos;

    @ManyToMany(mappedBy = "tags")
    @ToString.Exclude // Évite les boucles infinies
    @JsonIgnoreProperties("tags")
    private List<ClassModel> classes;

    @OneToMany(mappedBy = "tag", cascade = CascadeType.ALL)
    @ToString.Exclude // Évite les boucles infinies
    @JsonIgnoreProperties("tag")
    private List<CourseTagValidation> tagValidations;

}
