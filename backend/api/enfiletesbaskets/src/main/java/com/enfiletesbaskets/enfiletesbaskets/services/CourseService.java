package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.ClassDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CourseDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CourseTagsDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.ClassRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseTagValidationRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class CourseService {

    @Autowired
    private CourseRepository courseRepository;

    @Autowired
    private ClassRepository classRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CourseTagValidationRepository validationRepository;

    @Autowired
    private UserService userService;

    /**
     * Inscription d'un utilisateur authentifié à une classe.
     */
    public CourseDTO subscribeToClass(Long classId, Authentication authentication) {
        UserModel user = userService.authenticate(authentication);
        return subscribeUserToClass(classId, user);
    }

    /**
     * Inscription d'un utilisateur spécifique à une classe (Admin seulement).
     */
    public CourseDTO subscribeUserToClass(Long classId, Long userId, Authentication authentication) {
        UserModel admin = userService.authenticate(authentication);

        if (!"ADMIN".equals(admin.getRole())) {
            throw new RuntimeException("Seuls les administrateurs peuvent inscrire d'autres utilisateurs.");
        }

        UserModel user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé avec l'ID : " + userId));

        return subscribeUserToClass(classId, user);
    }

    /**
     * Logique partagée pour inscrire un utilisateur à une classe.
     */
    private CourseDTO subscribeUserToClass(Long classId, UserModel user) {
        ClassModel clazz = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée avec l'ID : " + classId));

        // Vérifier si l'utilisateur est déjà inscrit
        Optional<CourseModel> existingCourse = courseRepository.findByUserAndClassModel(user, clazz);
        if (existingCourse.isPresent()) {
            throw new RuntimeException("L'utilisateur est déjà inscrit à cette classe.");
        }

        CourseModel course = new CourseModel();
        course.setUser(user);
        course.setClassModel(clazz);
        course.setBeginDate(LocalDate.now());
        course.setEndDate(clazz.getEndDate());

        CourseModel savedCourse = courseRepository.save(course);

        return CourseDTO.toDTO(savedCourse);
    }

    /**
     * Inscription à une classe via mot de passe.
     */
    public CourseDTO subscribeToClassWithPassword(String classPassword, Authentication authentication) {
        UserModel user = userService.authenticate(authentication);

        // Rechercher la classe par mot de passe
        ClassModel clazz = classRepository.findByPassword(classPassword)
                .orElseThrow(() -> new RuntimeException("Aucune classe trouvée avec ce mot de passe."));

        // Vérifier si l'utilisateur est déjà inscrit
        boolean isAlreadyEnrolled = courseRepository.findByUserAndClassModel(user, clazz).isPresent();
        if (isAlreadyEnrolled) {
            throw new RuntimeException("Vous êtes déjà inscrit à cette classe.");
        }

        // Créer une nouvelle course
        CourseModel course = new CourseModel();
        course.setUser(user);
        course.setClassModel(clazz);
        course.setBeginDate(clazz.getBeginDate() != null ? clazz.getBeginDate() : LocalDate.now());
        course.setEndDate(clazz.getEndDate());

        CourseModel savedCourse = courseRepository.save(course);

        // Retourner un DTO
        return CourseDTO.toDTO(savedCourse);
    }

    /**
     * Désinscrire un utilisateur authentifié d'une classe.
     */
    public void unsubscribeFromClass(Long classId, Authentication authentication) {
        UserModel user = userService.authenticate(authentication);
        unsubscribeUserFromClass(classId, user);
    }

    /**
     * Désinscrire un utilisateur spécifique d'une classe (admin uniquement).
     */
    public void unsubscribeUserFromClass(Long classId, Long userId, Authentication authentication) {
        UserModel admin = userService.authenticate(authentication);

        if (!"ADMIN".equals(admin.getRole())) {
            throw new RuntimeException("Seuls les administrateurs peuvent désinscrire d'autres utilisateurs.");
        }

        UserModel user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé avec l'ID : " + userId));

        unsubscribeUserFromClass(classId, user);
    }

    /**
     * Logique partagée pour désinscrire un utilisateur d'une classe.
     */
    private void unsubscribeUserFromClass(Long classId, UserModel user) {
        ClassModel clazz = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée avec l'ID : " + classId));

        CourseModel course = courseRepository.findByUserAndClassModel(user, clazz)
                .orElseThrow(() -> new RuntimeException("L'utilisateur n'est pas inscrit à cette classe."));

        courseRepository.delete(course);
    }

    /**
     * Récupère les classes auxquelles l'utilisateur authentifié est inscrit.
     */
    public List<ClassDTO> getUserClasses(Authentication authentication) {
        UserModel user = userService.authenticate(authentication);

        List<CourseModel> userCourses = courseRepository.findByUserId(user.getId());

        return userCourses.stream()
                .map(course -> ClassDTO.toDTO(course.getClassModel()))
                .collect(Collectors.toList());
    }

    /**
     * Récupère les classes d'un utilisateur spécifique (admin seulement).
     */
    public List<ClassDTO> getUserClassesById(Long userId, Authentication authentication) {
        UserModel adminUser = userService.authenticate(authentication);

        // Vérification si l'utilisateur est un administrateur
        if (!"ADMIN".equals(adminUser.getRole())) {
            throw new AccessDeniedException("Vous n'avez pas les droits pour effectuer cette action.");
        }

        UserModel user = userRepository.findById(userId)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé avec l'ID : " + userId));

        List<CourseModel> userCourses = courseRepository.findByUserId(user.getId());

        return userCourses.stream()
                .map(course -> ClassDTO.toDTO(course.getClassModel()))
                .collect(Collectors.toList());
    }
    
    /**
     * Récupère tous les tags liés à une course avec leur statut.
     */
    public List<CourseTagsDTO> getTagsByCourse(Long courseId) {
        CourseModel course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course non trouvée avec l'ID : " + courseId));

        List<TagModel> allTags = course.getClassModel().getTags();

        List<Long> validatedTagIds = validationRepository.findByCourseId(courseId)
                .stream()
                .map(validation -> validation.getTag().getId())
                .collect(Collectors.toList());
        System.out.println("Les tags validés sont "+ validatedTagIds);
        System.out.println("All tags est "+ allTags);

        return allTags.stream()
                .map(tag -> CourseTagsDTO.from(tag, validatedTagIds.contains(tag.getId())))
                .collect(Collectors.toList());
    }

    /**
     * Met à jour une course si l'utilisateur est inscrit ou est un administrateur.
     */
    public CourseDTO updateCourse(Long courseId, CourseDTO courseDTO, Authentication authentication) {
        UserModel user = userService.authenticate(authentication);

        CourseModel course = courseRepository.findById(courseId)
                .orElseThrow(() -> new RuntimeException("Course non trouvée avec l'ID : " + courseId));

        // Vérifier si l'utilisateur est le propriétaire de la course ou un administrateur
        if (!course.getUser().getId().equals(user.getId()) && !"ADMIN".equals(user.getRole())) {
            throw new RuntimeException("Vous n'avez pas les droits pour modifier cette course.");
        }

        // Mise à jour des informations
        if (courseDTO.getBeginDate() != null) {
            course.setBeginDate(courseDTO.getBeginDate());
        }
        if (courseDTO.getEndDate() != null) {
            course.setEndDate(courseDTO.getEndDate());
        }

        CourseModel updatedCourse = courseRepository.save(course);
        return CourseDTO.toDTO(updatedCourse);
    }



}
