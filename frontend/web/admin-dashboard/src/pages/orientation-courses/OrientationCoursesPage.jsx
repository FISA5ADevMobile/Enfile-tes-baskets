import { motion } from "framer-motion";

import Header from "../../components/common/Header";
import StatCard from "../../components/common/StatCard";

import { Shapes, Tags } from "lucide-react";
import { Link } from "react-router-dom";
import { Button } from "@mui/material";
import { Add } from "@mui/icons-material";
import { AppContext } from "../../services/context/AppContext";
import { useState, useContext, useEffect } from "react";
import { ToastContainer } from "react-toastify";
import TagsTable from "../../components/orientation-courses/TagsTable";
import { dispatchToast } from "../../utils/helper";
import ClassesTable from "../../components/orientation-courses/ClassesTable";

const OrientationCoursesPage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Parcours d'orientation" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        {/* STATS */}
        <OrientationCourseStats />

        {/* <ProductsTable /> */}

        <div className="text-2xl font-semibold mt-8">Balises</div>

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

        <div className="text-2xl font-semibold mt-8">Classes</div>

        <div className="flex justify-end mb-4 space-x-4">
          <Link to="/nouvelle-classe">
            <Button
              variant="text"
              startIcon={<Add />}
            >
              Créer une nouvelle classe
            </Button>
          </Link>
        </div>

        <ClassesTable />

        <ToastContainer />
      </main>
    </div>
  );
};
export default OrientationCoursesPage;

export const OrientationCourseStats = ({ title }) => {
  const [tagStats, setTagStats] = useState({
    totalTags: "...",
    totalClasses: "...",
  });
  const { orientationCourseService } = useContext(AppContext);

  const getOrientationCourseStats = async () => {
    const response = await orientationCourseService.getOrientationCourseStats();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      setTagStats(response.data);
    }
  };

  useEffect(() => {
    getOrientationCourseStats();
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
