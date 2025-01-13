package com.enfiletesbaskets.enfiletesbaskets.mapper;

import com.enfiletesbaskets.enfiletesbaskets.dto.CreateCategoryDTO;
import com.enfiletesbaskets.enfiletesbaskets.models.CategoryModel;

public class CategoryMapper {

    public static CategoryModel toModel(CreateCategoryDTO createCategoryDTO) {
        CategoryModel categoryModel = new CategoryModel();
        categoryModel.setName(createCategoryDTO.getName());
        return categoryModel;
    }

    public static CreateCategoryDTO toDTO(CategoryModel categoryModel) {
        CreateCategoryDTO createCategoryDTO = new CreateCategoryDTO();
        createCategoryDTO.setName(categoryModel.getName());
        return createCategoryDTO;
    }
}
