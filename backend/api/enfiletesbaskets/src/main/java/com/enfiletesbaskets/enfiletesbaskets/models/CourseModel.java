package com.enfiletesbaskets.enfiletesbaskets.models;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;

import java.time.LocalDate;
import java.util.List;
@Entity
@Table(name = "Course")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
public class CourseModel {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    @JsonIgnoreProperties("courses") // Évite les boucles infinies avec UserModel
    private UserModel user;

    @ManyToOne
    @JoinColumn(name = "class_id", nullable = false)
    @JsonIgnoreProperties("courses") // Évite les boucles infinies avec ClassModel
    private ClassModel classModel;

    @OneToMany(mappedBy = "course", cascade = CascadeType.ALL)
    @ToString.Exclude // Évite les boucles infinies
    @JsonIgnoreProperties("course")
    private List<CourseTagValidation> tagValidations;

    @Column(name = "begin_date")
    private LocalDate beginDate;

    @Column(name = "end_date")
    private LocalDate endDate;

}
