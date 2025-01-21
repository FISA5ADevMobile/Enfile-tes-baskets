import axios from "axios";
import { mapCommunityModel, mapUserModel } from "../../utils/mapping";
import Cookies from 'js-cookie';

export class CommunityService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations
    async getAllCommunities() {
        try {
            const response = await axios.get(`${this.apiUrl}/communities/all`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data?.length ? response.data.map(mapCommunityModel) : [] };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getCommunityById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/communities/${id}`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }
            );
            return { error: false, data: mapCommunityModel(response.data) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async createCommunity(community) {
        try {
            const response = await axios.post(`${this.apiUrl}/communities`, community,
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

    async updateCommunity(community) {
        try {
            const response = await axios.put(`${this.apiUrl}/communities`, community,
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

    async deleteCommunityById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/communities/${id}`,
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

    async removePostFromCommunity(communityId, postId) {
        try {
            const response = await axios.delete(`${this.apiUrl}/communities/${communityId}/post/${postId}`,
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
        };
        return { error: false, data: communityStats };
    }





}