package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.services.ClassService;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/classes")
public class ClassController {

    @Resource
    private ClassService classService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire
}
