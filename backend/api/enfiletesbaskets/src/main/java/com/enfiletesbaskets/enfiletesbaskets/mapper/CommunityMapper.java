package com.enfiletesbaskets.enfiletesbaskets.mapper;

import com.enfiletesbaskets.enfiletesbaskets.dto.CommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.CommunityModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;

import java.util.stream.Collectors;

public class CommunityMapper {

    public static CommunityDTO toDTO(CommunityModel communityModel, UserModel userModel) {
        CommunityDTO dto = new CommunityDTO();
        dto.setId(communityModel.getId());
        dto.setName(communityModel.getNom());
        dto.setDescription(communityModel.getDescription());
        dto.setBanDate(communityModel.getBanDate());
        dto.setIsPublic(communityModel.getPublic());
        dto.setAdminId(communityModel.getAdmin() != null ? communityModel.getAdmin().getId() : null);
        dto.setImage(communityModel.getImage() != null ? communityModel.getImage() : null);
        // Convertir les listes d'entités en listes d'IDs
        dto.setJoined(communityModel.getUsers().contains(userModel));
        dto.setModeratorIds(communityModel.getModerators().stream().map(user -> user.getId()).collect(Collectors.toList()));
        dto.setPostIds(communityModel.getPosts().stream().map(PostMapper::toDTO).collect(Collectors.toList()));
        dto.setBannedUserIds(communityModel.getBannedUsers().stream().map(user -> user.getId()).collect(Collectors.toList()));
        dto.setCategoryName(communityModel.getCategory() != null ? communityModel.getCategory().getName() : null);

        return dto;
    }

    public static CommunityModel toEntity(CommunityDTO dto) {
        CommunityModel communityModel = new CommunityModel();
        communityModel.setId(dto.getId());
        communityModel.setNom(dto.getName());
        communityModel.setDescription(dto.getDescription());
        communityModel.setBanDate(dto.getBanDate());
        communityModel.setPublic(dto.getIsPublic());

        // Les relations complexes doivent être gérées ailleurs (ex: service)
        // Les listes (users, moderators, etc.) seront peuplées via un service

        return communityModel;
    }
}