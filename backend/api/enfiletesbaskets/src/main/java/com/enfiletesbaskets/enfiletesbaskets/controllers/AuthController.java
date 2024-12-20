package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.*;
import com.enfiletesbaskets.enfiletesbaskets.services.AuthService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

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

    @PostMapping("/request-password-reset")
    public ResponseEntity<?> requestPasswordReset(@Valid @RequestBody RequestPasswordResetRequest request) {
        return authService.requestPasswordReset(request);
    }

    @PostMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@Valid @RequestBody ResetPasswordRequest request) {
        return authService.resetPassword(request);
    }

    @PostMapping("/validate-reset-password")
    public ResponseEntity<?> validateResetPassword(@Valid @RequestBody ValidateResetPasswordRequest request) {
        return authService.validateResetPassword(request);
    }

    @PostMapping("/logout")
    public ResponseEntity<?> logout() {
        return authService.logout();
    }
}