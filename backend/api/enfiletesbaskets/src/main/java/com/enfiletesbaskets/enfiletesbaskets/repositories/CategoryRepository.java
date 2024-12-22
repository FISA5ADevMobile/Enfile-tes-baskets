package com.enfiletesbaskets.enfiletesbaskets.repositories;

import com.enfiletesbaskets.enfiletesbaskets.models.CategoryModel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoryRepository extends JpaRepository<CategoryModel, Long> {
    // Ajoutez des méthodes personnalisées si nécessaire
}
