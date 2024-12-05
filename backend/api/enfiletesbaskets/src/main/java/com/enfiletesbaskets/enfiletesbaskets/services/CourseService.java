package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class CourseService {
    private final CourseRepository courseRepository;

    public CourseService(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @Transactional
    public void resetTagsForCourse(Long courseId) {
        courseRepository.resetTagsForCourse(courseId);
    }

    public Long getCourseIdForUserAndClass(Long userId, Long classId) {
        return courseRepository.findCourseIdByUserAndClass(userId, classId)
                .orElseThrow(() -> new IllegalArgumentException("No course found for the user in this class."));
    }
    
    
}
