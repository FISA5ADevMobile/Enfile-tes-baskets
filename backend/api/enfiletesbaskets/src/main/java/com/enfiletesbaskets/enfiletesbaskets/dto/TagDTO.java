package com.enfiletesbaskets.enfiletesbaskets.dto;

import lombok.Getter;
import lombok.Setter;

import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class TagDTO {
    private Long id;
    private String name;
    private String description;
    private Float xPos;
    private Float yPos;

    public static TagDTO toDTO(TagModel tag) {
        return TagDTO.builder()
                .id(tag.getId())
                .name(tag.getName())
                .description(tag.getDescription())
                .xPos(tag.getXPos())
                .yPos(tag.getYPos())
                .build();
    }
}
