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
    public String getTagDescription(Long tagId) {
        return tagRepository.findTagDescriptionById(tagId);
    }
    
    @Transactional
    public void validateTag(Long courseId, Long classId, Long tagId) {
        // Validation du tag
        boolean alreadyValidated = courseRepository.isValidatedTag(courseId, tagId);
        if (alreadyValidated) {
            throw new IllegalArgumentException("La balise est déjà validée");
        }
        int rowsInserted = courseRepository.validateTag(courseId, classId, tagId);
        if (rowsInserted == 0) {
            throw new IllegalArgumentException("Cette balise ne fait pas partie du parcours");
        }
    }
    

}
