package com.enfiletesbaskets.enfiletesbaskets.repositories;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;

@Repository
public interface UserRepository extends JpaRepository<UserModel, Integer> {

    @Modifying
    @Query(value = "INSERT INTO User_Courses (user_id, course_id) VALUES (:userId, :courseId)", nativeQuery = true)
    void addCourseToUser(@Param("userId") Integer userId, @Param("courseId") Integer courseId);
    

}
