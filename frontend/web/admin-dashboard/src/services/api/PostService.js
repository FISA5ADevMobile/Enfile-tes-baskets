import axios from "axios";
import { mapPostModel, mapUserModel } from "../../utils/mapping";
import Cookies from 'js-cookie';

export class PostService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations
    async getAllPosts() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/post/all`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }
            );
            return { error: false, data: response.data.length ? response.data.map(mapPostModel) : [] };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getPostById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/post/${id}`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: mapPostModel(response.data) ?? response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async banPostById(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/post/ban/${id}`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async hidePostById(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/post/hide/${id}`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    // async deletePostById(id) {
    //     try {
    //         const response = await axios.delete(`${this.apiUrl}/api/post/delete/${id}`, {
    //             headers: {
    //                 Authorization: `Bearer ${Cookies.get('token')}`,
    //             }
    //         });
    //         return { error: false, data: response.data };
    //     } catch (error) {
    //         return { error: true, message: error.message };
    //     }
    // }

    // async makeVisiblePost(id) {
    //     try {
    //         const response = await axios.put(`${this.apiUrl}/api/post/visible/${id}`, {}, {
    //             headers: {
    //                 Authorization: `Bearer ${Cookies.get('token')}`,
    //             }
    //         });
    //         return { error: false, data: response.data };
    //     } catch (error) {
    //         return { error: true, message: error.message };
    //     }
    // }

    async makeInvisiblePost(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/post/invisible/${id}`, {}, {
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
    async getPostStats() {
        const response = await this.getAllPosts();
        if (response.error) {
            return { error: true, message: response.message };
        }
        const posts = response.data;
        const postStats = {
            total: posts.length,
            visible: posts.filter((post) => post.visible).length,
            invisible: posts.filter((post) => !post.visible).length
        };
        return { error: false, data: postStats };
    }
}