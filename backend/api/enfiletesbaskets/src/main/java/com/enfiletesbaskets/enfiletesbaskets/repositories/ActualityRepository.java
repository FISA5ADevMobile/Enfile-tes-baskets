package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ActualityRepository extends JpaRepository<ActualityModel, Integer> {
    // Ajoutez des méthodes personnalisées si nécessaire
}
