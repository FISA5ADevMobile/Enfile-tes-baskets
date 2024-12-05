package com.enfiletesbaskets.enfiletesbaskets.security;

import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class JwtTokenProvider {

    private final String SECRET_KEY = "g6w/9NoWx7e/Lhs4nY2UZ70wjhgnYu81j9feVD63rE/PEZ6ZEtcxNFeCpXfybzyoqgINbsGt0jDbOEhsWWv7jQ==";
    private final long EXPIRATION_TIME = 86400000; // 1 jour

    public String generateToken(UserModel user) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("isAdmin", user.getRole().equals("ADMIN"));
        claims.put("isBanned", user.getBanDate() != null);
        claims.put("id", user.getId());
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(user.getEmail())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SignatureAlgorithm.HS512, SECRET_KEY)
                .compact();
    }

    public boolean validateToken(String token) {
        return !isTokenExpired(token);
    }
    private String cleanToken(String token) {
        if (token != null) {
            return token.replace("\n", "").replace("\r", "").trim();
        }
        return null;
    }
    private boolean isTokenExpired(String token) {
        String cleanedToken = cleanToken(token);
        Claims claims = Jwts.parser().setSigningKey(SECRET_KEY).parseClaimsJws(cleanedToken).getBody();
        return claims.getExpiration().before(new Date());
    }
    public Claims getAllClaimsFromToken(String token) {
        String cleanedToken = cleanToken(token);
        return Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(cleanedToken)
                .getBody();
    }
    public String getUsernameFromToken(String token) {
        Claims claims = getAllClaimsFromToken(token);
        return claims.getSubject();
    }

    public Boolean getIsBannedFromToken(String token) {
        Claims claims = getAllClaimsFromToken(token);
        return claims.get("isBanned", Boolean.class);
    }

    public Long getUserIdFromToken(String token) {
        Claims claims = getAllClaimsFromToken(token);
        return claims.get("id", Long.class);
    }
    public Long getUserIdFromToken(String token) {
        Claims claims = Jwts.parser()
                .setSigningKey(SECRET_KEY)
                .parseClaimsJws(token)
                .getBody();
            return claims.get("id", Long.class);
    }
    public Boolean getIsAdminFromToken(String token) {
        Claims claims = getAllClaimsFromToken(token);
        return claims.get("isAdmin", Boolean.class);
    }

}