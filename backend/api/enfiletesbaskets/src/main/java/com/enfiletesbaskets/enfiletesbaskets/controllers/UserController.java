package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

import jakarta.annotation.Resource;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

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

    // Récupérer les informations de l'utilisateur actuel + token
    @GetMapping("/me")
    public Map<String, Object> getCurrentUser(HttpServletRequest request) {
        // Récupère l'authentification
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

        if (authentication == null || !authentication.isAuthenticated()) {
            throw new RuntimeException("Utilisateur non authentifié");
        }

        String pseudo = authentication.getName(); // Récupère le pseudo
        Map<String, Object> details = (Map<String, Object>) authentication.getDetails();

        Long userId = (Long) details.get("id");
        String email = (String) details.get("email");
        Boolean isAdmin = (Boolean) details.get("isAdmin");

        System.out.println("Utilisateur: " + pseudo);
        System.out.println("Details: " + details);

        return Map.of(
                "id", userId,
                "pseudo", pseudo,
                "email", email != null ? email : "unknown@example.com",
                "isAdmin", isAdmin != null ? isAdmin : false
        );
    }


}