package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.LoginRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.RegisterRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.RequestPasswordResetRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.ResetPasswordRequest;
import com.enfiletesbaskets.enfiletesbaskets.dto.ValidateResetPasswordRequest;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.exception.CustomException;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import com.enfiletesbaskets.enfiletesbaskets.util.PasswordUtil;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import java.util.Optional;

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
        if (userRepository.findByEmail(request.getEmail()).isPresent()) {
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
    }

    public ResponseEntity<?> login(LoginRequest request) {
        // Vérifiez si l'utilisateur existe
        UserModel user = userRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new CustomException("Invalid email or password"));

        if (!PasswordUtil.checkPassword(request.getPassword(), user.getPassword())) {
            throw new CustomException("Invalid email or password");
        }

        // Générer un token JWT
        String token = jwtTokenProvider.generateToken(user.getEmail());
        return ResponseEntity.ok(token);
    }

    public ResponseEntity<?> logout() {
        // Logique de déconnexion (peut être gérée côté client)
        return ResponseEntity.ok("Logout successful.");
    }

    public ResponseEntity<?> requestPasswordReset(RequestPasswordResetRequest request) {
        Optional<UserModel> userOptional = userRepository.findByEmail(request.getEmail());
        if (userOptional.isPresent()) {
            UserModel user = userOptional.get();
            // Vérifie si le code correspond
            if (user.getCode() != null && user.getCode().equals(Integer.valueOf(request.getCode()))) {
                return ResponseEntity.ok("Code validé.");
            }
        }
        throw new CustomException("Email ou code invalide.");
    }

    public ResponseEntity<?> resetPassword(ResetPasswordRequest request) {
        Optional<UserModel> userOptional = userRepository.findByEmail(request.getEmail());
        if (userOptional.isPresent()) {
            UserModel user = userOptional.get();

            // Vérifiez si le code correspond
            if (user.getCode() != null && user.getCode().equals(request.getCode())) {
                // Hachage du nouveau mot de passe
                user.setPassword(PasswordUtil.hashPassword(request.getNewPassword()));
                user.setCode(null); // Supprimez le code après la réinitialisation
                userRepository.save(user);
                return ResponseEntity.ok("Mot de passe réinitialisé avec succès.");
            } else {
                throw new CustomException("Code invalide.");
            }
        }
        throw new CustomException("Utilisateur non trouvé.");
    }

    public ResponseEntity<?> validateResetPassword(ValidateResetPasswordRequest request) {
        Optional<UserModel> userOptional = userRepository.findByEmail(request.getEmail());
        if (userOptional.isPresent()) {
            UserModel user = userOptional.get();
            user.setCode(Integer.valueOf(request.getCode())); // Assure-toi que le code est un entier
            userRepository.save(user);
            return ResponseEntity.ok("Code de réinitialisation enregistré.");
        }
        throw new CustomException("Utilisateur non trouvé.");
    }
}