package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.ClassDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.ClassModel;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.ClassRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class ClassService {

    @Autowired
    private ClassRepository classRepository;

    @Autowired
    private UserService userService;
    @Autowired
    private TagRepository tagRepository;

    /**
     * Récupère toutes les classes et les transforme en DTO.
     */
    public List<ClassDTO> getAllClasses() {
        return classRepository.findAll().stream()
                .map(ClassDTO::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Crée une nouvelle classe avec le propriétaire authentifié et vérifie que le mot de passe est unique.
     */
    public ClassDTO createClass(ClassDTO classDTO, Authentication authentication) {
        UserModel owner = userService.authenticate(authentication);

        // ✅ Vérifier l'unicité du mot de passe
        boolean passwordExists = classRepository.existsByPassword(classDTO.getPassword());
        if (passwordExists) {
            throw new RuntimeException("Le mot de passe de la classe existe déjà. Veuillez en choisir un autre.");
        }

        // ✅ Créer et enregistrer la classe
        ClassModel clazz = ClassDTO.toEntity(classDTO);
        clazz.setOwner(owner);

        ClassModel savedClass = classRepository.save(clazz);

        return ClassDTO.toDTO(savedClass);
    }

    /**
     * Modifie une classe existante.
     */
    public ClassDTO updateClass(Long classId, ClassDTO classDTO, Authentication authentication) {
        ClassModel existingClass = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée"));

        UserModel user = userService.authenticate(authentication);

        // Vérifier si l'utilisateur est le propriétaire ou un administrateur
        if (!existingClass.getOwner().getId().equals(user.getId()) && !"ADMIN".equals(user.getRole())) {
            throw new RuntimeException("Vous n'avez pas l'autorisation de modifier cette classe");
        }

        // Mise à jour des informations
        if (classDTO.getName() != null) {
            existingClass.setName(classDTO.getName());
        }
        if (classDTO.getDescription() != null) {
            existingClass.setDescription(classDTO.getDescription());
        }
        if (classDTO.getPassword() != null) {
            existingClass.setPassword(classDTO.getPassword());
        }
        if (classDTO.getBeginDate() != null) {
            existingClass.setBeginDate(classDTO.getBeginDate());
        }
        if (classDTO.getEndDate() != null) {
            existingClass.setEndDate(classDTO.getEndDate());
        }

        ClassModel updatedClass = classRepository.save(existingClass);
        return ClassDTO.toDTO(updatedClass);
    }

    /**
     * Supprime une classe par ID si elle appartient à l'utilisateur authentifié ou à un administrateur.
     */
    public void deleteClassById(Long classId, Authentication authentication) {
        ClassModel clazz = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée"));

        UserModel user = userService.authenticate(authentication);

        // Vérifier si l'utilisateur est le propriétaire ou un administrateur
        if (!clazz.getOwner().getId().equals(user.getId()) && !"ADMIN".equals(user.getRole())) {
            throw new RuntimeException("Vous n'avez pas l'autorisation de supprimer cette classe");
        }

        classRepository.deleteById(classId);
    }

    /**
     * Ajoute des tags à une classe.
     */
    public ClassDTO addTagsToClass(Long classId, List<Long> tagIds) {
        ClassModel clazz = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée avec l'ID : " + classId));

        List<TagModel> tags = tagRepository.findAllByIdIn(tagIds);

        if (tags.isEmpty()) {
            throw new RuntimeException("Aucun tag valide trouvé pour les IDs fournis.");
        }

        // Ajout des tags à la classe
        clazz.getTags().addAll(tags);
        ClassModel updatedClass = classRepository.save(clazz);

        return ClassDTO.toDTO(updatedClass);
    }

    /**
     * Récupère tous les tags liés à une classe.
     */
    public List<TagDTO> getTagsByClass(Long classId) {
        ClassModel clazz = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée avec l'ID : " + classId));

        List<TagModel> tags = clazz.getTags();

        return tags.stream()
                .map(TagDTO::toDTO)
                .collect(Collectors.toList());
    }

    /**
     * Supprime des tags d'une classe.
     */
    public ClassDTO removeTagsFromClass(Long classId, List<Long> tagIds) {
        ClassModel clazz = classRepository.findById(classId)
                .orElseThrow(() -> new RuntimeException("Classe non trouvée avec l'ID : " + classId));

        // Filtrer et supprimer les tags correspondants
        List<TagModel> tagsToRemove = clazz.getTags().stream()
                .filter(tag -> tagIds.contains(tag.getId()))
                .collect(Collectors.toList());

        if (tagsToRemove.isEmpty()) {
            throw new RuntimeException("Aucun tag correspondant trouvé dans cette classe.");
        }

        clazz.getTags().removeAll(tagsToRemove);
        ClassModel updatedClass = classRepository.save(clazz);

        return ClassDTO.toDTO(updatedClass);
    }
}
