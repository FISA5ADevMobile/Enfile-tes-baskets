package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;

@Repository
public interface UserRepository extends JpaRepository<UserModel, Long> {

    @Modifying
    @Query(value = "INSERT INTO User_Courses (user_id, course_id) VALUES (:userId, :courseId)", nativeQuery = true)
    void addCourseToUser(@Param("userId") Long userId, @Param("courseId") Long courseId);

    Optional<UserModel> findByEmail(String email);
    Optional<UserModel> findByPseudo(String pseudo);
    List<UserModel> findAll();
}
