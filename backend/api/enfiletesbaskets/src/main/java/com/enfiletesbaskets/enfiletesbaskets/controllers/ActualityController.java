package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.services.ActualityService;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/actualities")
public class ActualityController {

    @Resource
    private ActualityService actualityService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire
}
