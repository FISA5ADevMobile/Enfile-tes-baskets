package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.services.TagService;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/tags")
public class TagController {

    @Resource
    private TagService tagService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire
}
