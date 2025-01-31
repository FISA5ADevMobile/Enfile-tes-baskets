package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.CommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CreateCommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CreatePostDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.UpdateCommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.exception.NoContentException;
import com.enfiletesbaskets.enfiletesbaskets.exception.UserNotFound;
import com.enfiletesbaskets.enfiletesbaskets.mapper.CommunityMapper;
import com.enfiletesbaskets.enfiletesbaskets.models.CategoryModel;
import com.enfiletesbaskets.enfiletesbaskets.models.CommunityModel;
import com.enfiletesbaskets.enfiletesbaskets.models.PostModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CategoryRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CommunityRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.PostRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import com.enfiletesbaskets.enfiletesbaskets.security.JwtTokenProvider;
import jakarta.annotation.Resource;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class CommunityService {
    @Resource
    private CommunityRepository communityRepository;

    @Resource
    private PostRepository postRepository;

    @Resource
    private UserService userService;

    @Resource
    private CategoryRepository categoryRepository;

    @Resource
    private JwtTokenProvider jwtTokenProvider;

    public List<CommunityDTO> getAllCommunities(Authentication auth) {
        // Récupérer l'utilisateur connecté
        UserModel currentUser = userService.authenticate(auth);

        // Récupérer toutes les communautés
        List<CommunityModel> communities = communityRepository.findAll();
        if (communities.isEmpty()) {
            throw new NoContentException("No community found.");
        }

        // Mapper chaque communauté avec un indicateur si l'utilisateur a rejoint
        return communities.stream()
                .map(community -> CommunityMapper.toDTO(community, currentUser))
                .collect(Collectors.toList());
    }


    public CommunityDTO getCommunityById(Long id, Authentication auth) {
        UserModel currentUser = userService.authenticate(auth);
        CommunityModel community = communityRepository.findById(id)
                .orElseThrow(() -> new NoContentException("Community with ID " + id + " not found."));

        return CommunityMapper.toDTO(community, currentUser);
    }

    public CommunityDTO createPostInCommunity(Long communityId, CreatePostDTO dto, Authentication auth) {
        CommunityModel community = communityRepository.findById(communityId)
                .orElseThrow(() -> new NoContentException("Community with ID " + communityId + " not found."));

        UserModel creator = userService.authenticate(auth);

        if (!community.getUsers().contains(creator)) {
            throw new UserNotFound("User " + creator + " doesn't belong to the community.");
        }

        PostModel relatedPost = null;
        if (dto.getRelatedPostId() != null) {
            relatedPost = postRepository.findById(dto.getRelatedPostId())
                    .orElseThrow(() -> new IllegalArgumentException("Related post with ID " + dto.getRelatedPostId() + " not found."));
        }

        PostModel newPost = new PostModel();
        newPost.setDescription(dto.getDescription());
        newPost.setImage(dto.getImage());
        newPost.setVisible(dto.getVisible());
        newPost.setDatePost(new Date());
        newPost.setCreator(creator);
        newPost.setRelated(relatedPost);


        community.getPosts().add(newPost);
        communityRepository.save(community);

        return CommunityMapper.toDTO(community, creator);
    }

    public CommunityDTO createCommunity(CreateCommunityDTO dto, Authentication auth) {
        UserModel admin = userService.authenticate(auth);

        CategoryModel category = null;
        if (dto.getCategoryId() != null) {
            category = categoryRepository.findById(dto.getCategoryId())
                    .orElseThrow(() -> new IllegalArgumentException("Category with ID " + dto.getCategoryId() + " not found."));
        }

        List<UserModel> listUsers = new ArrayList<>();
        listUsers.add(admin);

        CommunityModel community = new CommunityModel();
        community.setNom(dto.getNom());
        community.setDescription(dto.getDescription());
        community.setPublic(dto.getIsPublic());
        community.setAdmin(admin);
        community.setImage(dto.getImage());
        community.setCategory(category);
        community.setUsers(listUsers);
        community.setPosts(new ArrayList<>());

        CommunityModel savedCommunity = communityRepository.save(community);

        return CommunityMapper.toDTO(savedCommunity, admin);
    }

    public CommunityDTO joinCommunity(Long communityId, Authentication auth) {
        UserModel user = userService.authenticate(auth);

        CommunityModel result = communityRepository.findById(communityId).orElseThrow(() -> new NoContentException("Community with ID " + communityId + " not found."));
        List<UserModel> list = result.getUsers();
        list.add(user);
        result.setUsers(list);
        return CommunityMapper.toDTO(communityRepository.save(result), user);
    }

    public CommunityDTO removePostFromCommunity(Long communityId, Long postId, Authentication auth) {
        UserModel user = userService.authenticate(auth);
        CommunityModel community = communityRepository.findById(communityId)
                .orElseThrow(() -> new NoContentException("Community with ID " + communityId + " not found."));

        PostModel post = postRepository.findById(postId)
                .orElseThrow(() -> new IllegalArgumentException("Post with ID " + postId + " not found."));

        if (!community.getPosts().contains(post)) {
            throw new IllegalArgumentException("Post with ID " + postId + " is not associated with the community.");
        }

        community.getPosts().remove(post);
        communityRepository.save(community);

        return CommunityMapper.toDTO(community, user);
    }

    public CommunityDTO updateCommunity(Long communityId, UpdateCommunityDTO dto, Authentication auth) {
        UserModel user = userService.authenticate(auth);
        CommunityModel community = communityRepository.findById(communityId)
                .orElseThrow(() -> new NoContentException("Community with ID " + communityId + " not found."));

        if (dto.getNom() != null) {
            community.setNom(dto.getNom());
        }
        if (dto.getDescription() != null) {
            community.setDescription(dto.getDescription());
        }
        if (dto.getIsPublic() != null) {
            community.setPublic(dto.getIsPublic());
        }
        if (dto.getCategoryId() != null) {
            CategoryModel category = categoryRepository.findById(dto.getCategoryId())
                    .orElseThrow(() -> new IllegalArgumentException("Category with ID " + dto.getCategoryId() + " not found."));
            community.setCategory(category);
        }

        CommunityModel updatedCommunity = communityRepository.save(community);

        return CommunityMapper.toDTO(updatedCommunity, user);
    }

    public void deleteCommunity(Long communityId) {
        // Recherche de la communauté
        CommunityModel community = communityRepository.findById(communityId)
                .orElseThrow(() -> new NoContentException("Community with ID " + communityId + " not found."));

        // Suppression de la communauté
        communityRepository.delete(community);
    }

}
