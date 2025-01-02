package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.models.UserActualityModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.ActualityRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserActualityRepository;
import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;
import jakarta.annotation.Resource;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

@Service
public class ActualityService {

    @Resource
    private ActualityRepository actualityRepository;

    @Resource
    private UserService userService;

    @Resource
    private UserActualityRepository userActualityRepository; // Ce repository gère les inscriptions

    public ActualityModel getActualityById(Long id) {
        return actualityRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Actuality not found with id: " + id));
    }

    public List<Map<String, Object>> getAllActualities() {
        return actualityRepository.findAll().stream()
                .map(actuality -> {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", actuality.getId());
                    map.put("title", actuality.getTitle());
                    map.put("description", actuality.getDescription());
                    map.put("event", actuality.getEvent());
                    map.put("publicationDate", actuality.getPublicationDate());
                    return map;
                })
                .collect(Collectors.toList());
    }

    public void subscribeToEvent(Long actualityId, Authentication auth) {

        UserModel user = userService.authenticate(auth);

        // Vérification si l'actualité existe
        ActualityModel actuality = actualityRepository.findById(actualityId)
                .orElseThrow(() -> new NoSuchElementException("Actuality not found with id: " + actualityId));

        // Vérification que l'actualité est un événement
        if (!actuality.getEvent()) {
            throw new IllegalArgumentException("The actuality is not an event.");
        }

        // Ajouter l'inscription dans UserActuality
        UserActualityModel userActuality = new UserActualityModel(user.getId(), actualityId);
        userActualityRepository.save(userActuality);
    }
    public void deleteActualityById(Long id) {
        if (!actualityRepository.existsById(id)) {
            throw new NoSuchElementException("Actuality not found with id: " + id);
        }
        actualityRepository.deleteById(id);
    }

    public ActualityModel saveActuality(ActualityModel actuality) {
        if (actuality.getPublicationDate() == null) {
            actuality.setPublicationDate(LocalDateTime.now());
        }
        return actualityRepository.save(actuality);
    }
}
