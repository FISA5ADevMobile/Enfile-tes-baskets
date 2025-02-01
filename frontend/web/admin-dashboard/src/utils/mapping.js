// models mapping

import { Category } from "@mui/icons-material"
import { handleFormatDate, handleFormatBoolean } from "./helper"

export const mapActualityModel = (actuality) => {
    return {
        id: actuality.id,
        title: actuality.title,
        description: actuality.description,
        image: actuality.image,
        event: actuality.event,
        publicationDate: new Date(actuality.publicationDate),
    }
}

export const mapUserModel = (user) => {
    return {
        id: user.id ?? "",
        email: user.email ?? "",
        pseudo: user.pseudo ?? "",
        firstName: user.firstName ?? "",
        name: user.name ?? "",
        role: user.role ?? "",
        nbPostDeleted: user.nbPostDeleted ?? 0,
        banDate: user.banDate ? new Date(user.banDate) : null,
        code: user.code ?? "",
        courses: user.courses ?? [],
    }
}


export const mapPostModel = (post) => {
    return {
        id: post.id,
        content: post.content,
        image: post.imageUrl,
        datePost: post.datePost,
        nbLike: post.nbLike,
        nbPost: post.nbPost,
        banDate: post.banDate ? new Date(post.banDate) : null,
        username: post.username,
        visible: post.visible
    }
}

export const mapCategoryModel = (category) => {
    return {
        id: category.id,
        name: category.name,
        communities: category.communities ?? [],
    }
}


export const mapCommunityModel = (community) => {
    return {
        id: community.id,
        name: community.name,
        description: community.description,
        banDate: community.banDate,
        isPublic: handleFormatBoolean(community.isPublic),
        adminId: community.adminId,
        moderatorIds: community.moderatorIds,
        bannedUserIds: community.bannedUserIds,
        postIds: community.postIds,
        categoryName: community.categoryName
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
        password: aClass.password,
        time: aClass.time,
        beginDate: aClass.beginDate,
        endDate: aClass.endDate,
    }
}

export const mapTagModel = (tag) => {
    return {
        id: tag.id,
        name: tag.name,
        description: tag.description,
        xPos: tag.xPos,
        yPos: tag.yPos,
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
        event: handleFormatBoolean(mapModel.event),
        publicationDate: handleFormatDate(mapModel.publicationDate),
    }
}

export const mapCommunityForDataGrid = (community) => {
    const mapModel = mapCommunityModel({
        ...community,
        name: community.name
    });
    return {
        id: mapModel.id,
        name: mapModel.name,
        description: mapModel.description,
        isPublic: mapModel.isPublic,
        categoryName: mapModel.categoryName,
    }
}


export const mapPostForDataGrid = (post) => {
    const mapModel = mapPostModel(post);
    return {
        id: mapModel.id,
        content: mapModel.content,
        username: mapModel.username,
        datePost: handleFormatDate(new Date(mapModel.datePost)),
        nbLike: mapModel.nbLike ?? 0,
        visible: handleFormatBoolean(mapModel.visible),
    }
}

export const mapTagForDataGrid = (tag) => {
    const mapModel = mapTagModel(tag);
    return {
        id: mapModel.id,
        name: mapModel.name,
        description: mapModel.description,
    }
}

export const mapClassForDataGrid = (aClass) => {
    const mapModel = mapClassModel(aClass);
    return {
        id: mapModel.id,
        name: mapModel.name,
        description: mapModel.description,
    }
}