package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.LoginRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.RegisterRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.PasswordResetRequest;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.exception.CustomException;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import com.enfiletesbaskets.enfiletesbaskets.util.PasswordUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import com.enfiletesbaskets.enfiletesbaskets.models.PasswordResetToken;
import com.enfiletesbaskets.enfiletesbaskets.repositories.PasswordResetTokenRepository;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;
import java.time.LocalDateTime;

import java.util.Map;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final MailService emailService;
    private final PasswordResetTokenRepository passwordResetTokenRepository;

    @Autowired
    public AuthService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider, MailService emailService, PasswordResetTokenRepository passwordResetTokenRepository) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
        this.emailService = emailService;
        this.passwordResetTokenRepository = passwordResetTokenRepository;
    }

    public void register(RegisterRequest request) {
        // Vérifiez si l'email existe déjà
        if (userRepository.findByEmail(request.getEmail()) != null) {
            throw new CustomException("Email already in use");
        }

        // Créez un nouvel utilisateur
        UserModel user = new UserModel();
        user.setEmail(request.getEmail());
        user.setPseudo(request.getUsername());
        user.setName(request.getName());
        user.setFirstName(request.getFirstName());
        user.setPassword(PasswordUtil.hashPassword(request.getPassword())); // Hachage du mot de passe
        user.setRole("USER"); // Rôle par défaut
        userRepository.save(user);

        ResponseEntity.ok("User  registered successfully");
    }

    public ResponseEntity<?> login(LoginRequest request) {
        // Vérifiez si l'utilisateur existe
        UserModel user = (UserModel) userRepository.findByEmail(request.getEmail());
        if (user == null || !PasswordUtil.checkPassword(request.getPassword(), user.getPassword())) {
            throw new CustomException("Invalid email or password");
        }

        // Générer un token JWT
        String token = jwtTokenProvider.generateToken(user);
        return ResponseEntity.ok(Map.of(
                "token", token,
                "role", user.getRole()
        ));
    }

    public ResponseEntity<?> resetPassword(PasswordResetRequest request) {
        // Vérifie si l'utilisateur existe avec l'email fourni
        UserModel user = userRepository.findByEmail(request.getEmail());
        if (user == null) {
            return ResponseEntity.status(404).body(Map.of("message", "Email not found."));
        }

        // Vérifie si le token est valide
        PasswordResetToken passwordResetToken = passwordResetTokenRepository.findByToken(request.getToken());
        if (passwordResetToken == null || !passwordResetToken.getUser ().getEmail().equals(request.getEmail())) {
            return ResponseEntity.status(400).body(Map.of("message", "Invalid token."));
        }

        // Hache le nouveau mot de passe et met à jour l'utilisateur
        user.setPassword(PasswordUtil.hashPassword(request.getNewPassword()));
        userRepository.save(user);

        // Supprime le token de réinitialisation de mot de passe
        passwordResetTokenRepository.delete(passwordResetToken);

        return ResponseEntity.ok("Password has been reset successfully.");
    }

    public ResponseEntity<?> requestPasswordReset(String email) {
        UserModel user = userRepository.findByEmail(email);
        if (user == null) {
            return ResponseEntity.status(404).body(Map.of("message", "Email not found."));
        }

        String token = UUID.randomUUID().toString();
        PasswordResetToken passwordResetToken = new PasswordResetToken();
        passwordResetToken.setToken(token);
        passwordResetToken.setUser (user);
        passwordResetToken.setExpiryDate(LocalDateTime.now().plusHours(1)); // Token valide pendant 1 heure
        passwordResetTokenRepository.save(passwordResetToken);

        emailService.sendPasswordResetEmail(email, token);
        return ResponseEntity.ok("Password reset link has been sent to your email.");
    }

    public ResponseEntity<?> logout() {
        // Logique de déconnexion (peut être gérée côté client)
        return ResponseEntity.ok("Logout successful.");
    }
}