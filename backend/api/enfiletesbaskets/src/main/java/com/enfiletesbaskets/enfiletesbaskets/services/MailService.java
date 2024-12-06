package com.enfiletesbaskets.enfiletesbaskets.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    @Autowired
    private JavaMailSender mailSender;

    public void sendPasswordResetEmail(String to, String token) {
        String subject = "Réinitialisation de votre mot de passe";
        String resetUrl = "http://localhost:8080/api/auth/reset-password?token=" + token; // Changez l'URL selon votre configuration
        String message = "Cliquez sur le lien suivant pour réinitialiser votre mot de passe : " + resetUrl;

        SimpleMailMessage email = new SimpleMailMessage();
        email.setTo(to);
        email.setSubject(subject);
        email.setText(message);
        mailSender.send(email);
    }
}