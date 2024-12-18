package com.enfiletesbaskets.enfiletesbaskets.controllers;
import com.enfiletesbaskets.enfiletesbaskets.dto.CommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CreateCommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CreatePostDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.UpdateCommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.exception.NoContentException;
import com.enfiletesbaskets.enfiletesbaskets.services.CommunityService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/communities")
public class CommunityController {

    @Resource
    private CommunityService communityService;

    @GetMapping("/all")
    public ResponseEntity<?> getAllCommunities() {
        try {
            List<CommunityDTO> res = communityService.getAllCommunities();
            return ResponseEntity.ok(res);
        } catch (NoContentException e){
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getCommunityById(@PathVariable Long id) {
        try {
            CommunityDTO communityDTO = communityService.getCommunityById(id);
            return ResponseEntity.ok(communityDTO);
        } catch (NoContentException e) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PostMapping
    public ResponseEntity<?> createCommunity(@RequestBody CreateCommunityDTO dto) {
        try {
            CommunityDTO newCommunity = communityService.createCommunity(dto);
            return ResponseEntity.status(HttpStatus.CREATED).body(newCommunity);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }


    @PostMapping("/post/{communityId}")
    public ResponseEntity<?> createPostInCommunity(@PathVariable Long communityId, @RequestBody CreatePostDTO dto) {
        try {
            CommunityDTO updatedCommunity = communityService.createPostInCommunity(communityId, dto);
            return ResponseEntity.ok(updatedCommunity);
        } catch (NoContentException e) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @DeleteMapping("/{communityId}/post/{postId}")
    public ResponseEntity<?> removePostFromCommunity(@PathVariable Long communityId, @PathVariable Long postId) {
        try {
            CommunityDTO updatedCommunity = communityService.removePostFromCommunity(communityId, postId);
            return ResponseEntity.ok(updatedCommunity);
        } catch (NoContentException e) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @PutMapping("/{communityId}")
    public ResponseEntity<?> updateCommunity(@PathVariable Long communityId, @RequestBody UpdateCommunityDTO dto) {
        try {
            CommunityDTO updatedCommunity = communityService.updateCommunity(communityId, dto);
            return ResponseEntity.ok(updatedCommunity);
        } catch (NoContentException e) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @DeleteMapping("/{communityId}")
    public ResponseEntity<?> deleteCommunity(@PathVariable Long communityId) {
        try {
            communityService.deleteCommunity(communityId);
            return ResponseEntity.ok("Communauté supprimé"); // Pas de contenu à retourner
        } catch (NoContentException e) {
            return ResponseEntity.status(HttpStatus.NO_CONTENT).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }


}
