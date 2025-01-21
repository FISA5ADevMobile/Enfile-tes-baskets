import { BarChart2, ShoppingBag, Users, Zap } from "lucide-react";
import { motion } from "framer-motion";

import Header from "../../components/common/Header";
import StatCard from "../../components/common/StatCard";

import SalesChannelChart from "../../components/overview/SalesChannelChart";
import { UserStats } from "../users/UsersPage";
import { ActualityStats } from "../actualities/ActualitiesPage";
import { CommunityStats } from "../communities/CommunitiesPage";
import { PostStats } from "../post-publication/PostsPage";
import { OrientationCourseStats } from "../orientation-courses/OrientationCoursesPage";

const OverviewPage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Aperçu" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        {/* STATS */}
        <UserStats title={"Utilisateurs"} />

        <ActualityStats title={"Actualités"} />

        <CommunityStats title={"Communautés"} />

        <PostStats title={"Posts"} />

        <OrientationCourseStats title={"Parcours d'orientation"} />
      </main>
    </div>
  );
};
export default OverviewPage;
