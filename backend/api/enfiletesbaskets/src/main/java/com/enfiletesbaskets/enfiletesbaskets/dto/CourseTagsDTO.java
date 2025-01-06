package com.enfiletesbaskets.enfiletesbaskets.dto;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import lombok.*;

import java.time.LocalDate;
import java.util.List;


@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class CourseTagsDTO {
    private Long id;
    private String name;
    private String description;
    private Float xPos;
    private Float yPos;
    private boolean validated;

    public static CourseTagsDTO from(TagModel tag, boolean validated) {
        return CourseTagsDTO.builder()
                .id(tag.getId())
                .name(tag.getName())
                .description(tag.getDescription())
                .xPos(tag.getXPos())
                .yPos(tag.getYPos())
                .validated(validated)
                .build();
    }
}
