// models mapping

import { Category } from "@mui/icons-material"
import { handleFormatDate } from "./helper"

export const mapActualityModel = (actuality) => {
    return {
        id: actuality.id,
        title: actuality.title,
        description: actuality.description,
        image: actuality.image,
        event: actuality.event,
        publicationDate: actuality.publicationDate
    }
}

export const mapUserModel = (user) => {
    return {
        id: user.id,
        email: user.email,
        pseudo: user.pseudo,
        firstName: user.firstName,
        name: user.lastName,
        role: user.role,
        nbPostDeleted: user.nbPostDeleted,
        banDate: user.banDate,
        code: user.code,
        tags: user.tags,
        courses: user.courses
    }
}


export const mapPostModel = (post) => {
    return {
        id: post.id,
        description: post.description,
        image: post.image,
        datePost: post.datePost,
        nbLike: post.nbLike,
        nbPost: post.nbPost,
        banDate: post.banDate,
        user: mapUserModel(post.user),
    }
}

export const mapCategoryModel = (category) => {
    return {
        id: category.id,
        name: category.name,
        communities: category.communities.map(mapCommunityModel)
    }
}


export const mapCommunityModel = (community) => {
    return {
        id: community.id,
        name: community.nom,
        description: community.description,
        banDate: community.banDate,
        isPublic: community.isPublic,
        admin: mapUserModel(community.admin),
        users: community.users.map(mapUserModel),
        moderators: community.moderators.map(mapUserModel),
        posts: community.posts.map(mapPostModel),
        bannedUsers: community.bannedUsers.map(mapUserModel),
        category: mapCategoryModel(community.category)?.name
    }
}

export const mapCourseModel = (course) => {
    return {
        id: course.id,
        name: course.name,
        user: mapUserModel(course.user),
        beginDate: course.beginDate,
        endDate: course.endDate,
        classes: course.classes.map(mapClassModel),
        tags: course.tags.map(mapTagModel)
    }
}

export const mapClassModel = (aClass) => {
    return {
        id: aClass.id,
        name: aClass.name,
        description: aClass.description,
        owner: mapUserModel(aClass.owner),
        tag: mapTagModel(aClass.tag),
        password: aClass.password,
        time: aClass.time,
        beginDate: aClass.beginDate,
        endDate: aClass.endDate,
        tags: tags.map(mapTagModel),
        courses: aClass.courses.map(mapCourseModel),
    }
}

export const mapTagModel = (tag) => {
    return {
        id: tag.id,
        name: tag.name,
        description: tag.description,
        xPos: tag.xPos,
        yPos: tag.yPos,
        classes: tag.classes.map(mapClassModel),
        courses: tag.courses.map(mapCourseModel),
        user: mapUserModel(tag.user)
    }
}


// data grid mapping

export const mapUserForDataGrid = (user) => {
    const mapModel = mapUserModel(user);
    return {
        id: mapModel.id,
        email: mapModel.email,
        pseudo: mapModel.pseudo,
        fullName: `${mapModel.firstName} ${mapModel.name}`,
        role: mapModel.role,
    }
}


export const mapActualityForDataGrid = (actuality) => {
    const mapModel = mapActualityModel(actuality);
    return {
        id: mapModel.id,
        title: mapModel.title,
        description: mapModel.description,
        event: mapModel.event,
        publicationDate: handleFormatDate(new Date(mapModel.publicationDate)),
    }
}

export const mapCommunityForDataGrid = (community) => {
    const mapModel = mapCommunityModel(community);
    return {
        id: mapModel.id,
        name: mapModel.name,
        description: mapModel.description,
        isPublic: mapModel.isPublic,
        categoryName: mapModel.category?.name,
    }
}


export const mapPostForDataGrid = (post) => {
    const mapModel = mapPostModel(post);
    return {
        id: mapModel.id,
        description: mapModel.description,
        userPseudo: mapModel.user?.pseudo,
        datePost: handleFormatDate(new Date(mapModel.datePost)),
        nbLike: mapModel.nbLike,
    }
}

export const mapTagForDataGrid = (tag) => {
    const mapModel = mapTagModel(tag);
    return {
        id: mapModel.id,
        name: mapModel.name,
        description: mapModel.description,
        ownerPseudo: mapModel.user?.pseudo
    }
}