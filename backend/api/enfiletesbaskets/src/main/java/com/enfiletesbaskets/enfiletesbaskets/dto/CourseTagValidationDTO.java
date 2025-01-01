package com.enfiletesbaskets.enfiletesbaskets.dto;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseTagValidation;
import lombok.*;

import java.time.LocalDateTime;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CourseTagValidationDTO {
    private Long id;
    private Long courseId;
    private Long tagId;
    private LocalDateTime dateValidation;

    public static CourseTagValidationDTO toDTO(CourseTagValidation validation) {
        return CourseTagValidationDTO.builder()
                .id(validation.getId())
                .courseId(validation.getCourse().getId())
                .tagId(validation.getTag().getId())
                .dateValidation(validation.getDateValidation())
                .build();
    }
}
