package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;
import com.enfiletesbaskets.enfiletesbaskets.services.TagService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/tags")
public class TagController {

    private final TagService tagService;
    private final TagRepository tagRepository;


    public TagController(TagService tagService, TagRepository tagRepository) {
        this.tagService = tagService;
        this.tagRepository = tagRepository;
    }

    // Récupérer tous les tags d'une classe
    @GetMapping("/class/{classId}")
    public ResponseEntity<List<Map<String, Object>>> getTagsByClass(@PathVariable Long classId) {
        List<Map<String, Object>> tags = tagService.getTagsByClass(classId);
        return ResponseEntity.ok(tags);
    }

    // Récupérer tous les tags validés d'un utilisateur pour un parcours
    @GetMapping("/course/{courseId}")
    public ResponseEntity<List<Map<String, Object>>> getTags(@PathVariable Long courseId) {
        List<Map<String, Object>> tags = tagService.getTagsByCourse(courseId);
        return ResponseEntity.ok(tags);
    }
    
    @GetMapping("/{tagId}/description")
    public ResponseEntity<String> getTagDescription(@PathVariable Long tagId) {
        return ResponseEntity.ok(tagService.getTagDescription(tagId));
    }


    // // Récupérer tous les tags d'une classe et d'un utilisateur
    // @GetMapping("/class/{classId}/user/{userId}")
    // public ResponseEntity<List<TagModel>> getTagsByClassAndUser(
    //     @PathVariable Long classId, 
    //     @PathVariable Long userId
    // ) {
    //     List<TagModel> tags = tagRepository.findAllByClassIdAndUserId(classId, userId);
    //     return ResponseEntity.ok(tags);
    // }

    // Récupérer un tag par ID et utilisateur
    @GetMapping("/{tagId}/user/{userId}")
    public ResponseEntity<TagModel> getTagByIdAndUser(
        @PathVariable Long tagId, 
        @PathVariable Long userId
    ) {
        return tagService.getTagByIdAndUser(tagId, userId)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/{tagId}")
    public ResponseEntity<TagModel> getTagById(@PathVariable Long tagId) {
        return tagRepository.findById(tagId)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/all")
    public ResponseEntity<List<TagModel>> getAllTags() {
        List<TagModel> tags = tagRepository.findAll();
        return ResponseEntity.ok(tags);
    }
    
}
