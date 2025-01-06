package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class CourseService {

    @Resource
    private CourseRepository courseRepository;

    @Transactional
    public void resetTagsForCourse(Long courseId) {
        courseRepository.resetTagsForCourse(courseId);
    }

    public Long getCourseIdForUserAndClass(Long userId, Long classId) {
        return courseRepository.findCourseIdByUserAndClass(userId, classId)
                .orElseThrow(() -> new IllegalArgumentException("Pas de course trouvée pour cet utilisateur."));
    }
    
    
}
