package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

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
    public List<Map<String, Object>> getTagsByClass(Long classId) {
        List<Object[]> results = tagRepository.findAllByClassId(classId);
        return mapTagResults(results);
    }
    public List<Map<String, Object>> getTagsByCourse(Long courseId) {
        List<Object[]> results = tagRepository.findAllByCourseId(courseId);
        return mapTagResults(results);
    }
    public Optional<TagModel> getTagByIdAndUser(Long tagId, Long userId) {
        return tagRepository.findByIdAndUserId(tagId, userId);
    }

    private List<Map<String, Object>> mapTagResults(List<Object[]> results) {
        return results.stream().map(row -> {
            if (row.length < 5) {
                throw new IllegalStateException("Pas la bonne structure.");
            }
            Map<String, Object> tag = new HashMap<>();
            tag.put("id", row[0]);
            tag.put("name", row[1]);
            tag.put("description", row[2]);
            tag.put("xPos", row[3]);
            tag.put("yPos", row[4]);
            return tag;
        }).collect(Collectors.toList());
    }

    public List<TagModel> findByIds(List<Long> tagIds) {
        return tagRepository.findAllById(tagIds);
    }
}
