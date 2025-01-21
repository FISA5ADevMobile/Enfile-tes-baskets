package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.services.TagService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tags")
public class TagController {

    @Autowired
    private TagService tagService;

    /**
     * Récupère tous les tags.
     */
    @GetMapping
    public List<TagDTO> getAllTags() {
        return tagService.getAllTags();
    }

    /**
     * Récupère un tag par son ID.
     */
    @GetMapping("/{id}")
    public TagDTO getTagById(@PathVariable Long id) {
        return tagService.getTagById(id);
    }

    /**
     * Crée un nouveau tag.
     */
    @PostMapping
    public TagDTO createTag(@RequestBody TagDTO tagDTO) {
        return tagService.createTag(tagDTO);
    }

    /**
     * Crée une liste de tags.
     */
    @PostMapping("/bulk")
    public List<TagDTO> createTags(@RequestBody List<TagDTO> tagDTOs) {
        return tagService.createTags(tagDTOs);
    }

    /**
     * Met à jour un tag spécifique par son ID.
     */
    @PutMapping("/{tagId}")
    public TagDTO updateTag(
            @PathVariable Long tagId,
            @RequestBody TagDTO tagDTO) {
        return tagService.updateTag(tagId, tagDTO);
    }
    /**
     * Récupère les infos d'un tag spécifique par son ID.
     */
    @GetMapping("/{tagId}")
    public TagDTO getTagById(@PathVariable Long tagId) {
        return tagService.getTagById(tagId);
    }


    /**
     * Supprime un tag.
     */
    @DeleteMapping("/{id}/delete")
    public void deleteTag(@PathVariable Long id) {
        tagService.deleteTag(id);
    }
}
