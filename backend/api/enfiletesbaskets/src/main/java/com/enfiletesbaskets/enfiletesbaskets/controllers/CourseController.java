package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.*;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.services.ClassService;
import com.enfiletesbaskets.enfiletesbaskets.services.CourseService;
import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/courses")
public class CourseController {

    @Autowired
    private CourseService courseService;

    /**
     * Inscription à une classe via mot de passe.
     */
    @PostMapping("/subscribe/password")
    public CourseDTO subscribeToClassWithPassword(@RequestParam String classPassword, Authentication authentication) {
        return courseService.subscribeToClassWithPassword(classPassword, authentication);
    }

    /**
     * Inscription à une classe par un utilisateur authentifié.
     */
    @PostMapping("/subscribe/{classId}")
    public CourseDTO subscribeToClass(@PathVariable Long classId, Authentication authentication) {
        return courseService.subscribeToClass(classId, authentication);
    }

    /**
     * Inscription d'un utilisateur spécifique à une classe (admin uniquement).
     */
    @PostMapping("/subscribe/{classId}/user/{userId}")
    public CourseDTO subscribeUserToClass(
            @PathVariable Long classId,
            @PathVariable Long userId,
            Authentication authentication) {
        return courseService.subscribeUserToClass(classId, userId, authentication);
    }

    /**
     * Désinscription de l'utilisateur authentifié d'une classe.
     */
    @DeleteMapping("/unsubscribe/{classId}")
    public void unsubscribeFromClass(@PathVariable Long classId, Authentication authentication) {
        courseService.unsubscribeFromClass(classId, authentication);
    }

    /**
     * Désinscription d'un utilisateur spécifique d'une classe (admin uniquement).
     */
    @DeleteMapping("/unsubscribe/{classId}/user/{userId}")
    public void unsubscribeUserFromClass(
            @PathVariable Long classId,
            @PathVariable Long userId,
            Authentication authentication) {
        courseService.unsubscribeUserFromClass(classId, userId, authentication);
    }

    /**
     * Récupère les cours auxquels l'utilisateur authentifié est inscrit avec les détails de la classe.
     */
    @GetMapping("/my-classes")
    public ResponseEntity<List<CourseWithClassDTO>> getUserCoursesWithClasses(Authentication authentication) {
        List<CourseWithClassDTO> courses = courseService.getUserCoursesWithClasses(authentication);
        return ResponseEntity.ok(courses);
    }


    /**
     * Récupère les classes d'un utilisateur spécifique (admin seulement).
     */
    @GetMapping("/user-classes/{userId}")
    public ResponseEntity<List<ClassDTO>> getUserClassesById(@PathVariable Long userId, Authentication authentication) {
        List<ClassDTO> classes = courseService.getUserClassesById(userId, authentication);
        return ResponseEntity.ok(classes);
    }

    /**
     * Affiche tous les tags associés à une course spécifique avec le status.
     */
    @GetMapping("/{courseId}/tags")
    public ResponseEntity<List<CourseTagsDTO>> getTagsByCourseId(
            @PathVariable Long courseId,
            Authentication authentication) {
        List<CourseTagsDTO> courseTags = courseService.getTagsByCourse(courseId);

        return ResponseEntity.ok(courseTags);
    }

    /**
     * Met à jour une course spécifique.
     */
    @PutMapping("/{courseId}")
    public ResponseEntity<CourseDTO> updateCourse(
            @PathVariable Long courseId,
            @RequestBody CourseDTO courseDTO,
            Authentication authentication) {
        CourseDTO updatedCourse = courseService.updateCourse(courseId, courseDTO, authentication);
        return ResponseEntity.ok(updatedCourse);
    }

}
