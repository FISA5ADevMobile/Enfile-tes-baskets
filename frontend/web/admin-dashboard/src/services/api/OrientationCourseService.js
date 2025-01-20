import axios from "axios";
import { mapClassModel, mapTagModel, mapUserModel } from "../../utils/mapping";
import Cookies from 'js-cookie';

export class OrientationCourseService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;


    // CRUD operations

    async getAllClasses() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/classes/all`,
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

    // STATS
    async getOrientationCourseStats() {
        const responseTags = await this.getAllTags();
        // const responseClasses = await this.getAllClasses();

        // if (responseTags.error || responseClasses.error) {
        //     return { error: true, message: responseTags.message || responseClasses.message };
        // }
        if (responseTags.error) {
            return { error: true, message: responseTags.message };
        }

        const stats = {
            totalTags: responseTags.data.length,
            // totalClasses: responseClasses.data,
        };
        return { error: false, data: stats };
    }

}