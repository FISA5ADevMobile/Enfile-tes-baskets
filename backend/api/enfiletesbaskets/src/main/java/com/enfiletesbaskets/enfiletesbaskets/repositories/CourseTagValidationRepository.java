package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.CourseTagValidation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CourseTagValidationRepository extends JpaRepository<CourseTagValidation, Long> {
    Optional<CourseTagValidation> findByCourseIdAndTagId(Long courseId, Long tagId);
    List<CourseTagValidation> findByCourseId(Long courseId);

}
