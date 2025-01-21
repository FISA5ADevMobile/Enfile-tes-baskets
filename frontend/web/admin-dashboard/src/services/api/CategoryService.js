import axios from "axios";
import { mapCategoryModel } from "../../utils/mapping";
import Cookies from 'js-cookie';

export class CategoryService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;


    // CRUD operations
    async getAllCategories() {
        try {
            const response = await axios.get(`${this.apiUrl}/categories/all`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data.map(mapCategoryModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getCategoryById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/categories/${id}`, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: mapCategoryModel(response.data) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async createCategory(category) {
        try {
            const response = await axios.post(`${this.apiUrl}/categories/create`, category, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

}