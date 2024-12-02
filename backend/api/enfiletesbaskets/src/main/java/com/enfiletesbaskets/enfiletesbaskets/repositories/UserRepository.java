package com.enfiletesbaskets.enfiletesbaskets.repositories;


import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends CrudRepository<UserModel, Long> {

}
