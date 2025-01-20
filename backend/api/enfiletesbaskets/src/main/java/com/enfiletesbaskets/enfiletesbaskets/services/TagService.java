package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.TagDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.TagModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.TagRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class TagService {

    @Autowired
    private TagRepository tagRepository;

    /**
     * Récupère tous les tags et les transforme en DTO.
     */
    public List<TagDTO> getAllTags() {
        return tagRepository.findAll().stream()
                .map(tag -> {
                    TagDTO dto = new TagDTO();
                    dto.setId(tag.getId());
                    dto.setName(tag.getName());
                    dto.setDescription(tag.getDescription());
                    return dto;
                }).collect(Collectors.toList());
    }

    /**
     * Crée un nouveau tag à partir d'un DTO.
     */
    public TagDTO createTag(TagDTO tagDTO) {
        TagModel tag = new TagModel();
        tag.setName(tagDTO.getName());
        tag.setDescription(tagDTO.getDescription());

        TagModel savedTag = tagRepository.save(tag);

        TagDTO dto = new TagDTO();
        dto.setId(savedTag.getId());
        dto.setName(savedTag.getName());
        dto.setDescription(savedTag.getDescription());
        return dto;
    }

    /**
     * Crée une liste de tags.
     */
    public List<TagDTO> createTags(List<TagDTO> tagDTOs) {
        List<TagModel> tags = tagDTOs.stream()
                .map(dto -> {
                    TagModel tag = new TagModel();
                    tag.setName(dto.getName());
                    tag.setDescription(dto.getDescription());
                    return tag;
                }).collect(Collectors.toList());

        List<TagModel> savedTags = tagRepository.saveAll(tags);

        return savedTags.stream()
                .map(tag -> {
                    TagDTO dto = new TagDTO();
                    dto.setId(tag.getId());
                    dto.setName(tag.getName());
                    dto.setDescription(tag.getDescription());
                    return dto;
                }).collect(Collectors.toList());
    }

    /**
     * Met à jour un tag si celui-ci existe.
     */
    public TagDTO updateTag(Long tagId, TagDTO tagDTO) {
        TagModel tag = tagRepository.findById(tagId)
                .orElseThrow(() -> new RuntimeException("Tag non trouvé avec l'ID : " + tagId));

        if (tagDTO.getName() != null) {
            tag.setName(tagDTO.getName());
        }
        if (tagDTO.getDescription() != null) {
            tag.setDescription(tagDTO.getDescription());
        }

        TagModel updatedTag = tagRepository.save(tag);
        return TagDTO.toDTO(updatedTag);
    }

    public TagDTO getTagById(Long id) {
        return tagRepository.findById(id).map(tag -> {
            TagDTO dto = new TagDTO();
            dto.setId(tag.getId());
            dto.setName(tag.getName());
            dto.setDescription(tag.getDescription());
            return dto;
        })
                .orElse(null);
    }

    public void deleteTag(Long id) {
        tagRepository.deleteById(id);
    }
}
