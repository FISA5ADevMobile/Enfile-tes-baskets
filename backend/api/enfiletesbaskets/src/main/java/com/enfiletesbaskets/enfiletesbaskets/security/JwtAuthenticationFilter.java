package com.enfiletesbaskets.enfiletesbaskets.security;

import io.jsonwebtoken.Claims;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.filter.OncePerRequestFilter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class JwtAuthenticationFilter extends OncePerRequestFilter {

    private final JwtTokenProvider jwtTokenProvider;
    private final UserDetailsService userDetailsService;

    public JwtAuthenticationFilter(JwtTokenProvider jwtTokenProvider, UserDetailsService userDetailsService) {
        this.jwtTokenProvider = jwtTokenProvider;
        this.userDetailsService = userDetailsService;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws ServletException, IOException {

        String path = request.getServletPath();
        System.out.println("Processing request for path: " + path);

        // Ignore les endpoints publics
        if (path.equals("/api/auth/register") || path.equals("/api/auth/login") || path.equals("/api/auth/reset-password")) {
            System.out.println("Skipping JWT filter for path: " + path);
            chain.doFilter(request, response);
            return;
        }

        // Récupérer le token JWT de l'en-tête Authorization
        String token = getJwtFromRequest(request);

        if (token != null && jwtTokenProvider.validateToken(token)) {
            Claims claims = jwtTokenProvider.getAllClaimsFromToken(token);

            String username = claims.getSubject(); // Récupère le pseudo
            String email = claims.get("email", String.class); // Récupère l'email
            Long userId = claims.get("id", Long.class);
            Boolean isAdmin = claims.get("isAdmin", Boolean.class);

            System.out.println("Extracted claims:");
            System.out.println("Username: " + username);
            System.out.println("Email: " + email);
            System.out.println("ID: " + userId);
            System.out.println("IsAdmin: " + isAdmin);

            UserDetails userDetails = userDetailsService.loadUserByUsername(username);

            UsernamePasswordAuthenticationToken authentication =
                    new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

            Map<String, Object> details = new HashMap<>();
            details.put("id", userId);
            details.put("isAdmin", isAdmin != null ? isAdmin : false);
            details.put("email", email != null ? email : "unknown@example.com");

            authentication.setDetails(details);
            SecurityContextHolder.getContext().setAuthentication(authentication);
        }
        else {
            System.out.println("Invalid or missing token for path: " + path);
        }

        chain.doFilter(request, response);
    }


    private String getJwtFromRequest(HttpServletRequest request) {
        String bearerToken = request.getHeader("Authorization");
        if (bearerToken != null && bearerToken.startsWith("Bearer ")) {
            return bearerToken.substring(7); // Retire le "Bearer " du token
        }
        return null;
    }
}