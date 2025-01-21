package com.enfiletesbaskets.enfiletesbaskets.services;

import com.enfiletesbaskets.enfiletesbaskets.dto.CreateCategoryDTO;
import com.enfiletesbaskets.enfiletesbaskets.mapper.CategoryMapper;
import com.enfiletesbaskets.enfiletesbaskets.models.CategoryModel;
import com.enfiletesbaskets.enfiletesbaskets.models.UserModel;
import com.enfiletesbaskets.enfiletesbaskets.repositories.CategoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;
import jakarta.annotation.Resource;

import java.util.List;

@Service
public class CategoryService {

    @Autowired
    private UserService userService;

    @Resource
    private CategoryRepository categoryRepository;

    public List<CategoryModel> getAllCategories() {
        return categoryRepository.findAll().stream().map(category -> {
            CategoryModel categoryModel = new CategoryModel();
            categoryModel.setId(category.getId());
            categoryModel.setName(category.getName());
            return categoryModel;
        }).toList();
    }

    public CategoryModel getCategoryById(Long id) {
        return categoryRepository.findById(id).map(category -> {
            CategoryModel categoryModel = new CategoryModel();
            categoryModel.setId(category.getId());
            categoryModel.setName(category.getName());
            return categoryModel;
        }).orElse(null);
    }

    public CreateCategoryDTO createCategory(CreateCategoryDTO dto, Authentication auth) {
        UserModel admin = userService.authenticate(auth);

        CategoryModel category = new CategoryModel();
        category.setName(dto.getName());

        CategoryModel savedCategory = categoryRepository.save(category);

        return CategoryMapper.toDTO(categoryRepository.save(category));
    }

    public void deleteCategory(Long id) {
        if (categoryRepository.findById(id).isEmpty()) {
            throw new IllegalArgumentException("Category with ID " + id + " not found.");
        }

        CategoryModel category = categoryRepository.findById(id).get();
        if (!category.getCommunities().isEmpty()) {
            throw new IllegalArgumentException("Category with ID " + id + " has communities and cannot be deleted.");
        }

        categoryRepository.deleteById(id);
    }

}
