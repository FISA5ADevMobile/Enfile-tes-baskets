package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserActualityModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserActualityRepository extends JpaRepository<UserActualityModel, Long> {
    // Aucun besoin de méthodes personnalisées pour le moment
}

