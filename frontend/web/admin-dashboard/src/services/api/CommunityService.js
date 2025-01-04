import axios from "axios";
import { mapUserModel } from "../../utils/mapping";

export class CommunityService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations
    async getAllCommunities() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/communities/all`);
            return { error: false, data: response.data.map(mapUserModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getCommunityById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/communities/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async createCommunity(community) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/communities`, community);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async updateCommunity(community) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/communities`, community);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async deleteCommunityById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/communities/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async removePostFromCommunity(communityId, postId) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/communities/${communityId}/post/${postId}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }


    // STATS
    async getCommunityStats() {
        const response = await this.getAllCommunities();
        if (response.error) {
            return { error: true, message: response.message };
        }
        const communities = response.data;
        const communityStats = {
            total: communities.length,
            public: communities.filter((community) => community.isPublic).length,
            private: communities.filter((community) => !community.isPublic).length,
            banned: communities.filter((community) => !!community.banDate).length,
            active: communities.filter((community) => !community.banDate).length
        };
        return { error: false, data: communityStats };
    }





}