package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ClassRepository extends JpaRepository<ClassModel, Long> {
    Optional<ClassModel> findByPassword(String password);
    boolean existsByPassword(String password);
    Optional<ClassModel> findById(Long id);
}
