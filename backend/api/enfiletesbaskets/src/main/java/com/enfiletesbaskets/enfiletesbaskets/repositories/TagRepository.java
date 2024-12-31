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

    // On récupère toutes les balises faisant parti d'un parcours
    @Query(value = """
        SELECT t.id, t.name, t.description, t.xPos, t.yPos 
        FROM tag t JOIN class_tags ct ON t.id = ct.tag_id 
        WHERE ct.class_id = :classId""", 
           nativeQuery = true)
    List<Object[]> findAllByClassId(@Param("classId") Long classId);


    // On récupère toutes les balises validées par un utilisateur
    @Query(value = """
        SELECT t.id, t.name, t.description, t.xPos, t.yPos FROM tag t   
                   JOIN course_tags crt ON t.id = crt.tag_id 
                   WHERE crt.course_id = :courseId""", 
           nativeQuery = true)
    List<Object[]> findAllByCourseId(@Param("courseId") Long courseId);

    // On récupère une balise spécifique validée par un utilisateur lors d'un parcours
    @Query(value = "SELECT t.* FROM tag t " +
                   "JOIN course_tags ct ON t.id = ct.tag_id " +
                   "JOIN course c ON ct.course_id = c.id " +
                   "WHERE t.id = :tagId AND c.userdb = :userId", 
           nativeQuery = true)
    Optional<TagModel> findByIdAndUserId(@Param("tagId") Long tagId, @Param("userId") Long userId);

    // Récupérer la description pour un tag
    @Query(value = "SELECT description FROM tag WHERE id = :tagId", nativeQuery = true)
    String findTagDescriptionById(@Param("tagId") Long tagId);
}
