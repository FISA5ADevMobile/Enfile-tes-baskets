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


    @PostMapping("/add_actuality")
    public ResponseEntity<ActualityModel> addActuality(@RequestBody ActualityModel actuality) {
        ActualityModel savedActuality = actualityService.saveActuality(actuality);
        return ResponseEntity.ok(savedActuality);
    }
}
