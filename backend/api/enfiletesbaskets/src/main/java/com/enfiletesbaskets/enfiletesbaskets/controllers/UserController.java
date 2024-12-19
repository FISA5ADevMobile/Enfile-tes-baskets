package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Resource
    private UserService userService;

    // Ajoutez ici d'autres endpoints pour gérer les utilisateurs
}