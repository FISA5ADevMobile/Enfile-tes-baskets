package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.UserActualityModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserActualityRepository extends JpaRepository<UserActualityModel, Long> {
    boolean existsByUserIdAndActualityId(Long userId, Long actualityId);
}

