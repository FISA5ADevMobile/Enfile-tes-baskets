package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.repositories.PostRepository;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;

@Service
public class PostService {

    @Resource
    private PostRepository postRepository;

    // Ajoutez des méthodes et des dépendances si nécessaire
}
