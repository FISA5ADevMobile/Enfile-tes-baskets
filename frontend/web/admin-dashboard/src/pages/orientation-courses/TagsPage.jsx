import { motion } from "framer-motion";

import Header from "../../components/common/Header";
import StatCard from "../../components/common/StatCard";

import {
  AlertTriangle,
  DollarSign,
  Newspaper,
  Package,
  Shapes,
  Tags,
  TrendingUp,
} from "lucide-react";
import CategoryDistributionChart from "../../components/overview/CategoryDistributionChart";
import SalesTrendChart from "../../components/actualities/SalesTrendChart";
import ProductsTable from "../../components/actualities/ProductsTable";
import ActualitiesTable from "../../components/actualities/ActualitiesTable";
import { Link } from "react-router-dom";
import { Button } from "@mui/material";
import { Add } from "@mui/icons-material";
import { AppContext } from "../../services/context/AppContext";
import { useState, useContext, useEffect } from "react";
import { ToastContainer } from "react-toastify";
import TagsTable from "../../components/orientation-courses/TagsTable";

const TagsPage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Actualités" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        {/* STATS */}
        <TagStats />

        {/* <ProductsTable /> */}

        <div className="flex justify-end mb-4 space-x-4">
          <Link to="/nouvelle-balise">
            <Button
              variant="text"
              startIcon={<Add />}
            >
              Créer une nouvelle balise
            </Button>
          </Link>
        </div>

        <TagsTable />

        <ToastContainer />
      </main>
    </div>
  );
};
export default TagsPage;

export const TagStats = ({ title }) => {
  const [tagStats, setTagStats] = useState({
    totalTags: "...",
    totalClasses: "...",
  });
  const { actualityService } = useContext(AppContext);

  const getTagStats = async () => {
    const response = await actualityService.getTagStats();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      setTagStats(response.data);
    }
  };

  useEffect(() => {
    getTagStats();
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
          name="Total Balises"
          icon={Tags}
          value={tagStats.totalTags}
          color="#6366F1"
        />

        <StatCard
          name="Total Classes"
          icon={Shapes}
          value={tagStats.totalClasses}
          color="#10B981"
        />
      </motion.div>
    </>
  );
};
