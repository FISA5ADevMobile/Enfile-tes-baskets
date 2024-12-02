package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.LoginRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.RegisterRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.PasswordResetRequest;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.exception.CustomException;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import com.enfiletesbaskets.enfiletesbaskets.util.PasswordUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;

    public AuthService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
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
        String token = jwtTokenProvider.generateToken(user.getEmail());
        return ResponseEntity.ok(token);
    }

    public ResponseEntity<?> resetPassword(PasswordResetRequest request) {
        // Logique de réinitialisation de mot de passe
        UserModel user = (UserModel) userRepository.findByEmail(request.getEmail());
        if (user == null) {
            throw new CustomException("User  not found");
        }

        // Ici, vous pouvez envoyer un email avec un lien de réinitialisation de mot de passe
        return ResponseEntity.ok("Password reset link has been sent to your email.");
    }

    public ResponseEntity<?> logout() {
        // Logique de déconnexion (peut être gérée côté client)
        return ResponseEntity.ok("Logout successful.");
    }
}