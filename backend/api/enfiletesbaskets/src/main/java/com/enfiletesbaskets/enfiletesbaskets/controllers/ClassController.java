package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel; 
import com.enfiletesbaskets.enfiletesbaskets.services.ClassService;
import com.enfiletesbaskets.enfiletesbaskets.services.CourseService;
import com.enfiletesbaskets.enfiletesbaskets.services.TagService;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/classes")
public class ClassController {
    private final ClassService classService;
    private final TagService tagService; // Add TagService as a dependency
    private final CourseService courseService; // Add CourseService as a dependency

    public ClassController(ClassService classService, TagService tagService, CourseService courseService) {
        this.classService = classService;
        this.tagService = tagService; // Initialize TagService
        this.courseService = courseService; // Initialize CourseService
    }

    @GetMapping("/subscribed/{userId}")
    public ResponseEntity<List<Map<String, String>>> getSubscribedClasses(@PathVariable Long userId) {
        return ResponseEntity.ok(classService.getSubscribedClasses(userId));
    }

    @GetMapping("/subscribed/full/{userId}")
    public ResponseEntity<List<ClassModel>> getFullSubscribedClasses(@PathVariable Long userId) {
        return ResponseEntity.ok(classService.getFullSubscribedClasses(userId));
    }

    @PostMapping("/join/{userId}")
    public ResponseEntity<String> joinClass(
        @PathVariable Long userId,
        @RequestParam String password
    ) {
        classService.subscribeToClassByPassword(userId, password);
        return ResponseEntity.ok("User added to class and tags initialized.");
    }

    @PostMapping("/{courseId}/tags/reset")
    public ResponseEntity<String> resetTags(@PathVariable Long courseId) {
        try {
            // Call the resetTagsForCourse method from CourseService
            courseService.resetTagsForCourse(courseId);
            return ResponseEntity.ok("Tags reset successfully.");
        } catch (Exception e) {
            // Return an error message if something goes wrong
            return ResponseEntity.badRequest().body("Error resetting tags: " + e.getMessage());
        }
    }

    @PostMapping("/{classId}/courseId/{courseId}/tags/{tagId}/validate")
    public ResponseEntity<String> validateTag(
            @PathVariable Long classId,
            @PathVariable Long courseId,
            @PathVariable Long tagId,
            @RequestParam Long userId) {
        try {
            // Long courseId = classService.getCourseIdForUserAndClass(userId, classId);
            tagService.validateTag(courseId, classId, tagId);
            return ResponseEntity.ok("Tag validated successfully.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Error validating tag: " + e.getMessage());
        }
    }
    
}