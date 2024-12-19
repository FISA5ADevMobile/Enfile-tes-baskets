package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.CreatePostDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.PostDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.UpdatePostDTO;
import com.enfiletesbaskets.enfiletesbaskets.exception.NoContentException;
import com.enfiletesbaskets.enfiletesbaskets.exception.PostNotFound;
import com.enfiletesbaskets.enfiletesbaskets.exception.UserNotFound;
import com.enfiletesbaskets.enfiletesbaskets.mapper.PostMapper;
import com.enfiletesbaskets.enfiletesbaskets.models.PostModel;
import com.enfiletesbaskets.enfiletesbaskets.services.PostService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

import java.util.List;

@RestController
@RequestMapping("/api/post")
public class PostController {

    @Resource
    private PostService postService;

    @GetMapping("/all")
    public ResponseEntity<?> getAllPosts() {
        try {
            List<PostDTO> res = postService.getAllPost();
            return ResponseEntity.ok(res);
        } catch (NoContentException e){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PostMapping
    public ResponseEntity<?> createPost(@RequestBody CreatePostDTO createPostDTO, Authentication auth) {
        try {
            PostModel createdPost = postService.createPost(createPostDTO, auth);
            PostDTO response = PostMapper.toDTO(createdPost);
            return ResponseEntity.ok(response);
        } catch (UserNotFound | PostNotFound e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPostById(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(postService.getPostById(id));
        } catch (PostNotFound e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PutMapping("/like/{id}")
    public ResponseEntity<?> likePost(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(postService.likePost(id));
        } catch (PostNotFound e){
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PutMapping("/{postId}")
    public ResponseEntity<?> updatePost(@PathVariable Long postId, @RequestBody UpdatePostDTO dto) {
        try {
            PostDTO updatedPost = postService.updatePost(postId, dto);
            return ResponseEntity.ok(updatedPost);
        } catch (NoContentException e) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

}
