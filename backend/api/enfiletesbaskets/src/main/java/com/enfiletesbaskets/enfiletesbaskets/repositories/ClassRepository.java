package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;

import java.util.List;
import java.util.Optional; // Ajout de cet import

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface ClassRepository extends JpaRepository<ClassModel, Long> {
    @Query(value = "SELECT c.* " +
                   "FROM Class c " +
                   "JOIN Class_Courses cc ON c.id = cc.class_id " +
                   "JOIN User_Courses uc ON cc.course_id = uc.course_id " +
                   "WHERE uc.user_id = :userId", nativeQuery = true)
    List<ClassModel> findSubscribedClassesByUserId(@Param("userId") Long userId);

    @Query("SELECT c FROM ClassModel c WHERE c.password = :password")
    Optional<ClassModel> findByPassword(@Param("password") String password);

    @Modifying
    @Query(value = "INSERT INTO Class_Courses (class_id, course_id) VALUES (:classId, :courseId)", nativeQuery = true)
    void addCourseToClass(@Param("classId") Long classId, @Param("courseId") Long courseId);
}
