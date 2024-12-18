package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.CreatePostDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.PostDTO;
import com.enfiletesbaskets.enfiletesbaskets.exception.NoContentException;
import com.enfiletesbaskets.enfiletesbaskets.exception.PostNotFound;
import com.enfiletesbaskets.enfiletesbaskets.exception.UserNotFound;
import com.enfiletesbaskets.enfiletesbaskets.mapper.PostMapper;
import com.enfiletesbaskets.enfiletesbaskets.models.PostModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.PostRepository;
import com.enfiletesbaskets.enfiletesbaskets.repositories.UserRepository;
import org.springframework.stereotype.Service;

import jakarta.annotation.Resource;

import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class PostService {

    @Resource
    private PostRepository postRepository;

    @Resource
    private UserRepository userRepository;

    // Ajoutez des méthodes et des dépendances si nécessaire
    public List<PostDTO> getAllPost(){
        List<PostModel> posts = postRepository.findAll();
        System.out.println("RESULT / " + posts);
        if (posts.isEmpty()) {
            throw new NoContentException("No post found.");
        }
        return posts.stream().map(PostMapper::toDTO).collect(Collectors.toList());
    }

    public PostDTO getPostById(Long id){
        PostModel res = postRepository.findById(id).orElse(null);
        if (res == null) { throw new NoContentException("No post found with id: " + id); }
        return PostMapper.toDTO(res);
    }

    public PostDTO likePost(Long id){
        PostModel res = postRepository.findById(id).orElse(null);
        if (res == null) { throw new NoContentException("No post found with id: " + id); }
        res.setNbLike(res.getNbLike() + 1);
        return  PostMapper.toDTO(postRepository.save(res));
    }

    public PostModel createPost(CreatePostDTO dto){
        UserModel creator = userRepository.findByEmail(dto.getToken());
        if (creator == null) {
            throw new UserNotFound("User not found with email: " + dto.getToken());
        }

        PostModel relatedPost = null;
        if (dto.getRelatedPostId() != null) {
            relatedPost = postRepository.findById(dto.getRelatedPostId())
                    .orElseThrow(() -> new PostNotFound("Related post not found with ID: " + dto.getRelatedPostId()));
        }

        PostModel post = new PostModel();
        post.setDescription(dto.getDescription());
        post.setImage(dto.getImage());
        post.setDatePost(new Date());
        post.setVisible(dto.getVisible());
        post.setCreator(creator);
        post.setRelated(relatedPost);
        post.setNbLike(0);
        post.setNbPost(0);

        return postRepository.save(post);
    }
}
