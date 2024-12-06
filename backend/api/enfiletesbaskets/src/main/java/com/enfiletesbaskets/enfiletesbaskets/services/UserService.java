package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.models.PasswordResetToken;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.PasswordResetTokenRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    public List<UserModel> getAllUsers() {
        return userRepository.findAll();
    }

    public UserModel getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public void deleteUser (Long id) {
        userRepository.deleteById(id);
    }

    @Autowired
    private PasswordResetTokenRepository passwordResetTokenRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Assurez-vous que findByPseudo retourne un Optional<UserModel>
        UserModel user = userRepository.findByPseudo(username)
                .orElseThrow(() -> new UsernameNotFoundException("User  not found with username: " + username));

        // Créez et retournez un objet UserDetails
        return new org.springframework.security.core.userdetails.User(user.getPseudo(), user.getPassword(), user.getAuthorities());
    }

    public void resetPassword(String token, String newPassword) {
        PasswordResetToken resetToken = passwordResetTokenRepository.findByToken(token);
        if (resetToken == null || resetToken.isExpired()) {
            throw new RuntimeException("Token invalide ou expiré.");
        }

        UserModel user = resetToken.getUser ();
        String encodedPassword = passwordEncoder.encode(newPassword);
        user.setPassword (encodedPassword);
        userRepository.save(user);
    }
}