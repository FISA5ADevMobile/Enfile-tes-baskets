import {
  Ban,
  MessageCircleCode,
  MessageSquareDashed,
  User,
  UserCheck,
  UserPlus,
  UsersIcon,
  UserX,
} from "lucide-react";
import { motion } from "framer-motion";

import Header from "../../components/common/Header";
import StatCard from "../../components/common/StatCard";
import UsersTable from "../../components/users/UsersTable";
import { dispatchToast } from "../../utils/helper";
import { useContext, useEffect, useState } from "react";
import { AppContext } from "../../services/context/AppContext";
import { ToastContainer } from "react-toastify";
import PostsTable from "../../components/post-publication/PostsTable";

const PostsPage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Posts" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        {/* STATS */}
        <PostStats />

        <PostsTable />

        <ToastContainer />
      </main>
    </div>
  );
};
export default PostsPage;

export const PostStats = ({ title }) => {
  const [postStats, setPostStats] = useState({
    total: "...",
    visible: "...",
    invisible: "...",
  });
  const { postService } = useContext(AppContext);

  const getPostStats = async () => {
    const response = await postService.getPostStats();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      setPostStats(response.data);
    }
  };

  useEffect(() => {
    getPostStats();
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
          name="Total Posts"
          icon={MessageSquareDashed}
          value={postStats.total}
          color="#6366F1"
        />

        <StatCard
          name="Posts Visibles"
          icon={MessageSquareDashed}
          value={postStats.visible}
          color="#22C55E"
        />

        <StatCard
          name="Posts Invisibles (modérés)"
          icon={MessageSquareDashed}
          value={postStats.invisible}
          color="#EF4444"
        />
      </motion.div>
    </>
  );
};
