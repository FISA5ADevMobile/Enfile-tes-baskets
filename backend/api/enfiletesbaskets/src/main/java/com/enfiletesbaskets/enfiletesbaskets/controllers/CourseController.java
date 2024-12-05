package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
@RestController
@RequestMapping("/courses")
public class CourseController {

    private final CourseRepository courseRepository;

    public CourseController(CourseRepository courseRepository) {
        this.courseRepository = courseRepository;
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<Long> getCourseIdByUserAndClass(
        @PathVariable Long userId,
        @RequestParam Long classId
    ) {
        Optional<Long> courseId = courseRepository.findCourseIdByUserAndClass(userId, classId);
        return courseId.map(ResponseEntity::ok)
                       .orElse(ResponseEntity.notFound().build());
    }
}