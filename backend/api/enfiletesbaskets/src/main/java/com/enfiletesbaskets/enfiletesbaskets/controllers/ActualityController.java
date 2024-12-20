package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.ActualityModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.services.ActualityService;
import com.enfiletesbaskets.enfiletesbaskets.services.UserService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

import java.util.List;

@RestController
@RequestMapping("/api/actualities")
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

    @PostMapping("/subscribe/{actualityId}")
    public ResponseEntity<String> subscribeToEvent(@PathVariable Long actualityId, Authentication auth) {
        actualityService.subscribeToEvent(actualityId, auth);
        return ResponseEntity.ok("Subscribed to event");
    }


    @PostMapping("/add_actuality")
    public ResponseEntity<ActualityModel> addActuality(@RequestBody ActualityModel actuality) {
        ActualityModel savedActuality = actualityService.saveActuality(actuality);
        return ResponseEntity.ok(savedActuality);
    }

    @DeleteMapping("/delete/{id}")
    public ResponseEntity<String> deleteActualityById(@PathVariable Long id) {
        actualityService.deleteActualityById(id);
        return ResponseEntity.ok("Actuality deleted successfully");
    }
}
