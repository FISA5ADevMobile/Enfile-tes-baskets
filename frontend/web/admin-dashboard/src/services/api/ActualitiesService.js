import axios from "axios";
import { mapActualityModel } from "../../utils/mapping";

export class ActualityService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations

    async createActuality(actuality) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/actualities/add_actuality`, actuality);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getAllActualities() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/actualities/get_all`);
            return { error: false, data: response.data.map(mapActualityModel) };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getActualityById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/actualities/get_1/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async deleteActualityById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/actualities/delete/${id}`);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    // STATS

    async getActualityStats() {

        const response = await this.getAllActualities();
        if (response.error) {
            return { error: true, message: response.message };
        }
        const actualities = response.data;
        const actualyStats = {
            total: actualities.length,
            plublishedLastSevenDays: actualities.filter((actuality) => {
                const date = new Date(actuality.createdAt);
                const today = new Date();
                const diffInDays = Math.floor((today - date) / (1000 * 60 * 60 * 24));
                return diffInDays <= 7;
            })
        };
        return { error: false, data: actualyStats };
    }

}