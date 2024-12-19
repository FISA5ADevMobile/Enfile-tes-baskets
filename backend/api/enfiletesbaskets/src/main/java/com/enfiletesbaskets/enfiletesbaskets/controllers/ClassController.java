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
    private final TagService tagService;
    private final CourseService courseService;

    public ClassController(ClassService classService, TagService tagService, CourseService courseService) {
        this.classService = classService;
        this.tagService = tagService;
        this.courseService = courseService;
    }

    //récupérer les parcours auquel l'utilisateur est inscrit
    @GetMapping("/subscribed/{userId}")
    public ResponseEntity<List<Map<String, String>>> getSubscribedClasses(@PathVariable Long userId) {
        return ResponseEntity.ok(classService.getSubscribedClasses(userId));
    }

    @GetMapping("/subscribed/full/{userId}")
    public ResponseEntity<List<ClassModel>> getFullSubscribedClasses(@PathVariable Long userId) {
        return ResponseEntity.ok(classService.getFullSubscribedClasses(userId));
    }

    //On va s'inscrire à un parcours
    @PostMapping("/join/{userId}")
    public ResponseEntity<String> joinClass(
        @PathVariable Long userId,
        @RequestParam String password
    ) {
        classService.subscribeToClassByPassword(userId, password);
        return ResponseEntity.ok("Parcours rejoint");
    }

    @PostMapping("/{courseId}/tags/reset")
    public ResponseEntity<String> resetTags(@PathVariable Long courseId) {
        try {
            // On reset les tags du parcours
            courseService.resetTagsForCourse(courseId);
            return ResponseEntity.ok("Balises réinitialisées.");
        } catch (Exception e) {
            // On retourne un message d'erreur
            return ResponseEntity.badRequest().body("Erreur lors de la réinitialisation des balises : " + e.getMessage());
        }
    }
    //Validation d'une balise pour un parcours
    @PostMapping("/{classId}/courseId/{courseId}/tags/{tagId}/validate")
    public ResponseEntity<String> validateTag(
            @PathVariable Long classId,
            @PathVariable Long courseId,
            @PathVariable Long tagId,
            @RequestParam Long userId) {
        try {
            tagService.validateTag(courseId, classId, tagId);
            return ResponseEntity.ok("Balise validée.");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("Erreur lors de la validation : " + e.getMessage());
        }
    }
    
}