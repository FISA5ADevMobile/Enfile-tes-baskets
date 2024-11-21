package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.ClassRepository;
import org.springframework.stereotype.Service;
import jakarta.annotation.Resource;

@Service
public class ClassService {

    @Resource
    private ClassRepository classRepository;

    // Ajoutez des méthodes et des dépendances si nécessaire
}
