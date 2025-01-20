import axios from 'axios';
import Cookies from 'js-cookie';
import { mapUserModel } from '../../utils/mapping';

export class AuthService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations
    async login(email, password, rememberMe) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/auth/login`, {
                email: email,
                password: password
            });
            if (response.data.token && response.status === 200) {
                Cookies.set('token', response.data.token, { expires: rememberMe ? 7 : null });
                Cookies.set('userId', response.data.id);
                axios.defaults.headers.common[
                    "Authorization"
                ] = `Bearer ${response.data.token}`;
                return { error: false, data: response.data };
            }
            return { error: true, message: response.data.message };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async logout() {
        Cookies.remove('token');
        Cookies.remove('userId');
        delete axios.defaults.headers.common["Authorization"];
    }

    isLoggedIn() {
        const token = Cookies.get('token');
        return !!token;
    }

    async getCurrentUserId() {
        const userId = Cookies.get('userId');
        return userId;
    }

    async getCurrentUser() {
        try {
            const userId = Cookies.get('userId');
            if (!userId) {
                return { error: true, message: "User not found" };
            }
            const response = await axios.get(`${this.apiUrl}/api/users/${userId}`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        }
        catch (error) {
            return { error: true, message: error.message };
        }
    }


}