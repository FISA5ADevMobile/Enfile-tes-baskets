package com.enfiletesbaskets.enfiletesbaskets.dto;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CourseWithClassDTO {
    private Long id;            // ID de la course
    private Long userId;        // ID de l'utilisateur inscrit à la course
    private LocalDate beginDate;
    private LocalDate endDate;

    // Informations de la classe associée
    private Long classId;
    private String className;
    private String classDescription;

    /**
     * Convertit un CourseModel en CourseWithClassDTO.
     */
    public static CourseWithClassDTO toDTO(CourseModel course) {
        return CourseWithClassDTO.builder()
                .id(course.getId())
                .userId(course.getUser().getId())
                .beginDate(course.getBeginDate())
                .endDate(course.getEndDate())
                .classId(course.getClassModel().getId())
                .className(course.getClassModel().getName())
                .classDescription(course.getClassModel().getDescription())
                .build();
    }
}
