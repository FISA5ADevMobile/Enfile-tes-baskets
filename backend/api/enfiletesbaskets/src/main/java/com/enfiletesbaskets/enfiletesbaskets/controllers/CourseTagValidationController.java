package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.CourseTagValidationDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseTagValidation;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.services.CourseTagValidationService;
import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/validations")
public class CourseTagValidationController {

    private final CourseTagValidationService validationService;
    private final UserService userService;

    public CourseTagValidationController(CourseTagValidationService validationService, UserService userService) {
        this.validationService = validationService;
        this.userService = userService;
    }

    /**
     * Valide un tag pour une course spécifique.
     */
    @PostMapping("/{courseId}/tags/{tagId}/validate")
    public ResponseEntity<CourseTagValidationDTO> validateTag(
            @PathVariable Long courseId,
            @PathVariable Long tagId,
            Authentication authentication) {
        CourseTagValidationDTO validation = validationService.validateTag(courseId, tagId, authentication);
        return ResponseEntity.ok(validation);
    }

    /**
     * Récupère les tags validés pour une course spécifique.
     */
    @GetMapping("/{courseId}/validated-tags")
    public List<TagDTO> getValidatedTagsByCourseId(@PathVariable Long courseId) {
        return validationService.getValidatedTagsByCourseId(courseId);
    }

    /**
     * Réinitialise les tags pour une course spécifique.
     */
    @PutMapping("/{courseId}/reset")
    public ResponseEntity<Void> resetTags(@PathVariable Long courseId, Authentication authentication) {
        validationService.resetTags(courseId, authentication);
        return ResponseEntity.ok().build();
    }

}
