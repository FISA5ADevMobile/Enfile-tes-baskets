package com.enfiletesbaskets.enfiletesbaskets.models;

import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "CourseTagValidation")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class CourseTagValidation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "course_id", nullable = false)
    private CourseModel course;

    @ManyToOne
    @JoinColumn(name = "tag_id", nullable = false)
    private TagModel tag;

    @Column(name = "date_validation", nullable = false)
    private LocalDateTime dateValidation;

    // ✅ Nouveau constructeur pour le service
    public CourseTagValidation(CourseModel course, TagModel tag) {
        this.course = course;
        this.tag = tag;
        this.dateValidation = LocalDateTime.now(); // Date automatique
    }
}
