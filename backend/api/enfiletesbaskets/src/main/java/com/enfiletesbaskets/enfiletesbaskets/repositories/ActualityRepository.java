package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ActualityRepository extends CrudRepository<ActualityModel, Long> {
    List<ActualityModel> findAll();
    // Ajoutez des méthodes personnalisées si nécessaire
}
