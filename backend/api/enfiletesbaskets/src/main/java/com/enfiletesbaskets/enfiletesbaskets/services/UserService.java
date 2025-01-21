package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.exception.GlobalExceptionHandler;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class UserService implements UserDetailsService {

    @Resource
    private final UserRepository userRepository;
    @Resource
    private final JwtTokenProvider jwtTokenProvider;

    @Autowired
    public UserService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    public List<UserModel> getAllUsers() {
        return userRepository.findAll().stream().map(user -> {
            UserModel userModel = new UserModel();
            userModel.setId(user.getId());
            userModel.setPseudo(user.getPseudo());
            userModel.setEmail(user.getEmail());
            userModel.setName(user.getName());
            userModel.setFirstName(user.getFirstName());
            userModel.setRole(user.getRole());
            userModel.setBanDate(user.getBanDate());
            userModel.setNbPostDeleted(user.getNbPostDeleted());
            userModel.setCode(user.getCode());
            return userModel;
        }).collect(Collectors.toList());
    }

    public UserModel getUserById(Long id) {
        return userRepository.findById(id).map(user -> {
            UserModel userModel = new UserModel();
            userModel.setId(user.getId());
            userModel.setPseudo(user.getPseudo());
            userModel.setEmail(user.getEmail());
            userModel.setName(user.getName());
            userModel.setFirstName(user.getFirstName());
            userModel.setRole(user.getRole());
            userModel.setBanDate(user.getBanDate());
            userModel.setNbPostDeleted(user.getNbPostDeleted());
            userModel.setCode(user.getCode());
            return userModel;
        }).orElse(null);
    }

    public void deleteUser(Long id) {
        UserModel user = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé avec l'ID : " + id));

        // Erase all the user's personnal data to comply with GDPR
        user.setPseudo("deleted_" + user.getId());
        user.setEmail("deleted_" + user.getId());
        user.setPassword("deleted_" + user.getId());
        user.setName("deleted_" + user.getId());
        user.setFirstName("deleted_" + user.getId());

        // Save the updated user to the database
        userRepository.save(user);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Assurez-vous que findByPseudo retourne un Optional<UserModel>
        UserModel user = userRepository.findByPseudo(username)
                .orElseThrow(() -> new UsernameNotFoundException("User  not found with username: " + username));

        // Créez et retournez un objet UserDetails
        return new org.springframework.security.core.userdetails.User(user.getPseudo(), user.getPassword(),
                user.getAuthorities());
    }

    public UserModel authenticate(Authentication authentication) {
        if (authentication == null || !(authentication.getPrincipal() instanceof UserDetails)) {
            throw new UsernameNotFoundException("Authentication failed: UserDetails not found");
        }

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        String username = userDetails.getUsername(); // Récupère le nom d'utilisateur

        // Charge l'utilisateur depuis la base de données
        return userRepository.findByPseudo(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with username: " + username));
    }

    public void banUser(Long id) {
        UserModel user = userRepository.findById(id).orElseThrow();
        user.setBanDate(new Date());
        userRepository.save(user);
    }

    public void unbanUser(Long id) {
        UserModel user = userRepository.findById(id).orElseThrow();
        user.setBanDate(null);
        userRepository.save(user);
    }

    public UserModel getUserByEmail(String email) {
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Utilisateur non trouvé"));
    }
}