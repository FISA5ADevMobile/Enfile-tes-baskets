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

const GuidePage = () => {
  return (
    <div className="flex-1 overflow-auto relative z-10">
      <Header title="Manuel d'utilisation" />

      <main className="max-w-7xl mx-auto py-6 px-4 lg:px-8">
        <div className="mt-4">
          <div className="text-2xl font-semibold mt-8 mb-4">
            Table de données
          </div>

          <iframe
            src="https://scribehow.com/embed/Comment_utiliser_la_Table_de_Donnees__oJCTidCpT1iRtIAoQKtr2w"
            width="100%"
            height="640"
            allowfullscreen
            frameborder="0"
          ></iframe>
        </div>

        <div className="mt-4">
          <div className="text-2xl font-semibold mt-8 mb-4">Actualités</div>

          <iframe
            src="https://scribehow.com/embed/Gestion_des_Actualites__-9mr1CVJSmC_wfwBreryeg"
            width="100%"
            height="640"
            allowfullscreen
            frameborder="0"
          ></iframe>
        </div>

        <div className="mt-4">
          <div className="text-2xl font-semibold mt-8 mb-4">Utilisateurs</div>

          <iframe
            src="https://scribehow.com/embed/Gestion_des_Utilisateurs__j0iJjT-WRUKMnnMrjAqPag"
            width="100%"
            height="640"
            allowfullscreen
            frameborder="0"
          ></iframe>
        </div>

        <div className="mt-4">
          <div className="text-2xl font-semibold mt-8 mb-4">Communautés</div>

          <iframe
            src="https://scribehow.com/embed/Gestion_des_Communaites__5kYBrj1wTOyCKpqZJnhbAA"
            width="100%"
            height="640"
            allowfullscreen
            frameborder="0"
          ></iframe>
        </div>

        <div className="mt-4">
          <div className="text-2xl font-semibold mt-8 mb-4">Posts</div>

          <iframe
            src="https://scribehow.com/embed/Moderation_des_Posts__YYjOlw2sQ5WyqDdU5F5oAw"
            width="100%"
            height="640"
            allowfullscreen
            frameborder="0"
          ></iframe>
        </div>

        <div className="mt-4">
          <div className="text-2xl font-semibold mt-8 mb-4">
            Parcours d'orientation
          </div>

          <iframe
            src="https://scribehow.com/embed/Gestion_des_Balises_et_Classes_du_parcours_dorientation__6GZcDVEPSPWmrtP86Ma-3w"
            width="100%"
            height="640"
            allowfullscreen
            frameborder="0"
          ></iframe>
        </div>
      </main>
    </div>
  );
};
export default GuidePage;
