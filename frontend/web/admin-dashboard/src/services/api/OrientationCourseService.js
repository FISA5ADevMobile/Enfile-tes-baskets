import axios from "axios";
import { mapClassModel, mapTagModel, mapUserModel } from "../../utils/mapping";
import Cookies from 'js-cookie';
import { data } from "autoprefixer";

export class OrientationCourseService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;


    // CRUD operations

    // TAGS

    async getAllTags() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/tags`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }

            );
            return { error: false, data: response.data.map(mapTagModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }



    async deleteTagById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/tags/${id}/delete`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }
            );
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }


    async createTag(tag) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/tags`, tag,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getTagById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/tags/${id}`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async updateTagById(id, tag) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/tags/${id}`, tag,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    // CLASSES

    async getAllClasses() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/classes`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }
            );
            return { error: false, data: response.data.map(mapClassModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }


    async createClass(classData) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/classes`, classData,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async updateClassById(id, classData) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/classes/${id}`, classData,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getClassById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/classes/${id}`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async updateClassById(id, classData) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/classes/${id}`, classData,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async deleteClassById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/classes/${id}`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }
            );
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    // Class and Tags

    async addTagsToClass(classId, tagIds) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/classes/${classId}/tags`, tagIds,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async deleteTagsFromClass(classId, tagIds) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/classes/${classId}/tags`,
                {
                    data: tagIds,
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data };
        } catch (error) {
            console.log(error);
            return { error: true, message: error.message };
        }
    }

    async getTagsFromClass(classId) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/classes/${classId}/tags`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                });
            return { error: false, data: response.data.map(mapTagModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    // STATS
    async getOrientationCourseStats() {
        const responseTags = await this.getAllTags();
        const responseClasses = await this.getAllClasses();

        if (responseTags.error || responseClasses.error) {
            return { error: true, message: responseTags.message || responseClasses.message };
        }
        if (responseTags.error) {
            return { error: true, message: responseTags.message };
        }

        const stats = {
            totalTags: responseTags.data.length,
            totalClasses: responseClasses.data.length,
        };
        return { error: false, data: stats };
    }

}