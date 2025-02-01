package com.enfiletesbaskets.enfiletesbaskets.mapper;

import com.enfiletesbaskets.enfiletesbaskets.dto.PostDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.PostModel;

import java.util.Base64;

public class PostMapper {

    public static PostDTO toDTO(PostModel postModel) {
        PostDTO dto = new PostDTO();
        dto.setId(postModel.getId());
        dto.setContent(postModel.getDescription());
        dto.setDatePost(postModel.getDatePost());
        dto.setImageUrl(postModel.getImage() != null ? Base64.getEncoder().encodeToString(postModel.getImage()) : null);
        dto.setNbLike(postModel.getNbLike());
        dto.setNbPost(postModel.getNbPost());
        dto.setVisible(postModel.getVisible());
        dto.setBanDate(postModel.getBanDate());
        dto.setUsername(postModel.getCreator() != null ? postModel.getCreator().getPseudo() : null);
        dto.setRelatedPostId(postModel.getRelated() != null ? postModel.getRelated().getId() : null);
        return dto;
    }
}
