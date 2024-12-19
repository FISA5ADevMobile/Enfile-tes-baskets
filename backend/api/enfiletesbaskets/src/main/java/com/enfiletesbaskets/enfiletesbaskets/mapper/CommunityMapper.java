package com.enfiletesbaskets.enfiletesbaskets.mapper;

import com.enfiletesbaskets.enfiletesbaskets.dto.CommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.CommunityModel;

import java.util.stream.Collectors;

public class CommunityMapper {

    public static CommunityDTO toDTO(CommunityModel communityModel) {
        CommunityDTO dto = new CommunityDTO();
        dto.setId(communityModel.getId());
        dto.setNom(communityModel.getNom());
        dto.setDescription(communityModel.getDescription());
        dto.setBanDate(communityModel.getBanDate());
        dto.setIsPublic(communityModel.getPublic());
        dto.setAdminId(communityModel.getAdmin() != null ? communityModel.getAdmin().getId() : null);

        // Convertir les listes d'entités en listes d'IDs
        dto.setUserIds(communityModel.getUsers().stream().map(user -> user.getId()).collect(Collectors.toList()));
        dto.setModeratorIds(communityModel.getModerators().stream().map(user -> user.getId()).collect(Collectors.toList()));
        dto.setPostIds(communityModel.getPosts().stream().map(post -> post.getId()).collect(Collectors.toList()));
        dto.setBannedUserIds(communityModel.getBannedUsers().stream().map(user -> user.getId()).collect(Collectors.toList()));
        dto.setCategoryId(communityModel.getCategory() != null ? communityModel.getCategory().getId() : null);

        return dto;
    }

    public static CommunityModel toEntity(CommunityDTO dto) {
        CommunityModel communityModel = new CommunityModel();
        communityModel.setId(dto.getId());
        communityModel.setNom(dto.getNom());
        communityModel.setDescription(dto.getDescription());
        communityModel.setBanDate(dto.getBanDate());
        communityModel.setPublic(dto.getIsPublic());

        // Les relations complexes doivent être gérées ailleurs (ex: service)
        // Les listes (users, moderators, etc.) seront peuplées via un service

        return communityModel;
    }
}