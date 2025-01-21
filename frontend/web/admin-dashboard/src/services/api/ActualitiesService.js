import axios from "axios";
import { mapActualityModel } from "../../utils/mapping";
import Cookies from 'js-cookie';

export class ActualityService {
    apiUrl = import.meta.env.VITE_ETB_API_URL;

    // CRUD operations

    async createActuality(actuality) {
        try {
            const response = await axios.post(`${this.apiUrl}/api/actualities/add_actuality`, actuality, {
                headers: {
                    Authorization: `Bearer ${Cookies.get('token')}`,
                }
            });

            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getAllActualities() {
        try {
            const response = await axios.get(`${this.apiUrl}/api/actualities/get_all`,
                {
                    headers: {
                        Authorization: `Bearer ${Cookies.get('token')}`,
                    }
                }
            );
            // console.log(response.data);
            return { error: false, data: response.data };
        } catch (error) {
            return { error: true, message: error.message };
        }
    }

    async getActualityById(id) {
        try {
            const response = await axios.get(`${this.apiUrl}/api/actualities/get_1/${id}`,
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

    async deleteActualityById(id) {
        try {
            const response = await axios.delete(`${this.apiUrl}/api/actualities/delete/${id}`,
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

    async getActualityStats() {

        const response = await this.getAllActualities();
        if (response.error) {
            return { error: true, message: response.message };
        }
        const actualities = response.data;
        const actualyStats = {
            total: actualities.length,
            publishedLastSevenDays: actualities.filter((actuality) => {
                actuality.publicationDate = new Date(actuality.publicationDate);
                const today = new Date();
                const sevenDaysAgo = new Date(today);
                sevenDaysAgo.setDate(today.getDate() - 7);
                return actuality.publicationDate >= sevenDaysAgo;
            }).length
        };
        return { error: false, data: actualyStats };
    }

}