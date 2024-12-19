package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;
import com.enfiletesbaskets.enfiletesbaskets.services.TagService;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/tags")
public class TagController {

    private final TagService tagService;

    private final TagRepository tagRepository;

    public TagController(TagRepository tagRepository,TagService tagService) {
        this.tagRepository = tagRepository;
        this.tagService = tagService;
    }

    // Récupérer tous les tags d'une classe
    @GetMapping("/class/{classId}")
    public ResponseEntity<List<Map<String, Object>>> getTagsByClass(@PathVariable Long classId) {
        List<Object[]> results = tagRepository.findAllByClassId(classId);
                List<Map<String, Object>> tags = results.stream().map(row -> {
                    if (row.length < 5) {
                        throw new IllegalStateException("Pas la bonne structure.");
                    }
                    Map<String, Object> tag = new HashMap<>();
                    tag.put("id", row[0]);
                    tag.put("name", row[1]);
                    tag.put("description", row[2]);
                    tag.put("xPos", row[3]);
                    tag.put("yPos", row[4]);
                    return tag;
                }).collect(Collectors.toList());
                return ResponseEntity.ok(tags);
    }

    // Récupérer tous les tags validés d'un utilisateur pour un parcours
    @GetMapping("/course/{courseId}")
    public ResponseEntity<List<Map<String, Object>>> getTags(@PathVariable Long courseId) {
        List<Object[]> results = tagRepository.findAllByCourseId(courseId);

        List<Map<String, Object>> tags = results.stream().map(row -> {
            if (row.length < 5) {
                throw new IllegalStateException("Pas la bonne structure.");
            }
            Map<String, Object> tag = new HashMap<>();
            tag.put("id", row[0]);
            tag.put("name", row[1]);
            tag.put("description", row[2]);
            tag.put("xPos", row[3]);
            tag.put("yPos", row[4]);
            return tag;
        }).collect(Collectors.toList());
    
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
        return tagRepository.findByIdAndUserId(tagId, userId)
            .map(ResponseEntity::ok)
            .orElse(ResponseEntity.notFound().build());
    }
}
