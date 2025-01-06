package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;

import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.services.CourseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
@RestController
@RequestMapping("/api/courses")
public class CourseController {

    private final CourseService courseService;
    private final CourseRepository courseRepository;

    public CourseController(CourseService courseService, CourseRepository courseRepository) {
        this.courseService = courseService;
        this.courseRepository = courseRepository;
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<Long> getCourseIdByUserAndClass(
        @PathVariable Long userId,
        @RequestParam Long classId
    ) {
        try {
            Long courseId = courseService.getCourseIdForUserAndClass(userId, classId);
            return ResponseEntity.ok(courseId);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.notFound().build();
        }
    }

    @GetMapping("/{courseId}")
    public ResponseEntity<CourseModel> getCourse(@PathVariable Long courseId) {
        return courseRepository.findById(courseId)
                               .map(ResponseEntity::ok)
                               .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/all")
    public ResponseEntity<List<CourseModel>> getAllCourses() {
        return ResponseEntity.ok(courseRepository.findAll());
    }

}