package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;

import com.enfiletesbaskets.enfiletesbaskets.services.CourseService;
import jakarta.annotation.Resource;
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

    @Resource
    private CourseService courseService;

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
}