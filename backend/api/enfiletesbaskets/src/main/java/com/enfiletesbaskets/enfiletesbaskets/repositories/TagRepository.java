package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TagRepository extends JpaRepository<TagModel, Long> {

    // Fetch all tags for a specific class
    @Query(value = """
        SELECT t.id, t.name, t.description, t.xPos, t.yPos 
        FROM tag t JOIN class_tags ct ON t.id = ct.tag_id 
        WHERE ct.class_id = :classId""", 
           nativeQuery = true)
    List<Object[]> findAllByClassId(@Param("classId") Long classId);

    // Fetch all tags validated by a specific user (through their courses)
    @Query(value = "SELECT DISTINCT t.* FROM tag t " +
                   "JOIN course_tags ct ON t.id = ct.tag_id " +
                   "JOIN course c ON ct.course_id = c.id " +
                   "WHERE c.userdb = :userId " +
                   "AND c.id= :courseId"
                   , 
           nativeQuery = true)
    List<TagModel> findAllByUserId(@Param("userId") Long userId,@Param("courseId") Long courseId);

    // Fetch all tags for a specific class and validated by a specific user
    @Query(value = "SELECT t.* FROM tag t " +
                   "JOIN class_tags clt ON t.id = clt.tag_id " +
                   "JOIN course_tags crt ON t.id = crt.tag_id " +
                   "JOIN course c ON crt.course_id = c.id " +
                   "WHERE clt.class_id = :classId AND c.userdb = :userId", 
           nativeQuery = true)
    List<TagModel> findAllByClassIdAndUserId(@Param("classId") Long classId, @Param("userId") Long userId);


    // Fetch all tags for a specific course and validated
    @Query(value = """
        SELECT t.id, t.name, t.description, t.xPos, t.yPos FROM tag t   
                   JOIN course_tags crt ON t.id = crt.tag_id 
                   WHERE crt.course_id = :courseId""", 
           nativeQuery = true)
    List<Object[]> findAllByCourseId(@Param("courseId") Long courseId);

    // Fetch a specific tag validated by a specific user
    @Query(value = "SELECT t.* FROM tag t " +
                   "JOIN course_tags ct ON t.id = ct.tag_id " +
                   "JOIN course c ON ct.course_id = c.id " +
                   "WHERE t.id = :tagId AND c.userdb = :userId", 
           nativeQuery = true)
    Optional<TagModel> findByIdAndUserId(@Param("tagId") Long tagId, @Param("userId") Long userId);

    // Fetch description for a tag
    @Query(value = "SELECT description FROM tag WHERE id = :tagId", nativeQuery = true)
    String findTagDescriptionById(@Param("tagId") Long tagId);
}
