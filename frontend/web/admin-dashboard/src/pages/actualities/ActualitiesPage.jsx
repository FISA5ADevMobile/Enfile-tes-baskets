import { motion } from "framer-motion";

import Header from "../../components/common/Header";
import StatCard from "../../components/common/StatCard";

import {
  AlertTriangle,
  DollarSign,
  Newspaper,
  Package,
  TrendingUp,
} from "lucide-react";
import ActualitiesTable from "../../components/actualities/ActualitiesTable";
import { Link } from "react-router-dom";
import { Button } from "@mui/material";
import { Add } from "@mui/icons-material";
import { AppContext } from "../../services/context/AppContext";
import { useState, useContext, useEffect } from "react";
import { ToastContainer } from "react-toastify";

const ActualitiesPage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Actualités" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        {/* STATS */}
        <ActualityStats />

        {/* <ProductsTable /> */}

        <div className="flex justify-end mb-4 space-x-4">
          <Link to="/nouvelle-actualite">
            <Button
              variant="text"
              startIcon={<Add />}
            >
              Créer une nouvelle
            </Button>
          </Link>
        </div>

        <ActualitiesTable />

        <ToastContainer />

        {/* CHARTS */}
        {/* <div className='grid grid-col-1 lg:grid-cols-2 gap-8'>
					<SalesTrendChart />
					<CategoryDistributionChart />
				</div> */}
      </main>
    </div>
  );
};
export default ActualitiesPage;

export const ActualityStats = ({ title }) => {
  const [actualityStats, setActualityStats] = useState({
    total: "...",
    publishedLastSevenDays: "...",
  });
  const { actualityService } = useContext(AppContext);

  const getActualityStats = async () => {
    const response = await actualityService.getActualityStats();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      setActualityStats(response.data);
    }
  };

  useEffect(() => {
    getActualityStats();
  }, []);

  return (
    <>
      {title && (
        <motion.div
          className="text-3xl font-bold mb-4"
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 1 }}
        >
          {title}
        </motion.div>
      )}

      <motion.div
        className="grid grid-cols-1 gap-5 sm:grid-cols-2 lg:grid-cols-4 mb-8"
        initial={{ opacity: 0, y: 20 }}
        animate={{ opacity: 1, y: 0 }}
        transition={{ duration: 1 }}
      >
        <StatCard
          name="Total Actualités"
          icon={Newspaper}
          value={actualityStats.total}
          color="#6366F1"
        />

        <StatCard
          name="Les 7 derniers jours"
          icon={Newspaper}
          value={actualityStats.publishedLastSevenDays}
          color="#10B981"
        />
      </motion.div>
    </>
  );
};
