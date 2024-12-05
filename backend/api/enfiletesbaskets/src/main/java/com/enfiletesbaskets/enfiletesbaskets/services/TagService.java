package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public class TagService {
    private final TagRepository tagRepository;
    private final CourseRepository courseRepository;

    public TagService(TagRepository tagRepository, CourseRepository courseRepository) {
        this.tagRepository = tagRepository;
        this.courseRepository = courseRepository;
    }

    // public void resetTagsForCourse(Integer courseId, Integer classId) {
    //     courseRepository.resetTagsForCourse(courseId, classId);
    // }

    public String getTagDescription(Integer tagId) {
        return tagRepository.findTagDescriptionById(tagId);
    }
    
    @Transactional
    public void validateTag(Integer courseId, Integer classId, Integer tagId) {
        // Validate the tag
        int rowsInserted = courseRepository.validateTag(courseId, classId, tagId);
        if (rowsInserted == 0) {
            throw new IllegalArgumentException("Invalid tag ID for the given class");
        }
    }
    

}
