package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.CategoryRepository;
import org.springframework.stereotype.Service;
import jakarta.annotation.Resource;

@Service
public class CategoryService {

    @Resource
    private CategoryRepository categoryRepository;

    // Ajoutez des méthodes et des dépendances si nécessaire
}
