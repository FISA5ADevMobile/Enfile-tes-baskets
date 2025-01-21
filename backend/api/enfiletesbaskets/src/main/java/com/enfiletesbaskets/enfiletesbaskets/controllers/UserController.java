package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.services.ClassService;
import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
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
    @Autowired
    private ClassService classService;

    // Ajoutez ici d'autres endpoints pour gérer les utilisateurs

    @GetMapping("/all")
    public List<UserModel> getAllUsers() {
        return userService.getAllUsers();
    }

    @GetMapping("/{id}")
    public UserModel getUserById(@PathVariable Long id) {
        return userService.getUserById(id);
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
    public ResponseEntity<Map<String, Object>> getCurrentUser(Authentication authentication) {
        UserModel user = userService.authenticate(authentication);

        Map<String, Object> userDetails = Map.of(
                "id", user.getId(),
                "pseudo", user.getPseudo(),
                "email", user.getEmail(),
                "isAdmin", "ADMIN".equals(user.getRole()));

        return ResponseEntity.ok(userDetails);
    }

    // @DeleteMapping("/{id}")
    // public void deleteUser(@PathVariable Long id) {
    //
    // UserModel user = userService.getUserById(id);
    // List<ClassModel> classes = classService.getAllClassesByOwner(user);
    // for(ClassModel clazz : classes) {
    // classService.deleteClassAndCourses(clazz.getId(),
    // SecurityContextHolder.getContext().getAuthentication());
    // }
    // userService.deleteUser(id);
    // }

    @PutMapping("/delete/{id}")
    public void deleteUser(@PathVariable Long id) {
        userService.deleteUser(id);
    }

}