package com.enfiletesbaskets.enfiletesbaskets;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
            .csrf().disable() // Disable CSRF for testing purposes
            .authorizeHttpRequests(authorize -> authorize
                .requestMatchers("/parcours/**","/tags/**","/classes/**","/courses/**","/tags/**").permitAll() // Allow unauthenticated access to /tags
                .anyRequest().authenticated() // Restrict other endpoints if needed
            );
        return http.build();
    }
}
