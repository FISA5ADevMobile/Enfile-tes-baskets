package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.ClassDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.services.ClassService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/classes")
public class ClassController {

    @Autowired
    private ClassService classService;

    /**
     * Récupère toutes les classes.
     */
    @GetMapping
    public List<ClassDTO> getAllClasses() {
        return classService.getAllClasses();
    }

    /**
     * Crée une nouvelle classe pour l'utilisateur authentifié.
     */
    @PostMapping
    public ClassDTO createClass(@RequestBody ClassDTO classDTO, Authentication authentication) {
        return classService.createClass(classDTO, authentication);
    }

    /**
     * Modifie une classe existante.
     */
    @PutMapping("/{id}")
    public ResponseEntity<ClassDTO> updateClass(
            @PathVariable Long id,
            @RequestBody ClassDTO classDTO,
            Authentication authentication) {

        ClassDTO updatedClass = classService.updateClass(id, classDTO, authentication);
        return ResponseEntity.ok(updatedClass);
    }

    /**
     * Supprime une classe par ID.
     */
    @DeleteMapping("/{id}")
    public void deleteClass(@PathVariable Long id, Authentication authentication) {
        classService.deleteClassById(id, authentication);
    }

    /**
     * Ajoute une liste de tags à une classe.
     */
    @PostMapping("/{classId}/tags")
    public ResponseEntity<ClassDTO> addTagsToClass(
            @PathVariable Long classId,
            @RequestBody List<Long> tagIds,
            Authentication authentication) {

        ClassDTO updatedClass = classService.addTagsToClass(classId, tagIds);
        return ResponseEntity.ok(updatedClass);
    }

    /**
     * Affiche tous les tags associés à une classe spécifique.
     */
    @GetMapping("/{classId}/tags")
    public ResponseEntity<List<TagDTO>> getTagsByClass(@PathVariable Long classId) {
        List<TagDTO> tags = classService.getTagsByClass(classId);
        return ResponseEntity.ok(tags);
    }


    /**
     * Supprime un ou plusieurs tags d'une classe.
     */
    @DeleteMapping("/{classId}/tags")
    public ResponseEntity<ClassDTO> removeTagsFromClass(
            @PathVariable Long classId,
            @RequestBody List<Long> tagIds,
            Authentication authentication) {

        ClassDTO updatedClass = classService.removeTagsFromClass(classId, tagIds);
        return ResponseEntity.ok(updatedClass);
    }
}
