package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.LoginRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.RegisterRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.PasswordResetRequest;
import com.enfiletesbaskets.enfiletesbaskets.services.AuthService;
import jakarta.annotation.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    @Resource
    private AuthService authService;

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestBody RegisterRequest registerRequest) {
        System.out.println("Received registration request for: " + registerRequest.getUsername());
        authService.register(registerRequest);
        return ResponseEntity.ok("User  registered successfully");
    }

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestBody LoginRequest request) {
        return authService.login(request);
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@RequestBody PasswordResetRequest request) {
        return authService.resetPassword(request);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout() {
        return authService.logout();
    }
}