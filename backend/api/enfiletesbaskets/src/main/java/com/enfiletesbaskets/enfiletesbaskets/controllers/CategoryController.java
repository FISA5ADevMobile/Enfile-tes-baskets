package com.enfiletesbaskets.enfiletesbaskets.controllers;

import com.enfiletesbaskets.enfiletesbaskets.dto.CategoryDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CommunityDTO;
import com.enfiletesbaskets.enfiletesbaskets.dto.CreateCategoryDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.CategoryModel;
import com.enfiletesbaskets.enfiletesbaskets.services.CategoryService;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.*;
import jakarta.annotation.Resource;

import java.util.List;

@RestController
@RequestMapping("/categories")
public class CategoryController {

    @Resource
    private CategoryService categoryService;

    // Ajoutez des endpoints (méthodes REST) si nécessaire

    @GetMapping("/all")
    public List<CategoryModel> getAllCategories() {
        return categoryService.getAllCategories();
    }

    @GetMapping("/{id}")
    public CategoryModel getCategoryById(@PathVariable Long id) {
        return categoryService.getCategoryById(id);
    }

    @PostMapping("/create")
    public ResponseEntity<?> createCategory(@RequestBody CreateCategoryDTO dto, Authentication auth) {
        try {
            CreateCategoryDTO newCategory = categoryService.createCategory(dto, auth);
            return ResponseEntity.status(HttpStatus.CREATED).body(newCategory);
        } catch (IllegalArgumentException e) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(e.getMessage());
        }
    }

    @DeleteMapping("/delete/{id}")
    public void deleteCategory(@PathVariable Long id) {
        categoryService.deleteCategory(id);
    }
}
