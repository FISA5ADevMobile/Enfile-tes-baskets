package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import com.enfiletesbaskets.enfiletesbaskets.services.ActualityService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

import java.util.List;

@RestController
@RequestMapping("/actualities")
public class ActualityController {

    @Resource
    private ActualityService actualityService;

    @GetMapping("/get_1/{id}")
    public ResponseEntity<ActualityModel> getActualityById(@PathVariable Long id) {
        ActualityModel actuality = actualityService.getActualityById(id);
        return ResponseEntity.ok(actuality);
    }

    @GetMapping("/get_all")
    public ResponseEntity<List<ActualityModel>> getAllActualities() {
        List<ActualityModel> actualities = actualityService.getAllActualities();
        return ResponseEntity.ok(actualities);
    }

    @PostMapping("/subscribe_to_event/{id}")
    public ResponseEntity<String> subscribeToEvent(@PathVariable Long id, @RequestParam Long userId) {
        actualityService.subscribeToEvent(id, userId);
        return ResponseEntity.ok("Successfully subscribed to the event.");
    }
}
