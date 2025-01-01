package com.enfiletesbaskets.enfiletesbaskets.dto;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import lombok.*;

import java.time.LocalDate;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CourseDTO {
    private Long id;
    private Long userId;
    private Long classId;
    private LocalDate beginDate;
    private LocalDate endDate;

    public static CourseDTO toDTO(CourseModel course) {
        return CourseDTO.builder()
                .id(course.getId())
                .userId(course.getUser().getId())
                .classId(course.getClassModel().getId())
                .beginDate(course.getBeginDate())
                .endDate(course.getEndDate())
                .build();
    }
}
