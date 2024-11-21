package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.services.PostService;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/posts")
public class PostController {

    @Resource
    private PostService postService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire
}
