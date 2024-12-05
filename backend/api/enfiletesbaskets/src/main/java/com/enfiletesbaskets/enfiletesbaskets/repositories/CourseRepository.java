package com.enfiletesbaskets.enfiletesbaskets.repositories;
import com.enfiletesbaskets.enfiletesbaskets.models.CourseModel;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CourseRepository extends JpaRepository<CourseModel, Integer> {
    @Modifying
    @Query(value = "DELETE FROM Course_Tags WHERE course_id = :courseId", nativeQuery = true)
    void resetTagsForCourse(@Param("courseId") Integer courseId);

    @Query("SELECT c.id FROM CourseModel c " +
    "JOIN c.classes cl " +
    "WHERE c.user.id = :userId AND cl.id = :classId")
    Optional<Integer> findCourseIdByUserAndClass(@Param("userId") Integer userId, @Param("classId") Integer classId);

    @Query(value = "SELECT EXISTS(SELECT 1 FROM User_Courses uc " +
               "JOIN Class_Courses cc ON uc.course_id = cc.course_id " +
               "WHERE uc.user_id = :userId AND cc.class_id = :classId)", nativeQuery = true)
    boolean existsByUserAndClass(@Param("userId") Integer userId, @Param("classId") Integer classId);

    @Query("SELECT c FROM CourseModel c WHERE c.user.id = :userId")
    List<CourseModel> findAllByUserId(@Param("userId") Integer userId);

    @Modifying
    @Query(value = "INSERT INTO Course_Tags (tag_id, course_id) " +
                   "SELECT :tagId, :courseId FROM Class_Tags " +
                   "WHERE class_id = :classId AND tag_id = :tagId", nativeQuery = true)
    int validateTag(@Param("courseId") Integer courseId, @Param("classId") Integer classId, @Param("tagId") Integer tagId);
    
}
