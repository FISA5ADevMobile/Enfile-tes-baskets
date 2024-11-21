package com.enfiletesbaskets.enfiletesbaskets.controllers;
import com.enfiletesbaskets.enfiletesbaskets.services.CommunityService;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/communities")
public class CommunityController {

    @Resource
    private CommunityService communityService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire
}
