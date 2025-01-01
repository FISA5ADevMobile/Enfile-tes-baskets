package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.CourseTagValidationDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseTagValidation;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseTagValidationRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CourseTagValidationService {

    @Autowired
    private  CourseTagValidationRepository validationRepository;
    @Autowired
    private  CourseRepository courseRepository;
    @Autowired
    private  TagRepository tagRepository;
    @Autowired
    private  UserService userService;

    /**
     * Valide un tag pour une course spécifique.
     */
    public CourseTagValidationDTO validateTag(Long courseId, Long tagId, Authentication authentication) {
        UserModel user = userService.authenticate(authentication);

        // Récupération de la course
        CourseModel course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course non trouvée avec l'ID : " + courseId));

        // Vérification que l'utilisateur est bien inscrit à la course
        if (!course.getUser().getId().equals(user.getId())) {
            throw new RuntimeException("Vous n'êtes pas inscrit à cette course.");
        }

        // Récupération du tag
        TagModel tag = tagRepository.findById(tagId)
                .orElseThrow(() -> new RuntimeException("Tag non trouvé avec l'ID : " + tagId));

        // Vérifier si le tag est déjà validé
        Optional<CourseTagValidation> existingValidation = validationRepository.findByCourseIdAndTagId(courseId, tagId);
        if (existingValidation.isPresent()) {
            throw new RuntimeException("Ce tag est déjà validé pour cette course.");
        }

        // Créer une nouvelle validation
        CourseTagValidation validation = new CourseTagValidation(course, tag);
        CourseTagValidation savedValidation = validationRepository.save(validation);

        return CourseTagValidationDTO.toDTO(savedValidation);
    }

    /**
     * Récupère les tags validés pour une course spécifique.
     */
    public List<TagDTO> getValidatedTagsByCourseId(Long courseId) {
        List<CourseTagValidation> validations = validationRepository.findByCourseId(courseId);

        return validations.stream()
                .map(validation -> TagDTO.toDTO(validation.getTag()))
                .collect(Collectors.toList());
    }
}
