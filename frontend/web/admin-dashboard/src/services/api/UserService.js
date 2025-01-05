
import axios from "axios";
import { mapUserModel } from "../../utils/mapping";
import Cookies from 'js-cookie';

export class UserService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations
    // async createUser(user) {
    //     try {
    //         const response = await axios.post(`${this.apiUrl}/api/users/add_user`, user, {
    //             headers: {
    //                 Authorization: `Bearer ${Cookies.get('token')}`,
    //             }
    //         });
    //         return { error: false, data: response.data.map(mapUserModel) };
    //     } catch (error) {
    //         return { error: true, message: error.message };
    //     }
    // }


    async getAllUsers() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/users/all`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data.map(mapUserModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getUserById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/users/get_1/${id}`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: mapUserModel(response.data) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getUserMe() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/users/me`, {}, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: mapUserModel(response.data) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async banUserById(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/users/ban/${id}`, {}, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async unbanUserById(id) {
        try {
            const response = await axios.put(`${this.apiUrl}/api/users/unban/${id}`, {}, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async deleteUserById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/users/delete/${id}`, {}, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async authorizeResetPassword(email, code) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/auth/validate-reset-password`, {
                email: email,
                code: Number(code)
            }, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                    "Content-Length": 58,
                    "Content-Type": "application/json"
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async resetPassword(passwordReset) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/auth/reset-password`, passwordReset);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }


    // STATS 
    async getUserStats() {
        const response = await this.getAllUsers();
        if (response.error) {
            return { error: true, message: response.message };
        }
        const users = response.data;
        const userStats = {
            total: users.length,
            banned: users.filter((user) => !!user.banDate).length,
            active: users.filter((user) => !user.banDate).length
        };
        return { error: false, data: userStats };
    }



}