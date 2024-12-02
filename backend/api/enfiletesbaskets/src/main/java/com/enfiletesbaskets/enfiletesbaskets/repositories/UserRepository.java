package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;


public interface UserRepository extends CrudRepository<UserModel, Long> {
    UserModel findByEmail(String email);
    Optional<UserModel> findByPseudo(String pseudo);
    List<UserModel> findAll();
}
