package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.services.CourseService;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/courses")
public class CourseController {

    @Resource
    private CourseService courseService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire
}
