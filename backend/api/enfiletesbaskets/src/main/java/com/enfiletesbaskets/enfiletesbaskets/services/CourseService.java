package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.CourseRepository;
import org.springframework.stereotype.Service;
import jakarta.annotation.Resource;

@Service
public class CourseService {

    @Resource
    private CourseRepository courseRepository;

    // Ajoutez des méthodes et des dépendances si nécessaire
}
