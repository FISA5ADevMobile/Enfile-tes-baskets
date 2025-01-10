package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface CourseRepository extends JpaRepository<CourseModel, Long> {
    Optional<CourseModel> findByUserAndClassModel(UserModel user, ClassModel classModel);
    List<CourseModel> findByUserId(Long userId);
    Optional<CourseModel> findById(Long id);
}
