package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.exception.GlobalExceptionHandler;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService implements UserDetailsService {


    private UserRepository userRepository;
    private JwtTokenProvider jwtTokenProvider;

    @Autowired
    public UserService(UserRepository userRepository, JwtTokenProvider jwtTokenProvider) {
        this.userRepository = userRepository;
        this.jwtTokenProvider = jwtTokenProvider;
    }


    public List<UserModel> getAllUsers() {
        return userRepository.findAll();
    }

    public UserModel getUserById(Long id) {
        return userRepository.findById(id).orElse(null);
    }

    public void deleteUser (Long id) {
        userRepository.deleteById(id);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Assurez-vous que findByPseudo retourne un Optional<UserModel>
        UserModel user = userRepository.findByPseudo(username)
                .orElseThrow(() -> new UsernameNotFoundException("User  not found with username: " + username));

        // Créez et retournez un objet UserDetails
        return new org.springframework.security.core.userdetails.User(user.getPseudo(), user.getPassword(), user.getAuthorities());
    }

    public UserModel authenticate(Authentication authentication) {
        return userRepository.findById(jwtTokenProvider.getUserIdFromToken(authentication.getPrincipal().toString())).orElseThrow(() -> new UsernameNotFoundException("Invalid token"));
    }
}