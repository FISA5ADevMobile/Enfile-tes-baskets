package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.LoginRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.RegisterRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.PasswordResetRequest;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.exception.CustomException;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private JwtTokenProvider jwtTokenProvider;

    public ResponseEntity<?> register(RegisterRequest request) {
        // Logique d'enregistrement
        return ResponseEntity.ok("User registered successfully");
    }

    public ResponseEntity<?> login(LoginRequest request) {
        // Logique de connexion
        String token = jwtTokenProvider.generateToken(request.getEmail());
        return ResponseEntity.ok(token);
    }

    public ResponseEntity<?> resetPassword(PasswordResetRequest request) {
        // Logique de réinitialisation de mot de passe
        return ResponseEntity.ok("Password reset link has been sent to your email.");
    }

    public ResponseEntity<?> logout() {
        // Logique de déconnexion
        return ResponseEntity.ok("Logout successful.");
    }
}
