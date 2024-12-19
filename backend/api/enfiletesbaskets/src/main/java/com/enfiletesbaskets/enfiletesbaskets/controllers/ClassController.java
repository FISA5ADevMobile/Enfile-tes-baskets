package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.ClassCreate;
import com.enfiletesbaskets.enfiletesbaskets.mapper.ClassMapper;
import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.services.ClassService;
import com.enfiletesbaskets.enfiletesbaskets.services.CourseService;
import com.enfiletesbaskets.enfiletesbaskets.services.TagService;

import java.util.List;
import java.util.Map;

import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import jakarta.validation.Valid;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/classes")
public class    ClassController {
    private final ClassService classService;
    private final TagService tagService;
    private final CourseService courseService;
    private final UserService userService;

    public ClassController(ClassService classService, TagService tagService, CourseService courseService, UserService userService) {
        this.classService = classService;
        this.tagService = tagService;
        this.courseService = courseService;
        this.userService = userService;
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

    @GetMapping("/all")
    public ResponseEntity<List<ClassModel>> getAllClasses() {
        return ResponseEntity.ok(classService.getAllClasses());
    }

    @GetMapping("/{classId}")
    public ResponseEntity<ClassModel> getClassById(@PathVariable Long classId) {
        return ResponseEntity.ok(classService.getClassById(classId));
    }

    @DeleteMapping("/delete/{classId}")
    public ResponseEntity<String> deleteClass(@PathVariable Long classId) {
        classService.deleteClass(classId);
        return ResponseEntity.ok("Parcours supprimé.");
    }

//    // Not working at the moment
//    @PostMapping("/create")
//    public ResponseEntity<?> createClass(@RequestBody @Valid ClassCreate classCreateDTO) {
//        System.out.println(classCreateDTO);
//        // Charger l'utilisateur propriétaire à partir de l'ID
//        UserModel owner = userService.findById(classCreateDTO.getOwnerId());
//        if (owner == null) {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Owner not found with ID: " + classCreateDTO.getOwnerId());
//        }
//
//        // Charger les tags et les cours si nécessaires (exemples ci-dessous)
//        List<TagModel> tags = tagService.findByIds(classCreateDTO.getTagIds());
//
//        if (tags.size() != classCreateDTO.getTagIds().size()) {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Some tags not found");
//        }
//
//        List<CourseModel> courses = courseService.findByIds(classCreateDTO.getCourseIds());
//
//        if (courses.size() != classCreateDTO.getCourseIds().size()) {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("Some courses not found");
//        }
//
//        // Mapper le DTO vers l'entité
//        ClassModel classModel = ClassMapper.toEntity(classCreateDTO, owner, tags, courses);
//
//        // Sauvegarder l'entité
//        classService.save(classModel);
//
//        return ResponseEntity.ok("Class created successfully!");
//    }


}