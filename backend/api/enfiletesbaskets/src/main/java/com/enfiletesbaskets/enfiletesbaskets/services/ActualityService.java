package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.models.UserActualityModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.ActualityRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserActualityRepository;
import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import org.springframework.stereotype.Service;
import jakarta.annotation.Resource;

import java.util.List;
import java.util.NoSuchElementException;

@Service
public class ActualityService {

    @Resource
    private ActualityRepository actualityRepository;

    @Resource
    private UserActualityRepository userActualityRepository; // Ce repository gère les inscriptions

    public ActualityModel getActualityById(Long id) {
        return actualityRepository.findById(id)
                .orElseThrow(() -> new NoSuchElementException("Actuality not found with id: " + id));
    }

    public List<ActualityModel> getAllActualities() {
        return actualityRepository.findAll();
    }

    public void subscribeToEvent(Long actualityId, Long userId) {
        // Vérification si l'actualité existe
        ActualityModel actuality = actualityRepository.findById(actualityId)
                .orElseThrow(() -> new NoSuchElementException("Actuality not found with id: " + actualityId));

        // Vérification que l'actualité est un événement
        if (!actuality.getEvent()) {
            throw new IllegalArgumentException("The actuality is not an event.");
        }

        // Ajouter l'inscription dans UserActuality
        UserActualityModel userActuality = new UserActualityModel(userId, actualityId);
        userActualityRepository.save(userActuality);
    }

    public ActualityModel saveActuality(ActualityModel actuality) {
        return actualityRepository.save(actuality);
    }
}
