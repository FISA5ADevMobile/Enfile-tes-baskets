package com.enfiletesbaskets.enfiletesbaskets.dto;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;

@Getter
@Setter
public class ClassDTO {

    private Long id;
    private String name;
    private String description;
    private String password;
    private Integer time;
    private LocalDate beginDate;
    private LocalDate endDate;

    // Convertit une entité ClassModel en ClassDTO
    public static ClassDTO toDTO(ClassModel clazz) {
        ClassDTO dto = new ClassDTO();
        dto.setId(clazz.getId());
        dto.setName(clazz.getName());
        dto.setDescription(clazz.getDescription());
        dto.setPassword(clazz.getPassword());
        dto.setTime(clazz.getTime());
        dto.setBeginDate(clazz.getBeginDate());
        dto.setEndDate(clazz.getEndDate());
        return dto;
    }

    // Convertit un ClassDTO en ClassModel
    public static ClassModel toEntity(ClassDTO dto) {
        ClassModel clazz = new ClassModel();
        clazz.setName(dto.getName());
        clazz.setDescription(dto.getDescription());
        clazz.setPassword(dto.getPassword());
        clazz.setTime(dto.getTime());
        clazz.setBeginDate(dto.getBeginDate());
        clazz.setEndDate(dto.getEndDate());
        return clazz;
    }
}
