package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.ClassRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;

import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;
import org.springframework.transaction.annotation.Transactional;

@Service
public class ClassService {
    private final ClassRepository classRepository;
    private final CourseRepository courseRepository;
    private final UserRepository userRepository;

    public ClassService(ClassRepository classRepository, CourseRepository courseRepository, UserRepository userRepository) {
        this.classRepository = classRepository;
        this.courseRepository = courseRepository;
        this.userRepository = userRepository;
    }

    // Fetch all subscribed classes and return filtered fields
    public List<Map<String, String>> getSubscribedClasses(Long userId) {
        return classRepository.findSubscribedClassesByUserId(userId).stream()
                .map(classModel -> Map.of(
                        "id", String.valueOf(classModel.getId()), // Include ID
                        "name", classModel.getName(),
                        "description", classModel.getDescription()
                ))
                .collect(Collectors.toList());
    }

    // Fetch all subscribed classes as full ClassModel objects
    public List<ClassModel> getFullSubscribedClasses(Long userId) {
        return classRepository.findSubscribedClassesByUserId(userId);
    }

    public Long getCourseIdForUserAndClass(Long userId, Long classId) {
        return courseRepository.findCourseIdByUserAndClass(userId, classId)
                .orElseThrow(() -> new IllegalArgumentException("Course not found for the user in this class"));
    }

    // S'inscrire à un parcours à l'aide du code
    @Transactional
    public void subscribeToClassByPassword(Long userId, String password) {
        Optional<ClassModel> classOptional = classRepository.findByPassword(password);
        if (classOptional.isEmpty()) {
            throw new IllegalArgumentException("Pas de parcours associé à ce code.");
        }

        Long classId = classOptional.get().getId();

        if (courseRepository.existsByUserAndClass(userId, classId)) {
            throw new IllegalStateException("Déjà inscrit au parcours.");
        }

        CourseModel course = new CourseModel();
        course.setUser(new UserModel(userId));
        course.setBeginDate(LocalDate.now());
        course.setEndDate(LocalDate.now().plusMonths(1)); 
        courseRepository.save(course);

        userRepository.addCourseToUser(userId, course.getId());
        classRepository.addCourseToClass(classId, course.getId());
    }

    public List<ClassModel> getAllClasses() {
        return classRepository.findAll();
    }

    public ClassModel getClassById(Long id) {
        return classRepository.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Parcours non trouvé."));
    }

    public void deleteClass(Long courseId) {
        classRepository.deleteById(courseId);
    }

    public ClassModel createClass(ClassModel classModel) {
        return classRepository.save(classModel);
    }

    public void save(ClassModel classModel) {
        classRepository.save(classModel);
    }
}
