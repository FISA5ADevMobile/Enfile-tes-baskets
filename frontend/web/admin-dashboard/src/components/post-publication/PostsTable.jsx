import { useState, useEffect, useContext } from "react";
import DataGridComponent from "../common/DataGridComponent";
import { GridActionsCellItem } from "@mui/x-data-grid";
import SaveIcon from "@mui/icons-material/Save";
import CancelIcon from "@mui/icons-material/Close";
import DeleteIcon from "@mui/icons-material/DeleteOutlined";
import EditIcon from "@mui/icons-material/Edit";
import { PanoramaFishEye, RemoveRedEye } from "@mui/icons-material";
import { motion } from "framer-motion";
import { Search } from "lucide-react";
import { AppContext } from "../../services/context/AppContext";

import { DATA_GRID_COLUMN_DEFAULT_WIDTH } from "../../utils/constants";
import { ToastContainer, toast } from "react-toastify";
import { dispatchToast } from "../../utils/helper";
import { mapPostForDataGrid, mapUserForDataGrid } from "../../utils/mapping";

const columns = [
  {
    field: "id",
    headerName: "ID",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
  },
  {
    field: "content",
    headerName: "Contenu",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "username",
    headerName: "Username",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "datePost",
    headerName: "Publié le",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },

  {
    field: "nbLike",
    headerName: "Nombre de like",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "visible",
    headerName: "Visible",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    editable: false,
  },
  {
    field: "actions",
    type: "actions",
    headerName: "Actions",
    width: DATA_GRID_COLUMN_DEFAULT_WIDTH,
    cellClassName: "actions",
    getActions: ({ id, row }) => {
      return [
        <GridActionsCellItem
          icon={<RemoveRedEye color="success" />}
          label="Voir"
          //showInMenu
          onClick={() => {
            console.log("id : " + id);
            console.log("row : " + JSON.stringify(row));
            window.location.href = `/posts/${id}`;
          }}
        />,
      ];
    },
  },
];

const rows = [
  {
    id: 1,
    description: "description",
    userPseudo: "pseudo",
    datePost: "12/12/12",
    nbLike: 0,
  },
  {
    id: 2,
    description: "description",
    userPseudo: "pseudo",
    datePost: "12/12/12",
    nbLike: 0,
  },
  {
    id: 3,
    description: "description",
    userPseudo: "pseudo",
    datePost: "12/12/12",
    nbLike: 0,
  },
];

const PostsTable = () => {
  const [postsData, setPostsData] = useState([]); // to uncomment during the integration
  // const [postsData, setPostsData] = useState(rows); //to comment during the integration

  const { postService } = useContext(AppContext);

  // to uncomment during the integration

  const getAllPosts = async () => {
    const response = await postService.getAllPosts();
    if (response.error) {
      console.error(response.message);
      dispatchToast("error", response.message);
    } else {
      const posts = response.data;
      setPostsData(posts.map(mapPostForDataGrid));
    }
  };

  useEffect(() => {
    getAllPosts();
  }, []);

  return (
    <motion.div
      // className="bg-gray-800 bg-opacity-50 backdrop-blur-md shadow-lg rounded-xl p-6 border border-gray-700"
      initial={{ opacity: 0, y: 20 }}
      animate={{ opacity: 1, y: 0 }}
      transition={{ delay: 0.2 }}
    >
      <ToastContainer />
      <div>
        <DataGridComponent
          rows={postsData}
          columns={columns}
        />
      </div>
    </motion.div>
  );
};
export default PostsTable;
