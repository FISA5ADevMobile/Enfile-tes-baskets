import axios from "axios";
import { mapUserModel } from "../../utils/mapping";

export class OrientationCourseService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;


    // CRUD operations

    async getAllClasses() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/classes/all`);
            return { error: false, data: response.data.map(mapUserModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getAllTags() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/tags/all`);
            return { error: false, data: response.data.map(mapUserModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }



    async deleteTagById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/tags/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }


    async createTag(tag) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/tags/add_tag`, tag);
            return { error: false, data: response.data.map(mapUserModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getTagById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/tags/${id}`);
            return { error: false, data: response.data };
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

        const stats = {
            totalTags: responseTags.data.length,
            totalClasses: responseClasses.data,
        };
        return { error: false, data: stats };
    }

}