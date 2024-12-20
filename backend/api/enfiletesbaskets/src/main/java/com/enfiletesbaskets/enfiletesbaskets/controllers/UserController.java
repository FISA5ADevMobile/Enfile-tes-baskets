package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import jakarta.annotation.Resource;

@RestController
@RequestMapping("/api/users")
public class UserController {

    @Resource
    private UserService userService;

    // Ajoutez ici d'autres endpoints pour gérer les utilisateurs

    @GetMapping("/all")
    public List<UserModel> getAllUsers() {
        return userService.getAllUsers();
    }

    @PutMapping("/ban/{id}")
    public void banUser(@PathVariable Long id) {
        userService.banUser(id);
    }

    @PutMapping("/unban/{id}")
    public void unbanUser(@PathVariable Long id) {
        userService.unbanUser(id);
    }
}