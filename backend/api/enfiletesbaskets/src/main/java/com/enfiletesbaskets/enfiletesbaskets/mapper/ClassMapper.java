package com.enfiletesbaskets.enfiletesbaskets.mapper;

import com.enfiletesbaskets.enfiletesbaskets.dto.ClassCreate;
import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;

import java.util.List;
import java.util.stream.Collectors;

public class ClassMapper {

    public static ClassModel toEntity(ClassCreate dto, UserModel owner, List<TagModel> tags, List<CourseModel> courses) {
        ClassModel classModel = new ClassModel();
        System.out.println("Owner : " + owner);
        System.out.println("Tags : " + tags);
        System.out.println("Courses : " + courses);
        classModel.setName(dto.getName());
        classModel.setDescription(dto.getDescription());
        classModel.setOwner(owner);
        classModel.setPassword(dto.getPassword());
        classModel.setTime(dto.getTime());
        classModel.setBeginDate(dto.getBeginDate());
        classModel.setEndDate(dto.getEndDate());
        classModel.setTags(tags);
        classModel.setCourses(courses);
        System.out.println("ClassMapper.toEntity: " + classModel);

        return classModel;
    }

    public static ClassCreate toDTO(ClassModel classModel) {
        ClassCreate dto = new ClassCreate();
        dto.setName(classModel.getName());
        dto.setDescription(classModel.getDescription());
        dto.setOwnerId(classModel.getOwner() != null ? classModel.getOwner().getId() : null);
        dto.setPassword(classModel.getPassword());
        dto.setTime(classModel.getTime());
        dto.setBeginDate(classModel.getBeginDate());
        dto.setEndDate(classModel.getEndDate());

        // Convertir les listes d'entités en listes d'IDs
        dto.setTagIds(classModel.getTags() != null ?
                classModel.getTags().stream().map(TagModel::getId).collect(Collectors.toList()) : null);
        dto.setCourseIds(classModel.getCourses() != null ?
                classModel.getCourses().stream().map(CourseModel::getId).collect(Collectors.toList()) : null);

        return dto;
    }
}
