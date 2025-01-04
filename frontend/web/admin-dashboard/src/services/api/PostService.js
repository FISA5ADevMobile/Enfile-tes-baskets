import axios from "axios";
import { mapPostModel, mapUserModel } from "../../utils/mapping";

export class PostService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations
    async getAllPosts() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/post/all`);
            return { error: false, data: response.data.map(mapPostModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getPostById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/post/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async banPostById(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/post/ban/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async hidePostById(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/post/hide/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async deletePostById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/post/delete/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }


    // STATS
    async getPostStats() {
        const response = await this.getAllPosts();
        if (response.error) {
            return { error: true, message: response.message };
        }
        const posts = response.data;
        const postStats = {
            total: posts.length,
            // banned: posts.filter((post) => !!post.banDate).length,
            // active: posts.filter((post) => !post.banDate).length
        };
        return { error: false, data: postStats };
    }
}