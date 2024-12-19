package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;


public interface UserRepository extends JpaRepository<UserModel, Long> {
    UserModel findByEmail(String email);
    Optional<UserModel> findByPseudo(String pseudo);
    List<UserModel> findAll();
}
