import {
  Ban,
  LockKeyhole,
  LockOpen,
  MessagesSquare,
  User,
  UserCheck,
  UserPlus,
  UsersIcon,
  UserX,
} from "lucide-react";
import { motion } from "framer-motion";

import { Link } from "react-router-dom";
import { Button } from "@mui/material";
import { Add } from "@mui/icons-material";

import Header from "../../components/common/Header";
import StatCard from "../../components/common/StatCard";
import UsersTable from "../../components/users/UsersTable";
import { dispatchToast } from "../../utils/helper";
import { useContext, useEffect, useState } from "react";
import { AppContext } from "../../services/context/AppContext";
import { ToastContainer } from "react-toastify";
import CommunitiesTable from "../../components/communities/CommunitiesTable";

const CommunitiesPage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Communautés" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        {/* STATS */}
        <CommunityStats />

        <div className="flex justify-end mb-4 space-x-4">
          <Link to="/nouvelle-communaute">
            <Button
              variant="text"
              startIcon={<Add />}
            >
              Créer une nouvelle
            </Button>
          </Link>
        </div>

        <CommunitiesTable />

        <ToastContainer />
      </main>
    </div>
  );
};
export default CommunitiesPage;

export const CommunityStats = ({ title }) => {
  const [communityStats, setCommunityStats] = useState({
    total: "...",
    public: "...",
    private: "...",
  });
  const { communityService } = useContext(AppContext);

  const getCommunityStats = async () => {
    const response = await communityService.getCommunityStats();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      setCommunityStats(response.data);
    }
  };

  useEffect(() => {
    getCommunityStats();
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
          name="Total Communautés"
          icon={MessagesSquare}
          value={communityStats.total}
          color="#6366F1"
        />
        <StatCard
          name="Publique"
          icon={LockOpen}
          value={communityStats.public}
          color="#F59E0B"
        />
        <StatCard
          name="Privée"
          icon={LockKeyhole}
          value={communityStats.private}
          color="#10B981"
        />
      </motion.div>
    </>
  );
};
